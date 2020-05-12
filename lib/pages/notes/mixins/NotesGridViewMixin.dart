import 'package:flutter/material.dart';
import 'package:note_share/pages/notes/mixins/NotesGridView.dart';

mixin NotesGridViewMixin<Page extends NotesGridView>
    on NotesGridViewState<Page> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      left: true,
      right: true,
      bottom: true,
      child: Scaffold(
        body: CustomScrollView(
          slivers: <Widget>[
            sliverAppBar(),
            noteViewsDropdownButton(),
            gridViewStreamBuilder(),
          ],
        ),
        floatingActionButtonLocation: fabLocation(),
        floatingActionButton: fab(),
      ),
    );
  }

  Widget sliverAppBar() => Container();
  Widget noteViewsDropdownButton() => Container();
  Widget gridViewStreamBuilder();
  FloatingActionButtonLocation fabLocation() =>
      FloatingActionButtonLocation.centerFloat;
  Widget fab() => Container();
}
