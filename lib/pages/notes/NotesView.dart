import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:random_string/random_string.dart';

import 'package:note_share/models/NotesModel.dart';
import 'package:note_share/utils/services/FirestoreDatabase.dart';

class NotesView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _NotesViewState();
}

class _NotesViewState extends State<NotesView> {
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
              _noteTitle(),
              _NoteBody(noteBodyController: _noteBodyController),
            ],
          ),
          bottomNavigationBar: _NoteBottomNavBar(),
        ),
      ),
    );
  }

  Future<bool> _onBackExit() {
    final FirestoreDatabase firestoreDatabase =
        Provider.of<FirestoreDatabase>(context, listen: false);

    if (_noteTitleController.text.isNotEmpty ||
        _noteBodyController.text.isNotEmpty) {
      firestoreDatabase.saveUserNote(
        NotesModel(
          noteId: _note != null ? _note.noteId : randomAlphaNumeric(10),
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

// Note title block
  Widget _noteTitle() {
    return Container(
      padding: EdgeInsets.all(8.0),
      child: TextFormField(
        controller: _noteTitleController,
        decoration: InputDecoration(
          hintText: 'Title',
          hintStyle: TextStyle(color: Colors.grey[600]),
          //fillColor: Colors.grey[200],
          //filled: true,
          contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.grey[400], width: 2.0),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.grey[400], width: 2.0),
          ),
        ),
      ),
    );
  }
}

// Note body block
class _NoteBody extends StatefulWidget {
  final TextEditingController noteBodyController;

  _NoteBody({this.noteBodyController});

  @override
  State<StatefulWidget> createState() => _NoteBodyState();
}

class _NoteBodyState extends State<_NoteBody> {
  @override
  Widget build(BuildContext context) {
    return Container(
      //color: Colors.white,
      constraints: BoxConstraints(
        maxHeight: double.infinity,
        maxWidth: double.infinity,
        minHeight: 48.0,
        minWidth: double.infinity,
      ),
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: TextFormField(
        controller: widget.noteBodyController,
        keyboardType: TextInputType.multiline,
        maxLines: null,
        decoration: InputDecoration(
          border: InputBorder.none,
          contentPadding:
              new EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
        ),
      ),
    );
  }
}

class _NoteBottomNavBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      child: new Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(left: 10.0),
            child: IconButton(
              icon: Icon(Icons.add_box),
              color: Colors.grey[800],
              onPressed: () => print('add list'),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 10.0),
            child: IconButton(
              icon: Icon(Icons.delete),
              color: Colors.grey[800],
              onPressed: () => print('deleted'),
            ),
          ),
        ],
      ),
    );
  }
}
