import 'package:flutter/material.dart';
import 'package:stress_ducer/model/studentFirstModel.dart';
import 'package:stress_ducer/authentication/studentDetails/StudentDetailsSecond.dart';
import 'package:stress_ducer/authentication/studentDetails/studentDetails.dart';

class StudentWrapper extends StatefulWidget {
  const StudentWrapper({super.key,
      required this.refresh});


  final void Function(bool) refresh;

  @override
  State<StudentWrapper> createState() => _StudentWrapperState();
}

class _StudentWrapperState extends State<StudentWrapper> {
  late Widget currentPage;
  late StudentFirstModel newStudentFirstModel;


@override
  void initState() {
    currentPage = StudentDetails(stateChange: switchState);
    super.initState();
  }

  void switchStatBack(){
    setState(() {
      currentPage = StudentDetails(stateChange: switchState);
    });
  }

  void switchState(StudentFirstModel studentFirstModel){
    setState(() {
      newStudentFirstModel = studentFirstModel;
      currentPage = StudentDetailsSecond(newStudentFirstModel, backPress:switchStatBack,refresh:widget.refresh);
    });
  }


  @override
  Widget build(BuildContext context) {
    return currentPage;
  }
}