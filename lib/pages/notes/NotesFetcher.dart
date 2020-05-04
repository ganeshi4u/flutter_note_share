import 'package:flutter/cupertino.dart';

class Note {
  final int noteId;
  final int noteShade;
  final String noteContent;

  Note({
    @required this.noteId,
    this.noteShade = 100,
    this.noteContent = 'ola default',
  });
}

int notesCount = 3;

List<Note> fetchUserNotes() {
  List<Note> userNotes = List();
  for (var i = 0; i < notesCount; i++) {
    userNotes.add(new Note(noteId: i));
  }

  return userNotes;
}

void createNote() {
  notesCount++;
}
