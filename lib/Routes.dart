import 'package:flutter/material.dart';
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
  static const String settings = '/settings';

  static final routes = <String, WidgetBuilder>{
    splash: (BuildContext context) => SplashScreen(),
    login: (BuildContext context) => LoginScreen(),
    //profileSetup: (BuildContext context) => ProfileSetup(),
    notesHome: (BuildContext context) => NotesHome(),
    notesView: (BuildContext context) => NotesView(),
    notesFeed: (BuildContext context) => NotesFeed(),
    settings: (BuildContext context) => SettingsPage(),
  };
}
