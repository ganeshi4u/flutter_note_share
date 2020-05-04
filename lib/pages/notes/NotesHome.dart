import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:note_share/pages/notes/NotesFetcher.dart';
import 'package:note_share/pages/notes/NotesGridView.dart';

class NotesHome extends NotesGridView {
  final VoidCallback logoutCallback;

  NotesHome({
    this.logoutCallback,
  }) : super(
          title: 'Home',
          logoutCallback: logoutCallback,
          notesCallback: userNotesCallback,
        );
}

List<Note> userNotesCallback() {
  List<Note> fetchedNotes = fetchUserNotes();

  return fetchedNotes;
}
