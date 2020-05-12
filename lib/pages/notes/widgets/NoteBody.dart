import 'package:flutter/material.dart';

class NoteBody extends StatefulWidget {
  final TextEditingController noteBodyController;

  NoteBody({this.noteBodyController});

  @override
  State<StatefulWidget> createState() => _NoteBodyState();
}

class _NoteBodyState extends State<NoteBody> {
  @override
  Widget build(BuildContext context) {
    return Container(
      //color: Colors.white,
      constraints: BoxConstraints(
        maxHeight: double.infinity,
        maxWidth: double.infinity,
        minHeight: 48.0,
        minWidth: double.infinity,
      ),
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: TextFormField(
        controller: widget.noteBodyController,
        keyboardType: TextInputType.multiline,
        maxLines: null,
        decoration: InputDecoration(
          border: InputBorder.none,
          contentPadding:
              new EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
        ),
      ),
    );
  }
}
