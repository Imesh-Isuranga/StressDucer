import 'package:flutter/material.dart';
import 'package:stress_ducer/Login/model/studentFirstModel.dart';
import 'package:stress_ducer/Login/screens/studentDetails/StudentDetailsSecond.dart';
import 'package:stress_ducer/Login/screens/studentDetails/studentDetails.dart';

class StudentWrapper extends StatefulWidget {
  const StudentWrapper({super.key,required this.pressed,required this.id});

  final String id; 
  final void Function(bool) pressed;

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
      currentPage = StudentDetailsSecond(newStudentFirstModel, Pressed:widget.pressed, idNum:widget.id, backPress:switchStatBack);
    });
  }


  @override
  Widget build(BuildContext context) {
    return currentPage;
  }
}