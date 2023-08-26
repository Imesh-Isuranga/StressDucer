import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:stress_ducer/Login/constant/colors.dart';
import 'package:stress_ducer/Login/model/student.dart';
import 'package:stress_ducer/Login/model/studentFirstModel.dart';
import 'package:stress_ducer/Login/services/studentDataBase.dart';

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
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: mainAppBarColor,
          title: const Text("Student Details",style: TextStyle(color: appBarTextColor),),
        ),
        body: Center(
          child: Container(
            child: SingleChildScrollView(
              child: Container(
                margin: EdgeInsets.only(left: 20, right: 30),
                child: Column(
                  children: [
                    const Text(
                      "Enter Your Name :",
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(
                      width: 350,
                      child: TextField(
                        keyboardType: TextInputType.name,
                        controller: controllerStudentName,
                      ),
                    ),
                    const SizedBox(
                      height: 60,
                    ),
                    const Text(
                      "Enter Your University Name :",
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(
                      width: 350,
                      child: TextField(
                        keyboardType: TextInputType.name,
                        controller: controllerStudentUniName,
                      ),
                    ),
                    const SizedBox(
                      height: 60,
                    ),
                    const Text(
                      "Enter Your Current Semester :",
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(
                      width: 40,
                      child: TextField(
                        keyboardType: TextInputType.number,
                        controller: controllerStudentCurrentSem,
                      ),
                    ),
                    const SizedBox(
                      height: 60,
                    ),
                    const Text(
                      "Enter Number Of Subjects U have :",
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(
                      width: 40,
                      child: TextField(
                        keyboardType: TextInputType.number,
                        controller: controllerStudentNumOfSubjects,
                      ),
                    ),
                    const SizedBox(
                      height: 100,
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
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.black)),
                      child: const SizedBox(
                        width: 100,
                        child: Text(
                          'Next',
                          style: TextStyle(fontSize: 20),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}