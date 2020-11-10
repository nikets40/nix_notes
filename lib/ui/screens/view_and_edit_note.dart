import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nix_notes/core/models/notes_model.dart';
import 'package:nix_notes/core/services/db_service.dart';

class ViewAndEditNoteScreen extends StatefulWidget {
  final NotesModel note;

  ViewAndEditNoteScreen({@required this.note});

  @override
  _ViewAndEditNoteScreenState createState() => _ViewAndEditNoteScreenState();
}

class _ViewAndEditNoteScreenState extends State<ViewAndEditNoteScreen> {
  User user;
  TextEditingController titleController = new TextEditingController();
  TextEditingController bodyTextController = new TextEditingController();
  String originalTitle;
  String originalBody;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    user = FirebaseAuth.instance.currentUser;
    originalTitle = titleController.text = widget.note.title;
    originalBody = bodyTextController.text = widget.note.body;
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData.dark(),
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        appBar: AppBar(
          leading: BackButton(
            onPressed: () {
              if(isDataUpdated())
              Platform.isIOS ? discardDialogIos() : discardDialogAndroid();
              else Navigator.pop(context);
            },
          ),
          elevation: 0,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          centerTitle: false,
          titleSpacing: 0,
          title: Text(
            // "Add Note",
            "Edit Note",
            textScaleFactor: 1.2,
          ),
          actions: [
            Row(
              children: [
                AnimatedOpacity(
                  duration: Duration(milliseconds: 300),
                  opacity: isDataUpdated()?1:0,
                  child: RaisedButton(
                    onPressed: () {
                      NotesModel updatedNote = widget.note;
                      updatedNote.body = bodyTextController.text;
                      updatedNote.title = titleController.text;
                      DBService.instance.editNote(updatedNote);
                      Navigator.of(context).pop();
                    },
                    child: Text("Update"),
                    color: Color(0xff424242),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                ),
                SizedBox(
                  width: 10,
                )
              ],
            )
          ],
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 40,
                ),
                TextField(
                  onChanged: (val){
                    setState(() {});
                  },
                  maxLines: 10,
                  minLines: 1,
                  controller: titleController,
                  style: TextStyle(fontSize: 30),
                  decoration: InputDecoration.collapsed(
                    hintText: "Title",
                  ),
                ),
                SizedBox(
                  height: 35,
                ),
                TextField(
                  onChanged: (_){
                    setState(() {});
                  },
                  maxLines: null,
                  scrollPhysics: NeverScrollableScrollPhysics(),
                  controller: bodyTextController,
                  style: TextStyle(fontSize: 20),
                  decoration: InputDecoration.collapsed(
                    hintText: "Type Something...",
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  discardDialogIos() {
    return showDialog(
        context: context,
        builder: (_) => CupertinoAlertDialog(
              insetAnimationCurve: Curves.decelerate,
              title: Text("Discard"),
              content: Padding(
                padding: const EdgeInsets.only(top: 5.0),
                child: Text("You sure you wanna discard the changes?"),
              ),
              actions: [
                CupertinoDialogAction(
                  child: Text("Yes"),
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.pop(context);
                  },
                ),
                CupertinoDialogAction(
                  child: Text("No"),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                )
              ],
            ));
  }

  discardDialogAndroid() {
    return showDialog(
        context: context,
        builder: (_) => Theme(
              data: ThemeData.dark(),
              child: AlertDialog(
                title: Text("Discard"),
                content: Text("You sure you wanna discard the changes?"),
                actions: [
                  FlatButton(
                    child: Text("Yes"),
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.pop(context);
                    },
                  ),
                  VerticalDivider(),
                  FlatButton(
                    child: Text("No"),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  )
                ],
              ),
            ));
  }

  bool isDataUpdated() {
    if (originalTitle == titleController.text &&
        originalBody == bodyTextController.text) return false;
    return true;
  }
}
