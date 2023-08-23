import 'package:flutter/material.dart';
import 'package:stress_ducer/student/model/studentFirstModel.dart';
import 'package:stress_ducer/student/remote_data_source/studentDataBase.dart';

class StudentDetailsSecond extends StatefulWidget {
  const StudentDetailsSecond(this.studentFirstModel, {super.key});

  final StudentFirstModel studentFirstModel;
  @override
  State<StudentDetailsSecond> createState() => _StudentDetailsSecondState();
}

class _StudentDetailsSecondState extends State<StudentDetailsSecond> {
  final TextEditingController controllerStudentSubjects =
      TextEditingController();
  final TextEditingController controllerStudentPriority =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    final _authDataBase = dataAuthServices();

    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: const Text("Student Details"),
          ),
          body: Container(
            padding: const EdgeInsets.all(5),
            child: Column(
              children: [
                const Text(
                  "Enter subjects you have:",
                  style: TextStyle(fontSize: 16),
                ),
                TextField(
                  controller: controllerStudentSubjects,
                ),
                const SizedBox(
                  height: 100,
                ),
                const Text(
                  "Enter priority For subjects:",
                  style: TextStyle(fontSize: 16),
                ),
                TextField(
                  controller: controllerStudentPriority,
                ),
                const SizedBox(
                  height: 100,
                ),
                const SizedBox(
                  height: 20,
                ),
                FilledButton(
                    onPressed: () {
                      _authDataBase.update("iKjCeqeWyR7ZOPtIKix9",
                          widget.studentFirstModel,
                          controllerStudentSubjects.text,
                          controllerStudentPriority.text);
                    },
                    child: const Text('Next'))
              ],
            ),
          )),
    );
  }
}
