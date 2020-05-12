import 'package:flutter/material.dart';
import 'package:note_share/utils/CircularColorLoader.dart';

class CircularProgressColor extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(50),
        child: CircularColorLoader(
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
}
