import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel{
  final uid;
  UserModel({required this.uid});


  factory UserModel.fromSnapshot(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return UserModel(
        uid: snapshot['uid']);
  }

  Map<String,dynamic> toJson()=>{
    "uid":uid,
  };
}