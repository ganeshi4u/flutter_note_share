import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:note_share/utils/ColorLoader.dart';
import 'package:note_share/utils/auth.dart';

bool _isLoading;

class LoginScreen extends StatefulWidget {
  final VoidCallback loginCallback;

  LoginScreen({this.loginCallback});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  void initState() {
    _isLoading = false;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Stack(
          children: <Widget>[
            Container(
              height: double.infinity,
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xFF73AEF5),
                    Color(0xFF61A4F1),
                    Color(0xFF478DE0),
                    Color(0xFF398AE5),
                  ],
                  stops: [0.1, 0.4, 0.7, 0.9],
                ),
              ),
            ),
            Container(
              height: double.infinity,
              child: SingleChildScrollView(
                physics: AlwaysScrollableScrollPhysics(),
                padding: EdgeInsets.symmetric(
                  horizontal: 40.0,
                  vertical: 120.0,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Sign In',
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'OpenSans',
                        fontSize: 30.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 30.0),
                    SizedBox(
                      height: 30.0,
                    ),
                    _SignInButton(
                      provider: 'Guest',
                      color: 0xFF929693,
                      icon: 0xe971,
                      loginCallback: widget.loginCallback,
                      showProgressCallback: showProgressCallback,
                    ),
                    _SignInButton(
                      provider: 'Google',
                      color: 0xFF3cba54,
                      icon: 0xea88,
                      loginCallback: widget.loginCallback,
                      showProgressCallback: showProgressCallback,
                    ),
                    _SignInButton(
                      provider: 'Facebook',
                      color: 0xFF3b5998,
                      icon: 0xea90,
                      loginCallback: widget.loginCallback,
                      showProgressCallback: showProgressCallback,
                    ),
                    _showCircularProgress(),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void showProgressCallback() {
    setState(() {});
  }
}

class _SignInButton extends StatelessWidget {
  final String provider;
  final int color;
  final int icon;

  final VoidCallback loginCallback;
  final VoidCallback showProgressCallback;

  _SignInButton({
    @required this.provider,
    @required this.color,
    @required this.icon,
    @required this.loginCallback,
    @required this.showProgressCallback,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 20.0),
      padding: const EdgeInsets.only(left: 20.0, right: 20.0),
      child: new Row(
        children: <Widget>[
          new Expanded(
            child: FlatButton(
              shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(30.0)),
              splashColor: Color(color),
              color: Color(color),
              child: new Row(
                children: <Widget>[
                  new Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: Text(
                      provider,
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  new Expanded(
                    child: Container(),
                  ),
                  new Transform.translate(
                    offset: Offset(15.0, 0.0),
                    child: new Container(
                      padding: const EdgeInsets.all(5.0),
                      child: FlatButton(
                        shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(28.0)),
                        splashColor: Colors.white,
                        color: Colors.white,
                        child: Icon(
                          IconData(icon, fontFamily: 'icomoon'),
                          color: Color(color),
                        ),
                        onPressed: () => _signInButtonHandler(context,
                            provider, showProgressCallback, loginCallback,),
                      ),
                    ),
                  )
                ],
              ),
              onPressed: () => _signInButtonHandler(
                  context, provider, showProgressCallback, loginCallback,),
            ),
          ),
        ],
      ),
    );
  }

  _signInButtonHandler(BuildContext context, String provider,
      VoidCallback showProgressCallback, VoidCallback loginCallback) async {
    FirebaseUser user;

    _isLoading = true;
    showProgressCallback();

    if (provider.contains('Guest')) {
      await guestLogin().then((loggedInUser) {
        if (loggedInUser != null) {
          user = loggedInUser;
          loginCallback();
        }
      }).catchError((loggedInUser) {
        if (loggedInUser == null) {
          print('GoogleSignIn: Something went wrong!');
          _isLoading = false;
          showProgressCallback();
        }
      });
    } else if (provider.contains('Google')) {
      await signInWithGoogle().then((loggedInUser) {
        if (loggedInUser != null) {
          user = loggedInUser;
          loginCallback();
        }
      }).catchError((loggedInUser) {
        if (loggedInUser == null) {
          print('GoogleSignIn: Something went wrong!');
          _isLoading = false;
          showProgressCallback();
        }
      });
    } else if (provider.contains('Facebook')) {
      user = await logInWithFacebook();
      loginCallback();
    }
  }
}

Widget _showCircularProgress() {
  if (_isLoading) {
    print('showing circle');
    return Center(
      child: Padding(
        padding: EdgeInsets.all(50),
        child: ColorLoader(
          colors: [
            Colors.red,
            Colors.green,
            Colors.indigo,
            Colors.pinkAccent,
            Colors.white,
          ],
          duration: Duration(milliseconds: 1200),
        ),
      ),
    );
  }
  print('circle out');
  return Container(height: 0.0, width: 0.0);
}
