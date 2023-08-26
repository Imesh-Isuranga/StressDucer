import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:stress_ducer/Login/model/UserModel.dart';
import 'package:stress_ducer/Login/model/student.dart';
import 'package:stress_ducer/Login/model/studentFirstModel.dart';

class dataAuthServices {
  static Stream<List<Student>> read() {
    final userCollection = FirebaseFirestore.instance.collection("students");
    return userCollection.snapshots().map((quesrySnapshot) =>
        quesrySnapshot.docs.map((e) => Student.fromSnapshot(e)).toList());
  }

  static Stream<Student?> readSpecificDocument(String documentId) {
  final userCollection = FirebaseFirestore.instance.collection("students");
  return userCollection.doc(documentId).snapshots().map((documentSnapshot) {
    if (documentSnapshot.exists) {
      return Student.fromSnapshot(documentSnapshot);
    } else {
      return null; // Return null if the document doesn't exist
    }
  });
}


Future delete(String documentId) async {
    final userColection = FirebaseFirestore.instance.collection("students");

    final docRef = userColection.doc(documentId).delete();

    
    
  }



  Future update(String documentId,StudentFirstModel studentFirstModel, String subjects,
      String priority) async {
    final userColection = FirebaseFirestore.instance.collection("students");

    final docRef = userColection.doc(documentId);

    
    try {
      await docRef.update({
          "studentName": studentFirstModel.studentName,
            "studentUniName": studentFirstModel.studentUniName,
            "studentCurrentSem": studentFirstModel.studentCurrentSem,
            "studentNumOfSubjects": studentFirstModel.studentNumOfSubjects,
            "studentSubjects": subjects,
            "studentSubjectsPriority": priority
      });
    } catch (error) {
      print("Some error occure $error");
    }
  }



  Future create(StudentFirstModel studentFirstModel, String subjects,
      String priority,String id) async {
    final userColection = FirebaseFirestore.instance.collection("students");

    final docRef = userColection.doc(id);

    final newStudent = Student(
            studentName: studentFirstModel.studentName,
            studentUniName: studentFirstModel.studentUniName,
            studentCurrentSem: studentFirstModel.studentCurrentSem,
            studentNumOfSubjects: studentFirstModel.studentNumOfSubjects,
            studentSubjects: subjects,
            studentSubjectsPriority: priority)
        .toJson();

    try {
      await docRef.set(newStudent);
    } catch (error) {
      print("Some error occure $error");
    }
  }
}
