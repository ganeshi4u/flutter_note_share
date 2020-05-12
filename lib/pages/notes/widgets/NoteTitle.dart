import 'package:flutter/material.dart';

class NoteTitle extends StatelessWidget {
  TextEditingController noteTitleController;

  NoteTitle({this.noteTitleController});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8.0),
      child: TextFormField(
        controller: noteTitleController,
        decoration: InputDecoration(
          hintText: 'Title',
          hintStyle: TextStyle(color: Colors.grey[600]),
          //fillColor: Colors.grey[200],
          //filled: true,
          contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.grey[400], width: 2.0),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.grey[400], width: 2.0),
          ),
        ),
      ),
    );
  }
}
