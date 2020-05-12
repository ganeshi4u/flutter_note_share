import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:note_share/models/NotesModel.dart';
import 'package:note_share/utils/services/FirestoreDatabase.dart';
import 'package:note_share/pages/notes/widgets/NoteBody.dart';
import 'package:note_share/pages/notes/widgets/NoteBottomNavBar.dart';
import 'package:note_share/pages/notes/widgets/NoteTitle.dart';

class NotesView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _NotesViewState();
}

class _NotesViewState extends State<NotesView> {
  String currentDate() => DateTime.now().toIso8601String();

  TextEditingController _noteTitleController;
  TextEditingController _noteBodyController;
  NotesModel _note;

  bool _isFav;
  bool _isPublic;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final NotesModel _noteModel = ModalRoute.of(context).settings.arguments;
    if (_noteModel != null) {
      _note = _noteModel;
    }

    _noteTitleController =
        TextEditingController(text: _note != null ? _note.noteTitle : "");
    _noteBodyController =
        TextEditingController(text: _note != null ? _note.noteContent : "");

    _isFav = _note != null ? _note.isFav : false;
    _isPublic = _note != null ? _note.isPublic : false;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      left: true,
      right: true,
      bottom: true,
      child: WillPopScope(
        onWillPop: _onBackExit,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back_ios,
              ),
              onPressed: () => _onBackExit(),
            ),
            actions: <Widget>[
              Padding(
                padding: EdgeInsets.only(right: 20.0),
                child: GestureDetector(
                  onTap: () {
                    _isFav = !_isFav;
                    setState(() {});
                  },
                  child: _isFav ? Icon(Icons.star) : Icon(Icons.star_border),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 20.0),
                child: GestureDetector(
                  onTap: () {
                    _isPublic = !_isPublic;
                    setState(() {});
                  },
                  child: _isPublic
                      ? Icon(Icons.visibility)
                      : Icon(Icons.visibility_off),
                ),
              ),
            ],
          ),
          body: ListView(
            children: [
              NoteTitle(
                noteTitleController: _noteTitleController,
              ),
              NoteBody(
                noteBodyController: _noteBodyController,
              ),
            ],
          ),
          bottomNavigationBar: NoteBottomNavBar(),
        ),
      ),
    );
  }

  Future<bool> _onBackExit() {
    FirestoreDatabase firestoreDatabase =
        Provider.of<FirestoreDatabase>(context, listen: false);

    if (_noteTitleController.text.isNotEmpty ||
        _noteBodyController.text.isNotEmpty) {
      firestoreDatabase.saveUserNote(
        NotesModel(
          noteId: _note != null ? _note.noteId : currentDate(),
          noteShade: 300,
          noteTitle: _noteTitleController.text,
          noteContent: _noteBodyController.text,
          isFav: _isFav,
          isPublic: _isPublic,
        ),
      );
      print('saving note!!');
    } else {
      print('Empty note!');
    }
    Navigator.of(context).pop(true);
  }

  @override
  void dispose() {
    _noteTitleController.dispose();
    _noteBodyController.dispose();
    super.dispose();
  }
}
