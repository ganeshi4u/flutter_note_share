class FirestorePath {
  static String userNote(String uid, String noteId) => 'users/$uid/notes/$noteId';
  static String userNotes(String uid) => 'users/$uid/notes';
}