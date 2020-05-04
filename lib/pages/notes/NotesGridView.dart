import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:note_share/pages/notes/NoteView.dart';
import 'package:note_share/settings/SettingsPage.dart';
import 'package:note_share/pages/notes/NotesFetcher.dart';

class NotesGridView extends StatefulWidget {
  final String title;
  final VoidCallback logoutCallback;
  final Function notesCallback;

  NotesGridView({
    @required this.title,
    @required this.logoutCallback,
    @required this.notesCallback,
  });

  @override
  State<StatefulWidget> createState() => _NotesGridViewState();
}

class _NotesGridViewState extends State<NotesGridView> {
  List<Widget> _notes;
  List<Note> fetchedNotes;

  int notesSize;

  @override
  void initState() {
    fetchedNotes = fetchUserNotes();
    notesSize = fetchedNotes.length;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final String title = widget.title;
    int notesSize = fetchedNotes.length;
    print(notesSize);

    _notes = new List.generate(
      notesSize,
      (int i) => new NoteWidget(
        key: UniqueKey(),
        userNote: fetchedNotes[i],
      ),
      growable: true,
    );

    return new SafeArea(
      top: false,
      left: false,
      right: false,
      bottom: true,
      child: Scaffold(
        backgroundColor: Colors.grey[200],
        body: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              floating: true,
              iconTheme: IconThemeData(
                color: Colors.grey[800],
              ),
              leading: GestureDetector(
                child: Icon(Icons.dashboard),
              ),
              actions: <Widget>[
                Padding(
                  padding: EdgeInsets.only(right: 10.0),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (BuildContext context) => SettingsPage(
                              logoutCallback: widget.logoutCallback),
                        ),
                      );
                    },
                    child: Icon(
                      Icons.settings,
                    ),
                  ),
                ),
              ],
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Text(
                  'Home',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.grey[800],
                  ),
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.all(10),
              sliver: new SliverStaggeredGrid.countBuilder(
                crossAxisCount: 2,
                itemCount: _notes.length,
                itemBuilder: (context, index) => _notes[index],
                staggeredTileBuilder: (int index) =>
                    new StaggeredTile.count(1, index.isOdd ? 2 : 1),
                crossAxisSpacing: 5,
                mainAxisSpacing: 5,
                //childAspectRatio: MediaQuery.of(context).size.width / MediaQuery.of(context).size.height,
              ),
            ),
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton.extended(
          elevation: 4,
          icon: const Icon(Icons.note_add),
          label: const Text('New note'),
          onPressed: addNote,
          tooltip: 'Add a new note',
        ),
      ),
    );
  }

  void addNote() {
    setState(() {
      fetchedNotes.insert(0, new Note(noteId: 123));
      print(fetchedNotes.asMap());
    });
  }
}

class NoteWidget extends StatefulWidget {
  final Note userNote;
  final Key key;

  NoteWidget({
    this.key,
    this.userNote,
  });

  @override
  State<StatefulWidget> createState() => _NoteWidgetState();
}

class _NoteWidgetState extends State<NoteWidget> {
  @override
  Widget build(BuildContext context) {
    return Card(
      key: widget.key,
      elevation: 5,
      color: Colors.teal[widget.userNote.noteShade],
      child: InkWell(
        splashColor: Colors.blue.withAlpha(30),
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (BuildContext context) => NoteView(),
            ),
          );
        },
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            new ListTile(
              title: Text(
                widget.userNote.noteId.toString(),
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
