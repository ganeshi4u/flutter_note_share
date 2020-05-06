import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:note_share/utils/ColorLoader.dart';
import 'package:note_share/utils/providers/AuthProvider.dart';

AuthProvider _authProvider;
final _scaffoldKey = GlobalKey<ScaffoldState>();

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    _authProvider = Provider.of<AuthProvider>(context);

    return Scaffold(
      key: _scaffoldKey,
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
                    _authProvider.status == Status.Authenticating
                        ? Center(
                            child: showCircularProgress(),
                          )
                        : _SignInButton(
                            signInProvider: 'Guest',
                            color: 0xFF929693,
                            icon: 0xe971,
                          ),
                    _SignInButton(
                      signInProvider: 'Google',
                      color: 0xFF3cba54,
                      icon: 0xea88,
                    ),
                    _SignInButton(
                      signInProvider: 'Facebook',
                      color: 0xFF3b5998,
                      icon: 0xea90,
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _SignInButton extends StatelessWidget {
  final String signInProvider;
  final int color;
  final int icon;

  _SignInButton({
    @required this.signInProvider,
    @required this.color,
    @required this.icon,
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
                      signInProvider,
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
                        onPressed: () =>
                            _signInButtonHandler(context, signInProvider),
                      ),
                    ),
                  )
                ],
              ),
              onPressed: () => _signInButtonHandler(context, signInProvider),
            ),
          ),
        ],
      ),
    );
  }

  _signInButtonHandler(BuildContext context, String signInProvider) async {
    if (signInProvider.contains('Guest')) {
      await _authProvider.guestLogin().then(
        (loggedIn) {
          if (loggedIn) {
            _showSnackbar('Guest, Logged In');
          }
        },
      ).catchError(
        () => _showSnackbar('Something went wrong!'),
      );
    } else if (signInProvider.contains('Google')) {
      await _authProvider.signInWithGoogle().then((loggedIn) {
        if (loggedIn) {
          _showSnackbar('Google, Signed In');
        }
      }).catchError(
        () => _showSnackbar('Something went wrong!'),
      );
    } else if (signInProvider.contains('Facebook')) {
      await _authProvider.logInWithFacebook().then((loggedIn) {
        if (loggedIn) {
          _showSnackbar('Facebook, Logged In');
        }
      }).catchError(
        () => _showSnackbar('Something went wrong!'),
      );
    }
  }
}

_showSnackbar(String msg) {
  _scaffoldKey.currentState.showSnackBar(
    SnackBar(
      content: Text(msg),
    ),
  );
}

Widget showCircularProgress() {
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
