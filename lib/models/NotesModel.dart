import 'package:flutter/material.dart';

class NotesModel {
  final int noteShade;
  final String noteId;
  final String noteTitle;
  final String noteContent;

  final bool isFav;
  final bool isPublic;

  NotesModel({
    @required this.noteId,
    this.noteShade,
    this.noteContent,
    this.noteTitle,
    this.isFav,
    this.isPublic,
  });

  factory NotesModel.fromMap(Map<String, dynamic> data, String noteId) {
    if (data == null) {
      return null;
    }

    int noteShade = data['noteShade'];
    String noteTitle = data['noteTitle'];
    String noteContent = data['noteContent'];
    bool isFav = data['isFav'];
    bool isPublic = data['isPublic'];

    return NotesModel(
      noteId: noteId,
      noteShade: noteShade,
      noteTitle: noteTitle,
      noteContent: noteContent,
      isFav: isFav,
      isPublic: isPublic,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'noteShade': noteShade,
      'noteTitle': noteTitle,
      'noteContent': noteContent,
      'isFav': isFav,
      'isPublic': isPublic,
    };
  }
}
