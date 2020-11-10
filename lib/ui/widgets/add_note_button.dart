import 'package:flutter/material.dart';
import 'package:nix_notes/core/services/db_service.dart';
import 'package:nix_notes/ui/screens/new_note_screen.dart';

class AddNoteButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  FloatingActionButton(
      backgroundColor: Color(0xff424242),
      onPressed: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (_)=>CreateNewNote()));
        // for(var title in titles){
        //   DBService.instance.createNote(title, "");
        // }
      },
      child: Icon(
        Icons.add,
        color: Colors.white70,
        size: kToolbarHeight * 0.7,
      ),
    );
  }

  final List<String> titles = [
    "This is your First Note",
    "Man Found Tea Party with Bear again",
    "Pictures of Plants of Garden",
    "Restaurants to try out around town",
    "They ran around the corner to find out that they travelled back in time"
    "Random words"
  ];
  final List<String> subTitles = [

  ];
}
