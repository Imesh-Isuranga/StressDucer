import 'package:flutter/material.dart';
import 'package:stress_ducer/Login/constant/colors.dart';
import 'package:stress_ducer/Login/model/studentFirstModel.dart';
import 'package:stress_ducer/Login/services/studentDataBase.dart';

class StudentDetailsSecond extends StatefulWidget {
  const StudentDetailsSecond(this.studentFirstModel, {super.key,required this.Pressed,required this.idNum,required this.backPress});

  final String idNum;
  final StudentFirstModel studentFirstModel;
  final void Function() Pressed;
  final void Function() backPress;
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
            actions: <Widget>[IconButton(onPressed: (){widget.backPress();}, icon: Icon(Icons.arrow_back_ios_new_sharp))],
            backgroundColor: mainAppBarColor,
            title: const Text("Student Details",style: TextStyle(color: appBarTextColor),),
          ),
          body: Container(
            padding: const EdgeInsets.all(5),
            child: Container(
              margin: EdgeInsets.all(20),
              child: Column(
                children: [
                  const Text(
                    "Enter subjects you have:",
                    style: TextStyle(fontSize: 16),
                  ),
                  TextField(
                    controller: controllerStudentSubjects,
                    keyboardType: TextInputType.text,
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
                    keyboardType: TextInputType.text,
                  ),
                  const SizedBox(
                    height: 100,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  FilledButton(
                      onPressed: () {
                        widget.Pressed();
                        _authDataBase.create(
                            widget.studentFirstModel,
                            controllerStudentSubjects.text,
                            controllerStudentPriority.text,widget.idNum);
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
                      ),)
                ],
              ),
            ),
          )),
    );
  }
}
