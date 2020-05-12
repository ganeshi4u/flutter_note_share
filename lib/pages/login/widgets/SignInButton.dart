import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:note_share/utils/providers/AuthProvider.dart';

class SignInButton extends StatelessWidget {
  final String signInProvider;
  final int color;
  final int icon;

  SignInButton({
    @required this.signInProvider,
    @required this.color,
    @required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(builder: (_, authProviderRef, __) {
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
                          onPressed: () => _signInButtonHandler(
                              signInProvider, authProviderRef),
                        ),
                      ),
                    )
                  ],
                ),
                onPressed: () =>
                    _signInButtonHandler(signInProvider, authProviderRef),
              ),
            ),
          ],
        ),
      );
    });
  }

  _signInButtonHandler(
      String signInProvider, AuthProvider _authProvider) async {
    if (signInProvider.contains('Guest')) {
      await _authProvider.guestLogin().catchError(
            (error) => print('Something went wrong!' + error.toString()),
          );
    } else if (signInProvider.contains('Google')) {
      await _authProvider.signInWithGoogle().catchError(
            (error) => print('Something went wrong!' + error.toString()),
          );
    } else if (signInProvider.contains('Facebook')) {
      await _authProvider.logInWithFacebook().catchError(
            (error) => print('Something went wrong!' + error.toString()),
          );
    }
  }
}
