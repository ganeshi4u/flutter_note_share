import 'dart:async';

import 'package:flutter/material.dart';
import 'package:note_share/Routes.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Center(
              child: Text(
                'Note Share',
                style: TextStyle(
                    fontSize: Theme.of(context).textTheme.headline.fontSize),
              ),
            ),
            FlutterLogo(
              size: 128,
            ),
          ],
        ),
      ),
    );
  }

  startTimer() {
    var duration = Duration(milliseconds: 1500);
    return Timer(duration, redirect);
  }

  redirect() async {
    Navigator.of(context).pushReplacementNamed(Routes.notesHome);
  }
}
