import 'package:note_share/pages/notes/NotesFetcher.dart';
import 'package:note_share/pages/notes/NotesGridView.dart';

class NotesHome extends NotesGridView {
  NotesHome()
      : super(
          title: 'Home',
          notesCallback: userNotesCallback,
        );
}

List<Note> userNotesCallback() {
  List<Note> fetchedNotes = fetchUserNotes();

  return fetchedNotes;
}
