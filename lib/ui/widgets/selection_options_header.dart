import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:nix_notes/core/services/db_service.dart';

class SelectionOptions extends StatefulWidget {
  final List<String> selectedNotesIDs;
  final Function onCancel;
  final String location;

  SelectionOptions({@required this.selectedNotesIDs, this.onCancel, this.location});

  @override
  _SelectionOptionsState createState() => _SelectionOptionsState();
}

class _SelectionOptionsState extends State<SelectionOptions> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData.dark(),
      child: BottomNavigationBar(
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white,
        showUnselectedLabels: true,
        selectedLabelStyle: TextStyle(fontSize: 12),
        unselectedLabelStyle: TextStyle(fontSize: 12),
        type: BottomNavigationBarType.fixed,



        items: [
          // BottomNavigationBarItem(icon: Icon(Icons.share_outlined),label: "Share"),
          widget.location=="Archive"?
          BottomNavigationBarItem(icon: Icon(Icons.unarchive_outlined),label:"Unarchive" ,):
          BottomNavigationBarItem(icon: Icon(Icons.archive_outlined),label: "Archive"),
          widget.location == "Trash"?
          BottomNavigationBarItem(icon: Icon(Icons.restore_from_trash),label:"Restore"):
          BottomNavigationBarItem(icon: Icon(Icons.delete_outlined),label:"Move to Trash"),
          if(widget.location=="Trash")
            BottomNavigationBarItem(icon: Icon(Icons.delete_outlined),label: "Delete")

        ],
        onTap: (index)async{
          print("Index:- $index");
         try{ switch(index){
            // case 0:Fluttertoast.showToast(msg: "Share Functionality will be available soon");
            // break;
            case (1-1): if(widget.location=="Archive")
              for(var id in widget.selectedNotesIDs){
                await DBService.instance.moveNote(noteID: id,moveTo: "Notes",currentLocation: widget.location);
                widget.onCancel();
              }
            else if(widget.location=="Notes")
              for(var id in widget.selectedNotesIDs){
                await DBService.instance.moveNote(noteID: id,moveTo: "Archive",currentLocation: widget.location);
                widget.onCancel();
              }
            break;
            case (2-1): if(widget.location == "Trash")
              for(var id in widget.selectedNotesIDs){
                await DBService.instance.moveNote(noteID: id,moveTo: "Notes",currentLocation: widget.location);
                widget.onCancel();
              }
            else
              for(var id in widget.selectedNotesIDs){
                await DBService.instance.moveNote(noteID: id,moveTo: "Trash",currentLocation: widget.location);
                widget.onCancel();
              }
              break;
            case (3-1):
              for(var id in widget.selectedNotesIDs){
                await DBService.instance.deleteNote(noteID: id,currentLocation: widget.location);
                widget.onCancel();
              }
              break;
          }}
          catch(e){
           log(e);
          }
        },
      ),
    );
  }
}
