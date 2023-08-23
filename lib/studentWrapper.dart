import 'package:flutter/material.dart';
import 'package:stress_ducer/student/StudentDetailsSecond.dart';
import 'package:stress_ducer/student/model/studentFirstModel.dart';
import 'package:stress_ducer/student/studentDetails.dart';

class StudentWrapper extends StatefulWidget {
  const StudentWrapper({super.key});

  @override
  State<StudentWrapper> createState() => _StudentWrapperState();
}

class _StudentWrapperState extends State<StudentWrapper> {
  late Widget currentPage;
  late final StudentFirstModel newStudentFirstModel;


@override
  void initState() {
    currentPage = StudentDetails(stateChange: switchState);
    super.initState();
  }

  void switchState(StudentFirstModel studentFirstModel){
    setState(() {
      newStudentFirstModel = studentFirstModel;
      currentPage = StudentDetailsSecond(newStudentFirstModel);
    });
  }
  @override
  Widget build(BuildContext context) {
    return currentPage;
  }
}