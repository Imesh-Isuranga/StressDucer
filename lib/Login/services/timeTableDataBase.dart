import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:stress_ducer/Login/model/timeTable.dart';

class TimeTableDataBase {
  static Stream<List<TimeTable>> read() {
    final userCollection = FirebaseFirestore.instance.collection("timeTable");
    return userCollection.snapshots().map((quesrySnapshot) =>
        quesrySnapshot.docs.map((e) => TimeTable.fromSnapshot(e)).toList());
  }

  static Stream<TimeTable?> readSpecificDocument(String documentId) {
    final userCollection = FirebaseFirestore.instance.collection("timeTable");
    return userCollection.doc(documentId).snapshots().map((documentSnapshot) {
      if (documentSnapshot.exists) {
        return TimeTable.fromSnapshot(documentSnapshot);
      } else {
        return null; // Return null if the document doesn't exist
      }
    });
  }

  Future delete(String documentId) async {
    final userColection = FirebaseFirestore.instance.collection("timeTable");

    final docRef = userColection.doc(documentId).delete();
  }

  Future update(String documentId, TimeTable timeTable) async {
    final userColection = FirebaseFirestore.instance.collection("timeTable");

    final docRef = userColection.doc(documentId);

    try {
      await docRef.update({
        "monday": timeTable.monday,
        "tuesday": timeTable.tuesday,
        "wednesday": timeTable.wednesday,
        "thursday": timeTable.thursday,
        "friday": timeTable.friday,
        "saturday": timeTable.saturday,
        "sunday": timeTable.sunday,
        "freedays": timeTable.freedays,
        "exam": timeTable.exam,
        "howManySubjectsPerDay":timeTable.howManySubjectsPerDay
      });
    } catch (error) {
      print("Some error occure $error");
    }
  }

  Future create(TimeTable timeTable, String id) async {
    final userColection = FirebaseFirestore.instance.collection("timeTable");

    final docRef = userColection.doc(id);

    final newTimeTable = TimeTable(
            monday: timeTable.monday,
            tuesday: timeTable.tuesday,
            wednesday: timeTable.wednesday,
            thursday: timeTable.thursday,
            friday: timeTable.friday,
            saturday: timeTable.saturday,
            sunday: timeTable.sunday,
            freedays: timeTable.freedays,
            exam: timeTable.exam,
            howManySubjectsPerDay:timeTable.howManySubjectsPerDay)
        .toJson();

    try {
      await docRef.set(newTimeTable);
    } catch (error) {
      print("Some error occure $error");
    }
  }
}
