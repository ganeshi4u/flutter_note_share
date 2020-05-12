import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:note_share/Routes.dart';
import 'package:note_share/models/NotesModel.dart';
import 'package:note_share/pages/notes/mixins/NotesGridView.dart';
import 'package:note_share/pages/notes/mixins/NotesGridViewMixin.dart';
import 'package:note_share/pages/notes/widgets/NoteCard.dart';
import 'package:provider/provider.dart';

class NotesHome extends NotesGridView {
  NotesHome({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _NotesHomeState();
}

class _NotesHomeState extends NotesGridViewState<NotesHome>
    with NotesGridViewMixin {
  String dropdownValue = 'Home';

  @override
  void initState() {
    super.initState();
    
  }

  @override
  Widget sliverAppBar() {
    return SliverAppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      floating: true,
      leading: GestureDetector(
        onTap: () {
          Navigator.of(context).pushNamed(Routes.notesFeed);
        },
        child: Icon(Icons.dashboard),
      ),
      actions: <Widget>[
        Padding(
          padding: EdgeInsets.only(right: 10.0),
          child: GestureDetector(
            onTap: () {
              Navigator.of(context).pushNamed(Routes.settingsPage);
            },
            child: Icon(
              Icons.settings,
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget noteViewsDropdownButton() {
    List<String> noteViews = ['Home', 'Favourite', 'Public'];

    return SliverToBoxAdapter(
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
    );
  }

  @override
  Widget gridViewStreamBuilder() {
    List<NotesModel> notes = Provider.of<List<NotesModel>>(context);

    if (notes?.isNotEmpty ?? false) {
      if (dropdownValue.contains('Favourite')) {
        notes = Provider.of<List<NotesModel>>(context)
            .where((note) => note.isFav)
            .toList();
      } else if (dropdownValue.contains('Public')) {
        notes = Provider.of<List<NotesModel>>(context)
            .where((note) => note.isPublic)
            .toList();
      }

      return SliverPadding(
        padding: const EdgeInsets.all(10),
        sliver: new SliverStaggeredGrid.countBuilder(
          crossAxisCount: 2,
          itemCount: notes.length,
          itemBuilder: (context, index) => new NoteCard(note: notes[index]),
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
  }

  @override
  Widget fab() {
    return FloatingActionButton.extended(
      elevation: 4,
      icon: const Icon(Icons.note_add),
      label: const Text('New note'),
      onPressed: () {
        Navigator.of(context).pushNamed(
          Routes.notesView,
        );
      },
      tooltip: 'Add a new note',
    );
  }
}
