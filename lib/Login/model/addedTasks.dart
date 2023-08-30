import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AddedTasks {
  AddedTasks(
      {required this.date,
      required this.time});

  final DateTime? date;
  final TimeOfDay? time;

  factory AddedTasks.fromSnapshot(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return AddedTasks(
        date: snapshot['date'],
        time: snapshot['time']);
  }

  Map<String,dynamic> toJson()=>{
    "date":date,
    "time":time
  };
}
