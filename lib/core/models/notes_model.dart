
import 'package:cloud_firestore/cloud_firestore.dart';


class NotesModel{
  String title;
  String body;
  String id;
  bool isSelected;
  Timestamp time;

  NotesModel({this.title,this.body,this.time, this.id, this.isSelected = false});

  factory NotesModel.fromFirestore(QueryDocumentSnapshot snapshot){
    var data = snapshot.data();
    return NotesModel(id: snapshot.id,time: data['time'],body: data['body'],title: data['title']);
  }
}