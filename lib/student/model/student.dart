import 'package:cloud_firestore/cloud_firestore.dart';

class Student {
  Student(
      {required this.studentName,
      required this.studentUniName,
      required this.studentCurrentSem,
      required this.studentNumOfSubjects,
      required this.studentSubjects,
      required this.studentSubjectsPriority});

  final String? studentName;
  final String? studentUniName;
  final String? studentCurrentSem;
  final String? studentNumOfSubjects;
  final String? studentSubjects;
  final String? studentSubjectsPriority;

  factory Student.fromSnapshot(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return Student(
        studentName: snapshot['studentName'],
        studentUniName: snapshot['studentUniName'],
        studentCurrentSem: snapshot['studentCurrentSem'],
        studentNumOfSubjects: snapshot['studentNumOfSubjects'],
        studentSubjects: snapshot['studentSubjects'],
        studentSubjectsPriority: snapshot['studentSubjectsPriority']);
  }

  Map<String,dynamic> toJson()=>{
    "studentName":studentName,
    "studentUniName":studentUniName,
    "studentCurrentSem":studentCurrentSem,
    "studentNumOfSubjects":studentNumOfSubjects,
    "studentSubjects":studentSubjects,
    "studentSubjectsPriority":studentSubjectsPriority
  };
}
