import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:stress_ducer/Login/model/addedTasks.dart';

class AddTasksDatabase {
 /*static Stream<List<AddedTasks>> read() {
    final userCollection = FirebaseFirestore.instance.collection("Added Tasks");
    return userCollection.snapshots().map((quesrySnapshot) =>
        quesrySnapshot.docs.map((e) => AddedTasks.fromSnapshot(e)).toList());
  }*/

  static Stream<AddedTasks?> readSpecificDocument(String documentId) {
    final userCollection = FirebaseFirestore.instance.collection("Added Tasks");
    return userCollection.doc(documentId).snapshots().map((documentSnapshot) {
      if (documentSnapshot.exists) {
        return AddedTasks.fromSnapshot(documentSnapshot);
      } else {
        return null; // Return null if the document doesn't exist
      }
    });
  }

 /* Future delete(String documentId) async {
    final userColection = FirebaseFirestore.instance.collection("Added Tasks");
    final docRef = userColection.doc(documentId).delete();
  }*/

 /* Future update(String documentId, AddedTasks addedTasks) async {
    final userColection = FirebaseFirestore.instance.collection("Added Tasks");

    final docRef = userColection.doc(documentId);

    try {
      await docRef.update({
        "list": addedTasks.list,
      });
    } catch (error) {
      print("Some error occure $error");
    }
  }*/

  Future create(AddedTasks addedTasks, String id) async {
    final userColection = FirebaseFirestore.instance.collection("Added Tasks");

    final docRef = userColection.doc(id);

    final newTask = AddedTasks(
            list:addedTasks.list)
        .toJson();

    try {
      await docRef.set(newTask);
    } catch (error) {
      print("Some error occure $error");
    }
  }
}
