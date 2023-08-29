import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stress_ducer/Login/constant/styles.dart';
import 'package:stress_ducer/Login/model/UserModel.dart';
import 'package:stress_ducer/Login/model/student.dart';
import 'package:stress_ducer/Login/services/studentDataBase.dart';

class StudentProfile extends StatefulWidget {
  const StudentProfile({super.key,required this.text});

  final String text ;

  @override
  State<StudentProfile> createState() => _StudentProfileState();
}

class _StudentProfileState extends State<StudentProfile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      child: Column(
        children: [
          ListTile(
            title: Text(widget.text, style: studentDetailsProfile),
            subtitle: StreamBuilder<Student?>(
              stream: dataAuthServices.readSpecificDocument(Provider.of<UserModel?>(context)!.uid),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text("Error: ${snapshot.error}");
                } else if (snapshot.hasData) {
                  final student = snapshot.data;
                  if (student != null) {
                    String content = '';
                    if (widget.text == "Name : ") {
                      content = student.studentName!;
                    } else if (widget.text == "University : ") {
                      content = student.studentUniName!;
                    } else if (widget.text == "Current Semester : ") {
                      content = student.studentCurrentSem!;
                    } else if (widget.text == "Number Of Subjects : ") {
                      content = student.studentNumOfSubjects!;
                    } else if (widget.text == "Subjects : ") {
                      content = student.studentSubjects!;
                    } else {
                      content = student.studentSubjectsPriority!;
                    }

                    return Text(
                      content,
                      style: studentDetailsProfile,
                    );
                  } else {
                    return Text("Student not found");
                  }
                } else {
                  return Text("No data available");
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
