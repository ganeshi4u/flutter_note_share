import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import 'package:note_share/Routes.dart';
import 'package:note_share/models/NotesModel.dart';

class NotesGridView extends StatefulWidget {
  final String title;
  final Function notesCallback;

  NotesGridView({
    @required this.title,
    @required this.notesCallback,
  });

  @override
  State<StatefulWidget> createState() => _NotesGridViewState();
}

class _NotesGridViewState extends State<NotesGridView> {
  String dropdownValue = 'Home';
  List<String> noteViews = ['Home', 'Favourite', 'Public'];

  @override
  Widget build(BuildContext context) {
    return new SafeArea(
      top: false,
      left: true,
      right: true,
      bottom: true,
      child: Scaffold(
        body: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              floating: true,
              leading: GestureDetector(
                child: Icon(Icons.dashboard),
              ),
              actions: <Widget>[
                Padding(
                  padding: EdgeInsets.only(right: 10.0),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushNamed(Routes.settings);
                    },
                    child: Icon(
                      Icons.settings,
                    ),
                  ),
                ),
              ],
            ),
            SliverToBoxAdapter(
              child: Container(
                padding: EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 10.0),
                      decoration: new BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey,
                            blurRadius: 5.0,
                            offset: Offset(
                              0,
                              5.0,
                            ),
                          ),
                        ],
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton(
                          value: dropdownValue,
                          icon: Icon(Icons.keyboard_arrow_down),
                          iconSize: 24,
                          elevation: 9,
                          isExpanded: false,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                          onChanged: (String newValue) {
                            setState(() {
                              dropdownValue = newValue;
                            });
                          },
                          items: noteViews.map<DropdownMenuItem<String>>(
                            (String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            },
                          ).toList(),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            StreamBuilder(
              stream: widget.notesCallback(context),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  List<NotesModel> userNotes = snapshot.data;
                  List<NotesModel> tempNotes = new List<NotesModel>();
                  if (dropdownValue.contains('Favourite')) {
                    for (var note in userNotes) {
                      if (note.isFav) {
                        tempNotes.add(note);
                      }
                    }
                    userNotes.clear();
                    userNotes = tempNotes.map((note) => note).toList();
                  } else if (dropdownValue.contains('Public')) {
                    for (var note in userNotes) {
                      if (note.isPublic) {
                        tempNotes.add(note);
                      }
                    }
                    userNotes.clear();
                    userNotes = tempNotes.map((note) => note).toList();
                  }
                  if (userNotes.isNotEmpty) {
                    return SliverPadding(
                      padding: const EdgeInsets.all(10),
                      sliver: new SliverStaggeredGrid.countBuilder(
                        crossAxisCount: 2,
                        itemCount: userNotes.length,
                        itemBuilder: (context, index) =>
                            new NoteWidget(userNote: userNotes[index]),
                        staggeredTileBuilder: (int index) =>
                            new StaggeredTile.count(1, index.isOdd ? 2 : 1),
                        crossAxisSpacing: 5,
                        mainAxisSpacing: 5,
                      ),
                    );
                  } else {
                    return SliverToBoxAdapter(
                      child: Center(
                        child: Text('No Notes!'),
                      ),
                    );
                  }
                } else if (snapshot.hasError) {
                  return SliverToBoxAdapter(
                    child: Center(
                      child: Text('Failed to fetch notes!'),
                    ),
                  );
                }
                return SliverToBoxAdapter(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              },
            ),
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton.extended(
          elevation: 4,
          icon: const Icon(Icons.note_add),
          label: const Text('New note'),
          onPressed: () {
            Navigator.of(context).pushNamed(
              Routes.notesView,
            );
          },
          tooltip: 'Add a new note',
        ),
      ),
    );
  }
}

class NoteWidget extends StatefulWidget {
  final NotesModel userNote;

  NoteWidget({
    this.userNote,
  });

  @override
  State<StatefulWidget> createState() => _NoteWidgetState();
}

class _NoteWidgetState extends State<NoteWidget> {
  @override
  Widget build(BuildContext context) {
    return Card(
      key: Key(widget.userNote.noteId),
      elevation: 5,
      color: Colors.grey[widget.userNote.noteShade],
      child: InkWell(
        splashColor: Colors.blue.withAlpha(30),
        onTap: () {
          Navigator.of(context)
              .pushNamed(Routes.notesView, arguments: widget.userNote);
        },
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            new ListTile(
              title: Text(
                widget.userNote.noteTitle,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              subtitle: Text(widget.userNote.noteContent),
            ),
          ],
        ),
      ),
    );
  }
}
