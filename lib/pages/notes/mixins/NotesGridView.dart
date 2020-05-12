import 'package:flutter/material.dart';

abstract class NotesGridView extends StatefulWidget {
  NotesGridView({Key key}) : super(key: key);
}

abstract class NotesGridViewState<Page extends NotesGridView>
    extends State<Page> {
  String screenName() => "";
}
