import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nix_notes/core/services/db_service.dart';

class CreateNewNote extends StatefulWidget {
  @override
  _CreateNewNoteState createState() => _CreateNewNoteState();
}

class _CreateNewNoteState extends State<CreateNewNote> {
  User user;
  TextEditingController titleController = new TextEditingController();
  TextEditingController bodyTextController = new TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    user = FirebaseAuth.instance.currentUser;
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData.dark(),
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        appBar: AppBar(
          leading: BackButton(
            onPressed: Platform.isIOS ? discardDialogIos : discardDialogAndroid,
          ),
          elevation: 0,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          centerTitle: false,
          title: Text(
            // "Add Note",
            "",
            textScaleFactor: 1.2,
          ),
          actions: [
            Row(
              children: [
                RaisedButton(
                  onPressed: () {
                    DBService.instance.createNote(
                        titleController.text, bodyTextController.text);
                    Navigator.of(context).pop();
                  },
                  child: Text("Save"),
                  color: Color(0xff424242),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
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
          child: Form(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 40,
                ),
                TextFormField(
                  textInputAction: TextInputAction.next,
                  controller: titleController,
                  style: TextStyle(fontSize: 30),
                  maxLines: 20,
                  minLines: 1,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration.collapsed(
                    hintText: "Title",
                  ),
                ),
                SizedBox(height: 20,),
                Text(getDate(Timestamp.now()),style: TextStyle(color: Colors.white.withOpacity(0.3)),),
                SizedBox(height: 20,),
                TextFormField(
                  controller: bodyTextController,
                  autofocus: true,
                  maxLines: null,
                  minLines: 1,
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
                child: Text("You sure you wanna discard this note?"),
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
                content: Text("You sure you wanna discard this note?"),
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

  getDate(Timestamp time){
    DateTime dateTime = time.toDate();
    return "${dateTime.day}/${dateTime.month}/${dateTime.year}";
  }
}
