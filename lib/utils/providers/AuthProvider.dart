import 'dart:convert';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';

import 'package:note_share/models/UserModel.dart';

enum Status {
  Uninitialized,
  Authenticated,
  Authenticating,
  Unauthenticated,
  Registering
}

class AuthProvider extends ChangeNotifier {
  FirebaseAuth _auth;
  GoogleSignIn googleSignIn;
  FacebookLogin facebookLogin;

  Status _status = Status.Uninitialized;
  Status get status => _status;

  Stream<UserModel> get user => _auth.onAuthStateChanged.map(_userData);

  AuthProvider() {
    _auth = FirebaseAuth.instance;
    googleSignIn = GoogleSignIn();
    facebookLogin = FacebookLogin();

    _auth.onAuthStateChanged.listen(onAuthStateChanged);
  }

  UserModel _userData(FirebaseUser user) {
    if (user == null) {
      return null;
    }

    return UserModel(
        uid: user.uid,
        email: user.email,
        displayName: user.displayName,
        photoUrl: user.photoUrl);
  }

  Future<void> onAuthStateChanged(FirebaseUser firebaseUser) async {
    if (firebaseUser == null) {
      _status = Status.Unauthenticated;
    } else {
      _userData(firebaseUser);
      _status = Status.Authenticated;
    }
    notifyListeners();
  }

  Future<bool> guestLogin() async {
    try {
      _status = Status.Authenticating;
      notifyListeners();

      final AuthResult authResult = await _auth.signInAnonymously();
      final FirebaseUser user = authResult.user;

      assert(user.isAnonymous);
      assert(await user.getIdToken() != null);

      final FirebaseUser currentUser = await _auth.currentUser();
      assert(user.uid == currentUser.uid);

      return true;
    } catch (e) {
      print("Error registering guest user" + e.toString());

      _status = Status.Unauthenticated;
      notifyListeners();

      return false;
    }
  }

  Future<bool> signInWithGoogle() async {
    try {
      _status = Status.Authenticating;
      notifyListeners();

      final GoogleSignInAccount googleSignInAccount =
          await googleSignIn.signIn();
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.getCredential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      final AuthResult authResult =
          await _auth.signInWithCredential(credential);
      final FirebaseUser user = authResult.user;

      assert(!user.isAnonymous);
      assert(await user.getIdToken() != null);

      final FirebaseUser currentUser = await _auth.currentUser();
      assert(user.uid == currentUser.uid);

      return true;
    } catch (e) {
      print("Error registering google user" + e.toString());

      _status = Status.Unauthenticated;
      notifyListeners();

      return false;
    }
  }

  // void signOutGoogle() async {
  //   await googleSignIn.signOut();

  //   print("User Sign Out");
  // }

// Facebook login
  Future<bool> logInWithFacebook() async {
    _status = Status.Authenticating;
    notifyListeners();

    final FacebookLoginResult facebookLoginResult =
        await facebookLogin.logIn(['email']);
    final accessToken = facebookLoginResult.accessToken.token;
    final facebookAuthCred =
        FacebookAuthProvider.getCredential(accessToken: accessToken);

    try {
      if (facebookLoginResult.status == FacebookLoginStatus.loggedIn) {
        final AuthResult authResult =
            await _auth.signInWithCredential(facebookAuthCred);
        final FirebaseUser user = authResult.user;

        assert(!user.isAnonymous);
        assert(await user.getIdToken() != null);

        final FirebaseUser currentUser = await _auth.currentUser();
        assert(user.uid == currentUser.uid);

        return true;
      } else {
        throw new FormatException();
      }
    } catch (e) {
      if (e.code == 'ERROR_ACCOUNT_EXISTS_WITH_DIFFERENT_CREDENTIAL')
        return _handleAccountExists(accessToken, facebookAuthCred);

      print("Error registering facebook user" + e.toString());
      _status = Status.Unauthenticated;
      notifyListeners();

      return false;
    }
  }

  // void logOutFacebook() async {
  //   await facebookLogin.logOut();
  // }

  Future<bool> _handleAccountExists(
      String accessToken, AuthCredential facebookAuthCred) async {
    try {
      final HttpClient httpClient = HttpClient();
      final graphRequest = await httpClient.getUrl(Uri.parse(
          "https://graph.facebook.com/v2.12/me?fields=email&access_token=${accessToken}"));
      final graphResponse = await graphRequest.close();
      final graphResponseJSON =
          json.decode((await graphResponse.transform(utf8.decoder).first));

      final email = graphResponseJSON['email'];
      final signInMethods =
          await _auth.fetchSignInMethodsForEmail(email: email);

      if (signInMethods != null) {
        for (var method in signInMethods) {
          if (method == 'google.com') {
            await signInWithGoogle();
            FirebaseUser currentUser = await _auth.currentUser();
            if (currentUser != null) {
              if (currentUser.email == email) {
                await currentUser.linkWithCredential(facebookAuthCred);
                return true;
              } else {
                throw new FormatException();
              }
            } else {
              throw new FormatException();
            }
          } else {
            throw new FormatException();
          }
        }
      } else {
        throw new FormatException();
      }
    } catch (e) {
      print("Error registering facebook user" + e.toString());
      _status = Status.Unauthenticated;
      notifyListeners();

      return false;
    }
  }

  Future signOutUser() async {
    _auth.signOut();
    _status = Status.Unauthenticated;
    notifyListeners();
    print('Logged out user');
    return Future.delayed(Duration.zero);
  }
}
