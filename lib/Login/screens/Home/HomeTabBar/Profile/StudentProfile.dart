import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
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
    return Card(
      child: Column(
          children: [
            ListTile(
              title: SizedBox(width: MediaQuery.of(context).size.width, 
              child: Card(
                elevation: 0,
                child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Text(widget.text, style: GoogleFonts.roboto(fontSize: MediaQuery.of(context).size.width*0.048,fontWeight: FontWeight.w300)),
              ))),
              subtitle: StreamBuilder<Student?>(
                stream: dataAuthServices.readSpecificDocument(Provider.of<UserModel?>(context)!.uid),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Text("Loading...");
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
                      return Padding(
                        padding: const EdgeInsets.only(left:17,bottom: 10),
                        child: Text(
                          content,
                          style: GoogleFonts.roboto(fontSize: MediaQuery.of(context).size.width*0.04,),
                        ),
                      );
                    } else {
                      return const Text("Student not found");
                    }
                  } else {
                    return const Text("No data available");
                  }
                },
              ),
            ),
          ],
        ),
    );
  }
}
