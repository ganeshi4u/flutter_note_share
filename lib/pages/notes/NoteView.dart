import 'package:flutter/material.dart';

class NoteView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _NoteViewState();
}

class _NoteViewState extends State<NoteView> {
  bool isFav = false;
  bool isPublic = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      left: true,
      right: true,
      bottom: true,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
            ),
            onPressed: () => Navigator.of(context).pop(),
          ),
          actions: <Widget>[
            Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                onTap: () {
                  isFav = !isFav;
                  setState(() {});
                },
                child: isFav ? Icon(Icons.star) : Icon(Icons.star_border),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                onTap: () {
                  isPublic = !isPublic;
                  setState(() {});
                },
                child: isPublic
                    ? Icon(Icons.visibility)
                    : Icon(Icons.visibility_off),
              ),
            ),
          ],
        ),
        body: ListView(
          children: [
            _NoteTitle(),
            _NoteBody(),
          ],
        ),
        bottomNavigationBar: _NoteBottomNavBar(),
      ),
    );
  }
}

// Note title block
class _NoteTitle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8.0),
      child: TextFormField(
        autofocus: false,
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
  @override
  State<StatefulWidget> createState() => _NoteBodyState();
}

class _NoteBodyState extends State<_NoteBody> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8.0),
      child: TextFormField(
        keyboardType: TextInputType.multiline,
        maxLines: null,
        autofocus: false,
        decoration: InputDecoration(
          border: InputBorder.none,
          contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
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
