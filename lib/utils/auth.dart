import 'dart:convert';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final GoogleSignIn googleSignIn = GoogleSignIn();
final FacebookLogin facebookLogin = FacebookLogin();

Future<FirebaseUser> guestLogin() async {
  try {
    final AuthResult authResult = await _auth.signInAnonymously();
    final FirebaseUser user = authResult.user;

    assert(user.isAnonymous);
    assert(await user.getIdToken() != null);

    final FirebaseUser currentUser = await _auth.currentUser();
    assert(user.uid == currentUser.uid);

    return user;
  } on Exception catch(e) {
    print(e.toString());
    return null;
  }
}

Future<FirebaseUser> signInWithGoogle() async {

    final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
    final GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;

    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );

    final AuthResult authResult = await _auth.signInWithCredential(credential);
    final FirebaseUser user = authResult.user;

    assert(!user.isAnonymous);
    assert(await user.getIdToken() != null);

    final FirebaseUser currentUser = await _auth.currentUser();
    assert(user.uid == currentUser.uid);

    return user;
  
}

void signOutGoogle() async {
  await googleSignIn.signOut();

  print("User Sign Out");
}

// Facebook login
Future<FirebaseUser> logInWithFacebook() async {
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

      return user;
    }
  } on PlatformException catch (e) {
    if (e.code == 'ERROR_ACCOUNT_EXISTS_WITH_DIFFERENT_CREDENTIAL')
      return _handleAccountExists(accessToken, facebookAuthCred);
  } on Exception catch (e) {
    print(e.toString());
    return null;
  }
}

void logOutFacebook() async {
  await facebookLogin.logOut();
}

Future<FirebaseUser> _handleAccountExists(
    String accessToken, AuthCredential facebookAuthCred) async {
  final HttpClient httpClient = HttpClient();
  final graphRequest = await httpClient.getUrl(Uri.parse(
      "https://graph.facebook.com/v2.12/me?fields=email&access_token=${accessToken}"));
  final graphResponse = await graphRequest.close();
  final graphResponseJSON =
      json.decode((await graphResponse.transform(utf8.decoder).first));

  final email = graphResponseJSON['email'];
  final signInMethods = await _auth.fetchSignInMethodsForEmail(email: email);

  if (signInMethods != null) {
    for (var method in signInMethods) {
      if (method == 'google.com') {
        var user = await signInWithGoogle();
        if (user.email == email) {
          await user.linkWithCredential(facebookAuthCred);
          return user;
        }
      }
    }
  }
}

Future<FirebaseUser> getCurrentUser() async {
  FirebaseUser user = await _auth.currentUser();
  return user;
}

void signOutUser() async{
  await _auth.signOut();
  print('Logged out user');
}
