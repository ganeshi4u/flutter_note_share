import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:note_share/anims/transitions/SlideRightRoute.dart';
import 'package:note_share/pages/login/LoginScreen.dart';
import 'package:note_share/pages/notes/NotesFeed.dart';
import 'package:note_share/pages/notes/NotesHome.dart';
import 'package:note_share/pages/notes/NotesView.dart';
import 'package:note_share/pages/splash/SplashScreen.dart';
import 'package:note_share/settings/SettingsPage.dart';

class Routes {
  Routes._();

  static const String splash = '/splash';
  static const String login = '/login';
  static const String profileSetup = '/profileSetup';
  static const String notesHome = '/notesHome';
  static const String notesView = '/notesView';
  static const String notesFeed = '/notesFeed';
  static const String settingsPage = '/settings';

  // static final routes = <String, dynamic>{
  //   splash: (BuildContext context) => SplashScreen(),
  //   login: (BuildContext context) => LoginScreen(),
  //   //profileSetup: (BuildContext context) => ProfileSetup(),
  //   notesHome: CupertinoPageRoute(builder: (BuildContext context) => NotesHome()),
  //   notesView: CupertinoPageRoute(builder: (BuildContext context) => NotesView()),
  //   notesFeed: CupertinoPageRoute(builder: (BuildContext context) => NotesFeed(),),
  //   settings: CupertinoPageRoute(builder: (BuildContext context) => SettingsPage()),
  // };

  static routes(RouteSettings settings) {
    switch (settings.name) {
      case splash:
        return CupertinoPageRoute(builder: (BuildContext context) => SplashScreen(), settings: settings);
      case login:
        return CupertinoPageRoute(builder: (BuildContext context) => LoginScreen(), settings: settings);
      // case profileSetup:
      //   return CupertinoPageRoute(builder: (BuildContext context) => ProfileSetup(), settings: settings);
      case notesHome:
        return CupertinoPageRoute(builder: (BuildContext context) => NotesHome(), settings: settings);
      case notesView:
        return CupertinoPageRoute(builder: (BuildContext context) => NotesView(), settings: settings);
      case notesFeed:
        return SlideRightRoute(page: NotesFeed());
      case settingsPage:
        return CupertinoPageRoute(builder: (BuildContext context) => SettingsPage(), settings: settings);
    }
  }
}
