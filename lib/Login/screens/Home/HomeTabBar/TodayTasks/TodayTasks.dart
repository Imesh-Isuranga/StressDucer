import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stress_ducer/Login/constant/colors.dart';
import 'package:stress_ducer/Login/model/student.dart';
import 'package:stress_ducer/Login/model/timeTable.dart';
import 'package:stress_ducer/Login/screens/Home/HomeTabBar/TodayTasks/getTodayData.dart';
import 'package:stress_ducer/Login/services/studentDataBase.dart';
import 'package:stress_ducer/Login/services/timeTableDataBase.dart';

class TodayTasks extends StatefulWidget {
  const TodayTasks({super.key});

  @override
  State<TodayTasks> createState() => TodayTasksState();
}

class TodayTasksState extends State<TodayTasks> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final timetable = TimeTableDataBase();
  final authStudent = dataAuthServices();
  List<bool> _enable = [];

  String studentSubjects = "";
  String studentSubjectsPriority = "";
  late List<String> studentSubjectsList = [];
  late List<String> studentSubjectsPriorityList = [];

  static List<String> updateTodaySubjectsList = [];
  static List<String> todaySubjectsList = [];
  static List<String> mondayList = [];
  static List<String> tuesdayList = [];
  static List<String> wednesdayList = [];
  static List<String> thursdayList = [];
  static List<String> fridayList = [];
  static List<String> saturdayList = [];
  static List<String> sundayList = [];
  static List<Map<String, dynamic>> tableDataList = [];
  static int howManySubjects = 19;
  int k = 0;

  static List<String> enabledList = [];
  List<String> temp = [];
  String enabledListString = "";

  TimeTable? _timeTableData;

  final GetTodayData todayData = GetTodayData();

  @override
  void initState() {
    enableInstall();
    super.initState();
  }

  void getData() {
    String? studentDocumentId = auth.currentUser!.uid;
    if (studentDocumentId != null) {
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
                temp =
                    enabledListString.split(','); // Split the string by commas

                howManySubjects = int.parse(student.howManySubjects ?? '1');
                studentSubjects = student.studentSubjects.toString();
                studentSubjectsPriority =
                    student.studentSubjectsPriority.toString();
                studentSubjectsList = studentSubjects.split(',');
                studentSubjectsPriorityList =
                    studentSubjectsPriority.split(',');
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
    }
    enableInstall();
  }

  void enableInstall() {
    _enable.clear();
    for (int i = 0; i < howManySubjects; i++) {
      _enable.add(false);
    }
  }

  void _alertMsg() {
    Widget okButton = TextButton(
      child: const Text("OK"),
      onPressed: () {
        Navigator.of(context).pop();
        ;
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
    if (k < 2) {
      getData();
      k++;
    }
    tableDataList.clear();
    updateTodaySubjectsList.clear();
    todaySubjectsList.clear();
    mondayList.clear();
    tuesdayList.clear();
    wednesdayList.clear();
    thursdayList.clear();
    fridayList.clear();
    saturdayList.clear();
    sundayList.clear();
    updateTodaySubjectsList = GetTodayData.getTodaySubjects(updateTodaySubjectsList, studentSubjectsList, studentSubjectsPriorityList, todaySubjectsList, mondayList, tuesdayList, wednesdayList, thursdayList, fridayList, saturdayList, sundayList, howManySubjects, _timeTableData, timetable, auth, tableDataList);

    return Container(
      padding: EdgeInsets.all(0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: background, // Replace with your gradient colors
        ),
      ),
        child: Center(
          child: Column(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Card(
                  margin: EdgeInsets.all(0),
                    child: Container(
                  alignment: Alignment.centerLeft,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            const SizedBox(
                              width: 20,
                            ),
                            Text(
                              "Today Tasks",
                              style: GoogleFonts.roboto(
                                  color: Colors.black,
                                  fontSize: 25,
                                  fontWeight: FontWeight.w600),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            const SizedBox(
                              width: 20,
                            ),
                            OutlinedButton(
                                onPressed: () {
                                  setState(() {
                                    for (int i = 0; i < _enable.length; i++) {
                                      enabledList.add(i.toString());
                                    }
                                    authStudent.updateEnables(
                                        auth.currentUser!.uid,
                                        enabledList.toString());
                                        _alertMsg();
                                  });
                                },
                                child: Text("Done All"),
                                style: ButtonStyle(
                                  shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                          20.0), // Adjust the radius as needed
                                    ),
                                  ),
                                ))
                          ],
                        ),
                        const SizedBox(height: 20,)
                      ]),
                )),
              ),
              SingleChildScrollView(
                child: Card(
                  margin: EdgeInsets.only(left: 0,right: 0,top: 3),
                  child: Container(
                    height: 300, // Set a bounded height
                    child: ListView.builder(
                      itemCount: updateTodaySubjectsList.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          enabled: _enable[index],
                          // This sets text color and icon color to red when list tile is disabled and
                          // green when list tile is selected, otherwise sets it to black.
                          iconColor: MaterialStateColor.resolveWith(
                            (Set<MaterialState> states) {
                              if (states.contains(MaterialState.disabled)) {
                                return Colors.red;
                              }
                              return Colors.black;
                            },
                          ),
                          // This sets text color and icon color to red when list tile is disabled and
                          // green when list tile is selected, otherwise sets it to black.
                          textColor: MaterialStateColor.resolveWith(
                            (Set<MaterialState> states) {
                              if (states.contains(MaterialState.disabled)) {
                                return Colors.red;
                              }
                              return Colors.black;
                            },
                          ),
                          leading: const Icon(Icons.person),
                          title:
                              Text(updateTodaySubjectsList[index].toString()),
                          subtitle: Text('Done: ${_enable[index]}'),
                          trailing: Switch(
                            onChanged: (bool? value) {
                              setState(() {
                                if (value == true) {
                                  enabledList.add(index.toString());
                                } else {
                                  enabledList.remove(index.toString());
                                }
                                authStudent.updateEnables(auth.currentUser!.uid,
                                    enabledList.toString());
                                _enable[index] = value!;

                                int j = 0;
                                for (int i = 0; i < howManySubjects; i++) {
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
                ),
              ),
              Expanded(
                child: Card(
                  margin: EdgeInsets.only(left: 0,right: 0,top: 3),
                  child: Container(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: DataTable(
                          columns: const [
                            DataColumn(label: Text('Monday')),
                            DataColumn(label: Text('Tuesday')),
                            DataColumn(label: Text('Wednesday')),
                            DataColumn(label: Text('Thursday')),
                            DataColumn(label: Text('Friday')),
                            DataColumn(label: Text('Saturday')),
                            DataColumn(label: Text('Sunday')),
                          ],
                          rows: tableDataList.map((data) {
                            return DataRow(
                              cells: [
                                DataCell(Text(data['Monday'])),
                                DataCell(Text(data['Tuesday'])),
                                DataCell(Text(data['Wednesday'])),
                                DataCell(Text(data['Thursday'])),
                                DataCell(Text(data['Friday'])),
                                DataCell(Text(data['Saturday'])),
                                DataCell(Text(data['Sunday'])),
                              ],
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      
    );
  }
}
