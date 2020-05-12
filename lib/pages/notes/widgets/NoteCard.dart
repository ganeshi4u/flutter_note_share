import 'package:flutter/material.dart';
import 'package:note_share/Routes.dart';
import 'package:note_share/models/NotesModel.dart';

class NoteCard extends StatefulWidget {
  final NotesModel note;

  NoteCard({
    this.note,
  });

  @override
  State<StatefulWidget> createState() => _NoteCardState();
}

class _NoteCardState extends State<NoteCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      key: Key(widget.note.noteId),
      elevation: 5,
      color: Colors.grey[widget.note.noteShade],
      child: InkWell(
        splashColor: Colors.blue.withAlpha(30),
        onTap: () {
          Navigator.of(context)
              .pushNamed(Routes.notesView, arguments: widget.note);
        },
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            new ListTile(
              title: Text(
                widget.note.noteTitle,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              subtitle: Text(widget.note.noteContent),
            ),
          ],
        ),
      ),
    );
  }
}