import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:note_share/utils/providers/AuthProvider.dart';
import 'package:note_share/pages/login/widgets/SignInButton.dart';
import 'package:note_share/widgets/CircularProgressColor.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    AuthProvider _authProvider = Provider.of<AuthProvider>(context);

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
                            child: CircularProgressColor(),
                          )
                        : Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              SignInButton(
                                signInProvider: 'Guest',
                                color: 0xFF929693,
                                icon: 0xe971,
                              ),
                              SignInButton(
                                signInProvider: 'Google',
                                color: 0xFF3cba54,
                                icon: 0xea88,
                              ),
                              SignInButton(
                                signInProvider: 'Facebook',
                                color: 0xFF3b5998,
                                icon: 0xea90,
                              ),
                            ],
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
