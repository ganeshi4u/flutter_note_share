import 'package:flutter/cupertino.dart';
import 'package:note_share/pages/notes/NotesGridView.dart';
import 'package:note_share/utils/services/FirestoreDatabase.dart';
import 'package:provider/provider.dart';

class NotesHome extends NotesGridView {     
  NotesHome()
      : super(
          title: 'Home',
          notesCallback: userNotesCallback,
        );
}

Stream<dynamic> userNotesCallback(BuildContext context) {
  final FirestoreDatabase firestoreDatabase =
        Provider.of<FirestoreDatabase>(context, listen: false);

  return firestoreDatabase.userNotesStream();
}