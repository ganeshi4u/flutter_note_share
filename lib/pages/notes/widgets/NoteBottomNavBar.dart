import 'package:flutter/material.dart';

class NoteBottomNavBar extends StatelessWidget {
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
