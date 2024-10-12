import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stress_ducer/model/addedTasks.dart';
import 'package:stress_ducer/model/student.dart';
import 'package:stress_ducer/Home/HomeTabBar/Home/AddTasks/addedTasksCard.dart';
import 'package:stress_ducer/Home/HomeTabBar/TodayTasks/getTodayData.dart';
import 'package:stress_ducer/services/studentDataBase.dart';

class TodayTasks extends StatefulWidget {
  const TodayTasks({super.key, required this.currentContext});

  final BuildContext currentContext;

  @override
  State<TodayTasks> createState() => TodayTasksState();
}

class TodayTasksState extends State<TodayTasks> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final authStudent = dataAuthServices();

  static final List<bool> _enable = [];
  static List<String> enabledList = [];
  List<String> temp = [];
  String enabledListString = "";

  String studentSubjects = "";
  String studentSubjectsPriority = "";
  late List<String> studentSubjectsList = [];
  late List<String> studentSubjectsPriorityList = [];
  static List<String> updateTodaySubjectsList = [];
  static int changeSubjectsCount = 0;

  static List<Map<String, dynamic>> tableDataList = [];

  int k = 0;
  final GetTodayData todayData = GetTodayData();

  @override
  void initState() {
    enableInstall();
    super.initState();
  }

  void getData() {
    String? studentDocumentId = auth.currentUser!.uid;
    Stream<Student?> studentStream =
        dataAuthServices.readSpecificDocument(studentDocumentId);

    studentStream.listen((student) {
      if (student != null) {
        if (mounted == true) {
          setState(() {
            try {
              enabledListString = student.enableStatus.toString();
              enabledListString = enabledListString.substring(
                  1,
                  enabledListString.length -
                      1); // Remove "[" and "]" characters
              temp = enabledListString.split(','); // Split the string by commas

              studentSubjects = student.studentSubjects.toString();
              studentSubjectsPriority =
                  student.studentSubjectsPriority.toString();
              studentSubjectsList = studentSubjects.split(',');
              studentSubjectsPriorityList = studentSubjectsPriority.split(',');

              changeSubjectsCount =
                  int.parse(student.changeSubjectsCount ?? '1');

              tableDataList.clear();
              updateTodaySubjectsList.clear();

              updateTodaySubjectsList = GetTodayData.getTodaySubjects(
                  studentSubjectsList,
                  studentSubjectsPriorityList,
                  tableDataList,
                  changeSubjectsCount);

              _enable.clear();
              for (int i = 0; i < updateTodaySubjectsList.length; i++) {
                _enable.add(false);
              }
            } catch (e) {
              // Handle the parsing error
              print("Error parsing howManySubjects: $e");
            }

            if (!enabledListString.isEmpty) {
              for (int i = 0; i < temp.length; i++) {
                _enable[int.parse(temp[i])] = true;
              }
            }
          });
        }
      }
    });
    enableInstall();
  }

  void enableInstall() {
    _enable.clear();
    for (int i = 0; i < updateTodaySubjectsList.length; i++) {
      _enable.add(false);
    }
  }

  void _alertMsg() {
    Widget okButton = TextButton(
      child: const Text("OK"),
      onPressed: () {
        //  widget.changeTab(0);
        if (mounted) {
          Navigator.of(widget.currentContext).pop();
        }
      },
    );

    AlertDialog alert = AlertDialog(
      title: const Text("You Done For Today !"),
      content: const Text("Ready For Next Day"),
      actions: [
        okButton,
      ],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    if (k < 1) {
      getData();
      k++;
    }

    return ListView(
      children: [
        Card(
          margin: const EdgeInsets.all(0),
          child: Padding(
            padding: EdgeInsets.only(left: screenWidth * 0.05),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: screenHeight * 0.02,
                  ),
                  Text(
                    "Today Tasks",
                    style: GoogleFonts.roboto(
                        fontSize: screenWidth * 0.053,
                        fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: screenHeight * 0.02,
                  ),
                  SizedBox(
                    width: screenWidth * 0.24,
                    height: screenWidth * 0.0625,
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          enabledList.clear();
                          for (int i = 0;
                              i < updateTodaySubjectsList.length;
                              i++) {
                            enabledList.add(i.toString());
                          }
                          authStudent.updateEnables(
                              auth.currentUser!.uid, enabledList.toString());
                          _alertMsg();
                        });
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Theme.of(context).primaryColor,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20))),
                      child: Text(
                        "Done All",
                        style: GoogleFonts.roboto(
                            fontSize: screenWidth * 0.033,
                            fontWeight: FontWeight.w600,
                            color: Colors.white),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: screenHeight * 0.02,
                  )
                ]),
          ),
        ),
        SizedBox(
          height: screenHeight * 0.0025,
        ),
        Divider(
          height: 0.3,
          color: Theme.of(context).indicatorColor,
        ),
        SizedBox(
          height: screenHeight * 0.0025,
        ),
        Card(
          child: ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: updateTodaySubjectsList.length,
            itemBuilder: (context, index) {
              return ListTile(
                enabled: _enable[index],
                // Set icon color based on MaterialState.
                iconColor: MaterialStateColor.resolveWith(
                  (Set<MaterialState> states) {
                    if (states.contains(MaterialState.disabled)) {
                      return Colors.red;
                    }
                    return Theme.of(context).primaryColor;
                  },
                ),
                // This sets text color and icon color to red when list tile is disabled and
                // green when list tile is selected, otherwise sets it to black.
                textColor: MaterialStateColor.resolveWith(
                  (Set<MaterialState> states) {
                    if (states.contains(MaterialState.disabled)) {
                      return Colors.red;
                    }
                    return Theme.of(context).primaryColor;
                  },
                ),
                leading: Icon(Icons.person, size: screenWidth * 0.05),
                title: Text(updateTodaySubjectsList[index].toString()),
                subtitle: Text('Done: ${_enable[index]}',
                    style: GoogleFonts.roboto(
                        fontSize: screenWidth * 0.029,
                        fontWeight: FontWeight.w600)),
                trailing: Switch(
                  onChanged: (bool? value) {
                    setState(() {
                      if (value == true) {
                        enabledList.add(index.toString());
                      } else {
                        enabledList.remove(index.toString());
                      }
                      authStudent.updateEnables(
                          auth.currentUser!.uid, enabledList.toString());
                      _enable[index] = value!;

                      int j = 0;
                      for (int i = 0; i < updateTodaySubjectsList.length; i++) {
                        if (_enable[i] == false) {
                          j++;
                        }
                      }
                      if (j == 0) {
                        _alertMsg();
                      }
                    });
                  },
                  value: _enable[index],
                ),
              );
            },
          ),
        ),
        SizedBox(
          height: screenWidth * 0.01,
        ),
        Card(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              columns: [
                DataColumn(
                    label: Text(
                  'Monday',
                  style: TextStyle(
                    fontSize: screenHeight * 0.016,
                  ),
                )),
                DataColumn(
                    label: Text('Tuesday',
                        style: TextStyle(
                          fontSize: screenHeight * 0.016,
                        ))),
                DataColumn(
                    label: Text('Wednesday',
                        style: TextStyle(
                          fontSize: screenHeight * 0.016,
                        ))),
                DataColumn(
                    label: Text('Thursday',
                        style: TextStyle(
                          fontSize: screenHeight * 0.016,
                        ))),
                DataColumn(
                    label: Text('Friday',
                        style: TextStyle(
                          fontSize: screenHeight * 0.016,
                        ))),
                DataColumn(
                    label: Text('Saturday',
                        style: TextStyle(
                          fontSize: screenHeight * 0.016,
                        ))),
                DataColumn(
                    label: Text('Sunday',
                        style: TextStyle(
                          fontSize: screenHeight * 0.016,
                        ))),
              ],
              rows: tableDataList.map((data) {
                return DataRow(
                  cells: [
                    DataCell(Text(data['Monday'],
                        style: TextStyle(
                          fontSize: screenHeight * 0.016,
                        ))),
                    DataCell(Text(data['Tuesday'],
                        style: TextStyle(
                          fontSize: screenHeight * 0.016,
                        ))),
                    DataCell(Text(data['Wednesday'],
                        style: TextStyle(
                          fontSize: screenHeight * 0.016,
                        ))),
                    DataCell(Text(data['Thursday'],
                        style: TextStyle(
                          fontSize: screenHeight * 0.016,
                        ))),
                    DataCell(Text(data['Friday'],
                        style: TextStyle(
                          fontSize: screenHeight * 0.016,
                        ))),
                    DataCell(Text(data['Saturday'],
                        style: TextStyle(
                          fontSize: screenHeight * 0.016,
                        ))),
                    DataCell(Text(data['Sunday'],
                        style: TextStyle(
                          fontSize: screenHeight * 0.016,
                        ))),
                  ],
                );
              }).toList(),
            ),
          ),
        ),
        SizedBox(
          height: screenHeight * 0.09,
        ),
        AddedTasksCards()
      ],
    );
  }
}
