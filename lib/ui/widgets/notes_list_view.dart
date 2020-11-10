import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:nix_notes/core/models/notes_model.dart';
import 'package:nix_notes/ui/screens/view_and_edit_note.dart';

class NotesListView extends StatefulWidget {
  final List<NotesModel> notes;
  final bool isSelectionModeActive;
  final Function(int) onSelected;

  NotesListView(
      {this.notes, this.onSelected, this.isSelectionModeActive = false});

  @override
  _NotesListViewState createState() => _NotesListViewState();
}

class _NotesListViewState extends State<NotesListView>
    with SingleTickerProviderStateMixin {
  User user;
  var isSelected = false;
  List<Color> colorsArray = [
    Color(0xffD6A5D6),
    Color(0xffB4D7FF),
    Color(0xffB6e384),
    Color(0xffFFC463),
    Color(0xff90CEB4),
    Color(0xffEEE572),
  ];

  @override
  Widget build(BuildContext context) {
    return StaggeredGridView.countBuilder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      padding: EdgeInsets.all(0),
      crossAxisCount: 2,
      itemCount: widget.notes?.length ?? 0,
      itemBuilder: (BuildContext context, int index) {
        return AnimationConfiguration.staggeredList(
          position: index,
          duration: const Duration(milliseconds: 375),
          child: SlideAnimation(
            verticalOffset: 50.0,
            child: FadeInAnimation(
                child: NoteViewContainer(
              note: widget.notes[index],
              onSelected: () {
                widget.onSelected(index);
              },
              bgColor: colorsArray[index.remainder(colorsArray.length)],
              isSelectionModeActive: widget.isSelectionModeActive,
            )),
          ),
        );
      },
      staggeredTileBuilder: (int index) =>
          new StaggeredTile.count((index + 1) % 3 == 0 ? 2 : 1, 1),
      mainAxisSpacing: 8.0,
      crossAxisSpacing: 8.0,
    );
  }
}

class NoteViewContainer extends StatefulWidget {
  final NotesModel note;
  final Color bgColor;
  final Function() onSelected;
  final bool isSelectionModeActive;

  NoteViewContainer(
      {@required this.note,
      this.onSelected,
      this.isSelectionModeActive = false,
      this.bgColor});

  @override
  _NoteViewContainerState createState() => _NoteViewContainerState();
}

class _NoteViewContainerState extends State<NoteViewContainer> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  Color headingColor = Color(0xff1c1c1e);
  Color subheadingColor = Color(0xff48484a);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (widget.note.isSelected || widget.isSelectionModeActive)
          ? () {
              widget.onSelected();
            }
          : () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (_) => ViewAndEditNoteScreen(
                        note: widget.note,
                      )));
            },
      onLongPress: () {
        widget.onSelected();
      },
      child: Container(
          height: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              color: widget.bgColor,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                  color: widget.note.isSelected
                      ? Colors.redAccent
                      : Colors.white.withOpacity(0.5),
                  width: widget.note.isSelected ? 5 : 0)),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.note.title,
                  textScaleFactor: 1.4,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      color: headingColor, fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(widget.note.body,
                    textScaleFactor: 1,
                    maxLines: 4,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: subheadingColor)),
                Spacer(),
                Text(
                  getDate(widget.note.time),
                  style: TextStyle(color: subheadingColor),
                )
              ],
            ),
          )),
    );
  }

  getDate(Timestamp time) {
    DateTime dateTime = time.toDate();
    return "${dateTime.day}/${dateTime.month}/${dateTime.year}";
  }
}
