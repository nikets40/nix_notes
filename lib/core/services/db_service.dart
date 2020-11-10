
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:nix_notes/core/models/notes_model.dart';

class DBService{
  static DBService instance = DBService();

  FirebaseFirestore _db;
  var _userCollections = "Users";

  DBService() {
    _db = FirebaseFirestore.instance;
  }
  Future<void> createUserInDB(User user) async {
    print(user.uid);
    if(!(await checkUserExist(user.uid))){
      try {
        return await _db.collection(_userCollections).doc(user.uid).set({
          "name": user.displayName,
        });
      } catch (e) {
        print(e);
      }
    }
    else log("User already exists!");

  }

   Future<bool> checkUserExist(String docID) async {
    try{
      var _userRef = await  _db.collection("Users").doc(docID).get();
      if(_userRef.exists)
        return true;
      else return false;
    }
    catch(e){
      log(e);
    }

  }

  Stream<List<NotesModel>>fetchNotes(String location){
      String userID = FirebaseAuth.instance.currentUser.uid;
      var _ref = _db.collection(_userCollections).doc(userID).collection(location).orderBy('time').snapshots();
      var stream =  _ref.map((event) => event.docs.map((e) => NotesModel.fromFirestore(e)).toList());
      return stream;
  }

   createNote(title,body){
     var userID = FirebaseAuth.instance.currentUser.uid;
    try{
       _db.collection(_userCollections).doc(userID).collection("Notes").add({
        "title":title,
        "body":body,
         "time":Timestamp.now()
      });
    }
    catch(e){log(e);}
  }

  editNote(NotesModel note){
    var userID = FirebaseAuth.instance.currentUser.uid;
    try{
      _db.collection(_userCollections).doc(userID).collection("Notes").doc(note.id).update({
        "title":note.title,
        "body":note.body,
        "time":Timestamp.now()
      });
    }
    catch(e){log(e);}
  }

  moveNote({String noteID, String moveTo, String currentLocation})async{
    var userID = FirebaseAuth.instance.currentUser.uid;
    try{
      var doc = await _db.collection(_userCollections).doc(userID).collection(currentLocation).doc(noteID).get();
      _db.collection(_userCollections).doc(userID).collection(moveTo).add(doc.data());
      _db.collection(_userCollections).doc(userID).collection(currentLocation).doc(noteID).delete();
    }catch(e){}
  }

  deleteNote({String noteID, String currentLocation}){
    var userID = FirebaseAuth.instance.currentUser.uid;
    try{
      _db.collection(_userCollections).doc(userID).collection(currentLocation).doc(noteID).delete();
    }catch(e){}
  }


}