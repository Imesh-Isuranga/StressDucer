import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:stress_ducer/student/model/student.dart';
import 'package:stress_ducer/student/model/studentFirstModel.dart';
import 'package:stress_ducer/student/remote_data_source/studentDataBase.dart';

class StudentDetails extends StatefulWidget {
  const StudentDetails({super.key, required this.stateChange});

  final Function(StudentFirstModel studentFirstModel) stateChange;

  @override
  State<StudentDetails> createState() => _StudentDetailsState();
}

class _StudentDetailsState extends State<StudentDetails> {
  final TextEditingController controllerStudentName = TextEditingController();
  final TextEditingController controllerStudentUniName =
      TextEditingController();
  final TextEditingController controllerStudentCurrentSem =
      TextEditingController();
  final TextEditingController controllerStudentNumOfSubjects =
      TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    controllerStudentName.dispose();
    controllerStudentUniName.dispose();
    controllerStudentCurrentSem.dispose();
    controllerStudentNumOfSubjects.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Student Details"),
        ),
        body: Center(
          child: Container(
            padding: const EdgeInsets.only(left: 15, right: 15),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Text(
                    "Enter Your Name :",
                    style: TextStyle(fontSize: 16),
                  ),
                  TextField(
                    controller: controllerStudentName,
                  ),
                  const SizedBox(
                    height: 100,
                  ),
                  const Text(
                    "Enter Your University Name :",
                    style: TextStyle(fontSize: 16),
                  ),
                  TextField(
                    controller: controllerStudentUniName,
                  ),
                  const SizedBox(
                    height: 100,
                  ),
                  const Text(
                    "Enter Your Current Semester :",
                    style: TextStyle(fontSize: 16),
                  ),
                  TextField(
                    controller: controllerStudentCurrentSem,
                  ),
                  const SizedBox(
                    height: 100,
                  ),
                  const Text(
                    "Enter Number Of Subjects U have :",
                    style: TextStyle(fontSize: 16),
                  ),
                  TextField(
                    controller: controllerStudentNumOfSubjects,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  FilledButton(
                      onPressed: () {
                        widget.stateChange(StudentFirstModel(
                            studentName: controllerStudentName.text,
                            studentUniName: controllerStudentUniName.text,
                            studentCurrentSem: controllerStudentCurrentSem.text,
                            studentNumOfSubjects:
                                controllerStudentNumOfSubjects.text));
                      },
                      child: const Text('Next'))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
