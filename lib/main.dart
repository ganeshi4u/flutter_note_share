import 'package:flutter/material.dart';
import 'package:note_share/RootPage.dart';

void main(List<String> args) {
  runApp(NoteShare());
}

class NoteShare extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Smart Notes Login',
      debugShowCheckedModeBanner: false,
      home: new RootPage(),
    );
  }
}
