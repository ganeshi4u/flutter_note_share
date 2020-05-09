import 'package:flutter/material.dart';
import 'package:note_share/Routes.dart';
import 'package:note_share/constants/AppThemes.dart';
import 'package:note_share/models/UserModel.dart';
import 'package:note_share/pages/login/LoginScreen.dart';
import 'package:note_share/pages/splash/SplashScreen.dart';
import 'package:note_share/utils/AuthWidgetBuilder.dart';
import 'package:note_share/utils/providers/AuthProvider.dart';
import 'package:note_share/utils/providers/ThemeProvider.dart';
import 'package:note_share/utils/services/FirestoreDatabase.dart';
import 'package:provider/provider.dart';

class NoteShare extends StatelessWidget {
  const NoteShare({Key key, this.databaseBuilder}) : super(key: key);
  final FirestoreDatabase Function(BuildContext context, String uid)
      databaseBuilder;

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(builder: (_, themeProviderRef, __) {
      return AuthWidgetBuilder(
        databaseBuilder: databaseBuilder,
        builder: (BuildContext context, AsyncSnapshot<UserModel> userSnapshot) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Notes',
            routes: Routes.routes,
            theme: AppThemes.lightTheme,
            darkTheme: AppThemes.darkTheme,
            themeMode: themeProviderRef.isDarkModeOn
                ? ThemeMode.dark
                : ThemeMode.light,
            home: Consumer<AuthProvider>(builder: (_, authProviderRef, __) {
              if (userSnapshot.connectionState == ConnectionState.active) {
                return userSnapshot.hasData ? SplashScreen() : LoginScreen();
              }

              return Material(
                child: showCircularProgress(),
              );
            }),
          );
        },
      );
    });
  }
}
