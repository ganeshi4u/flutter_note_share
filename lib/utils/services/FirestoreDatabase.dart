import 'package:flutter/material.dart';
import 'package:note_share/utils/services/FirestoreService.dart';

class FirestoreDatabase {
  FirestoreDatabase({@required this.uid}) : assert(uid != null);
  final String uid;

  final _firestoreService = FirestoreService.instance;
}