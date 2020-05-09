import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:note_share/models/NotesModel.dart';
import 'package:note_share/utils/services/FirestorePath.dart';
import 'package:note_share/utils/services/FirestoreService.dart';

class FirestoreDatabase {
  FirestoreDatabase({@required this.uid}) : assert(uid != null);
  final String uid;

  final _firestoreService = FirestoreService.instance;

  Future<void> saveUserNote(NotesModel note) async =>
      await _firestoreService.setData(
        path: FirestorePath.userNote(uid, note.noteId),
        data: note.toMap(),
      );

  Stream<List<NotesModel>> userNotesStream() =>
      _firestoreService.collectionStream(
        path: FirestorePath.userNotes(uid),
        builder: (data, noteId) => NotesModel.fromMap(data, noteId),
      );

  Stream<List<NotesModel>> userFavNotesStream() =>
      _firestoreService.collectionStream(
        path: FirestorePath.userNotes(uid),
        builder: (data, noteId) => NotesModel.fromMap(data, noteId),
        queryBuilder: (query) => Firestore.instance
            .collection(FirestorePath.userNotes(uid))
            .where('isFav', isEqualTo: true),
      );
}
