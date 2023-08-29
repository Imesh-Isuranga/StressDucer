import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:stress_ducer/Login/model/student.dart';
import 'package:stress_ducer/Login/model/timeTable.dart';
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
  int howManySubjects = 9;
  static int num = 1;

  static List<String> enabledList = [];
  List<String> temp = [];
  String enabledListString = "";

  TimeTable? _timeTableData;

  @override
  void initState() {
    enableInstall();
    getData();
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
                enabledListString = enabledListString.substring(1,enabledListString.length -1); // Remove "[" and "]" characters
                temp = enabledListString.split(','); // Split the string by commas

                howManySubjects = int.parse(student.howManySubjects ?? '1');
                studentSubjects = student.studentSubjects.toString();
                studentSubjectsPriority = student.studentSubjectsPriority.toString();
                studentSubjectsList = studentSubjects.split(',');
                studentSubjectsPriorityList = studentSubjectsPriority.split(',');
              } catch (e) {
                // Handle the parsing error
                print("Error parsing howManySubjects: $e");
              }

              if(!enabledListString.isEmpty){
                for(int i=0; i<temp.length; i++){
                  _enable[int.parse(temp[i])]=true;
                }
              }
            });
          }
        }
      });
    }
  }

void enableInstall(){
  _enable.clear();
for (int i = 0; i < howManySubjects; i++) {
      _enable.add(false);
    }
    print(_enable);
}

  @override
  void dispose() {
    // Cancel the stream subscription
    super.dispose();
  }

  void getTodaySubjects() {
    DateTime now = DateTime.now();
    for (int i = 0; i < studentSubjectsList.length; i++) {
      if (studentSubjectsPriorityList[i] == "5") {
        mondayList.add(studentSubjectsList[i]);
      }
      if (studentSubjectsPriorityList[i] == "4") {
        tuesdayList.add(studentSubjectsList[i]);
      }
      if (studentSubjectsPriorityList[i] == "3") {
        wednesdayList.add(studentSubjectsList[i]);
      }
      if (studentSubjectsPriorityList[i] == "2") {
        thursdayList.add(studentSubjectsList[i]);
      }
      if (studentSubjectsPriorityList[i] == "1") {
        fridayList.add(studentSubjectsList[i]);
      }
      if (studentSubjectsPriorityList[i] == "5") {
        saturdayList.add(studentSubjectsList[i]);
      }
      if (studentSubjectsPriorityList[i] == "4") {
        sundayList.add(studentSubjectsList[i]);
      }
    }

    if (mondayList.length > howManySubjects) {
      for (int i = howManySubjects; i < mondayList.length; i++) {
        if (tuesdayList.length < howManySubjects) {
          tuesdayList.add(mondayList[i]);
        } else if (wednesdayList.length < howManySubjects) {
          wednesdayList.add(mondayList[i]);
        } else if (thursdayList.length < howManySubjects) {
          thursdayList.add(mondayList[i]);
        } else if (fridayList.length < howManySubjects) {
          fridayList.add(mondayList[i]);
        } else if (saturdayList.length < howManySubjects) {
          saturdayList.add(mondayList[i]);
        } else if (sundayList.length < howManySubjects) {
          sundayList.add(mondayList[i]);
        }
      }
      int length = mondayList.length;
      for (int i = howManySubjects; i < length; i++) {
        mondayList.removeAt(howManySubjects);
      }
    }

    if (tuesdayList.length > howManySubjects) {
      for (int i = howManySubjects; i < tuesdayList.length; i++) {
        if (wednesdayList.length < howManySubjects) {
          wednesdayList.add(tuesdayList[i]);
        } else if (thursdayList.length < howManySubjects) {
          thursdayList.add(tuesdayList[i]);
        } else if (fridayList.length < howManySubjects) {
          fridayList.add(tuesdayList[i]);
        } else if (saturdayList.length < howManySubjects) {
          saturdayList.add(tuesdayList[i]);
        } else if (sundayList.length < howManySubjects) {
          sundayList.add(tuesdayList[i]);
        } else if (mondayList.length < howManySubjects) {
          mondayList.add(tuesdayList[i]);
        }
      }
      int length = tuesdayList.length;
      for (int i = howManySubjects; i < length; i++) {
        tuesdayList.removeAt(howManySubjects);
      }
    }

    if (wednesdayList.length > howManySubjects) {
      for (int i = howManySubjects; i < wednesdayList.length; i++) {
        if (thursdayList.length < howManySubjects) {
          thursdayList.add(wednesdayList[i]);
        } else if (fridayList.length < howManySubjects) {
          fridayList.add(wednesdayList[i]);
        } else if (saturdayList.length < howManySubjects) {
          saturdayList.add(wednesdayList[i]);
        } else if (sundayList.length < howManySubjects) {
          sundayList.add(wednesdayList[i]);
        } else if (mondayList.length < howManySubjects) {
          mondayList.add(wednesdayList[i]);
        } else if (tuesdayList.length < howManySubjects) {
          tuesdayList.add(wednesdayList[i]);
        }
      }
      int length = wednesdayList.length;
      for (int i = howManySubjects; i < length; i++) {
        wednesdayList.removeAt(howManySubjects);
      }
    }

    if (thursdayList.length > howManySubjects) {
      for (int i = howManySubjects; i < thursdayList.length; i++) {
        if (fridayList.length < howManySubjects) {
          fridayList.add(thursdayList[i]);
        } else if (saturdayList.length < howManySubjects) {
          saturdayList.add(thursdayList[i]);
        } else if (sundayList.length < howManySubjects) {
          sundayList.add(thursdayList[i]);
        } else if (mondayList.length < howManySubjects) {
          mondayList.add(thursdayList[i]);
        } else if (tuesdayList.length < howManySubjects) {
          tuesdayList.add(thursdayList[i]);
        } else if (wednesdayList.length < howManySubjects) {
          wednesdayList.add(thursdayList[i]);
        }
      }
      int length = thursdayList.length;
      for (int i = howManySubjects; i < length; i++) {
        thursdayList.removeAt(howManySubjects);
      }
    }

    if (fridayList.length > howManySubjects) {
      for (int i = howManySubjects; i < fridayList.length; i++) {
        if (saturdayList.length < howManySubjects) {
          saturdayList.add(fridayList[i]);
        } else if (sundayList.length < howManySubjects) {
          sundayList.add(fridayList[i]);
        } else if (mondayList.length < howManySubjects) {
          mondayList.add(fridayList[i]);
        } else if (tuesdayList.length < howManySubjects) {
          tuesdayList.add(fridayList[i]);
        } else if (wednesdayList.length < howManySubjects) {
          wednesdayList.add(fridayList[i]);
        } else if (thursdayList.length < howManySubjects) {
          thursdayList.add(fridayList[i]);
        }
      }
      int length = fridayList.length;
      for (int i = howManySubjects; i < length; i++) {
        fridayList.removeAt(howManySubjects);
      }
    }

    if (saturdayList.length > howManySubjects) {
      for (int i = howManySubjects; i < saturdayList.length; i++) {
        if (sundayList.length < howManySubjects) {
          sundayList.add(saturdayList[i]);
        } else if (mondayList.length < howManySubjects) {
          mondayList.add(saturdayList[i]);
        } else if (tuesdayList.length < howManySubjects) {
          tuesdayList.add(saturdayList[i]);
        } else if (wednesdayList.length < howManySubjects) {
          wednesdayList.add(saturdayList[i]);
        } else if (thursdayList.length < howManySubjects) {
          thursdayList.add(saturdayList[i]);
        } else if (fridayList.length < howManySubjects) {
          fridayList.add(saturdayList[i]);
        }
      }
      int length = saturdayList.length;
      for (int i = howManySubjects; i < length; i++) {
        saturdayList.removeAt(howManySubjects);
      }
    }

    if (sundayList.length > howManySubjects) {
      for (int i = howManySubjects; i < sundayList.length; i++) {
        if (mondayList.length < howManySubjects) {
          mondayList.add(sundayList[i]);
        } else if (tuesdayList.length < howManySubjects) {
          tuesdayList.add(sundayList[i]);
        } else if (wednesdayList.length < howManySubjects) {
          wednesdayList.add(sundayList[i]);
        } else if (thursdayList.length < howManySubjects) {
          thursdayList.add(sundayList[i]);
        } else if (fridayList.length < howManySubjects) {
          fridayList.add(sundayList[i]);
        } else if (saturdayList.length < howManySubjects) {
          saturdayList.add(sundayList[i]);
        }
      }
      int length = sundayList.length;
      for (int i = howManySubjects; i < length; i++) {
        sundayList.removeAt(howManySubjects);
      }
    }

    for (int i = 0; i < studentSubjectsList.length; i++) {
      if (studentSubjectsPriorityList[i] == "4" &&
          mondayList.length < howManySubjects) {
        mondayList.add(studentSubjectsList[i]);
      } else if (studentSubjectsPriorityList[i] == "3" &&
          mondayList.length < howManySubjects) {
        mondayList.add(studentSubjectsList[i]);
      } else if (studentSubjectsPriorityList[i] == "2" &&
          mondayList.length < howManySubjects) {
        mondayList.add(studentSubjectsList[i]);
      } else if (studentSubjectsPriorityList[i] == "1" &&
          mondayList.length < howManySubjects) {
        mondayList.add(studentSubjectsList[i]);
      }

      if (studentSubjectsPriorityList[i] == "5" &&
          tuesdayList.length < howManySubjects) {
        tuesdayList.add(studentSubjectsList[i]);
      } else if (studentSubjectsPriorityList[i] == "3" &&
          tuesdayList.length < howManySubjects) {
        tuesdayList.add(studentSubjectsList[i]);
      } else if (studentSubjectsPriorityList[i] == "2" &&
          tuesdayList.length < howManySubjects) {
        tuesdayList.add(studentSubjectsList[i]);
      } else if (studentSubjectsPriorityList[i] == "1" &&
          tuesdayList.length < howManySubjects) {
        tuesdayList.add(studentSubjectsList[i]);
      }

      if (studentSubjectsPriorityList[i] == "5" &&
          wednesdayList.length < howManySubjects) {
        wednesdayList.add(studentSubjectsList[i]);
      } else if (studentSubjectsPriorityList[i] == "4" &&
          wednesdayList.length < howManySubjects) {
        wednesdayList.add(studentSubjectsList[i]);
      } else if (studentSubjectsPriorityList[i] == "2" &&
          wednesdayList.length < howManySubjects) {
        wednesdayList.add(studentSubjectsList[i]);
      } else if (studentSubjectsPriorityList[i] == "1" &&
          wednesdayList.length < howManySubjects) {
        wednesdayList.add(studentSubjectsList[i]);
      }

      if (studentSubjectsPriorityList[i] == "4" &&
          thursdayList.length < howManySubjects) {
        thursdayList.add(studentSubjectsList[i]);
      } else if (studentSubjectsPriorityList[i] == "3" &&
          thursdayList.length < howManySubjects) {
        thursdayList.add(studentSubjectsList[i]);
      } else if (studentSubjectsPriorityList[i] == "5" &&
          thursdayList.length < howManySubjects) {
        thursdayList.add(studentSubjectsList[i]);
      } else if (studentSubjectsPriorityList[i] == "1" &&
          thursdayList.length < howManySubjects) {
        thursdayList.add(studentSubjectsList[i]);
      }

      if (studentSubjectsPriorityList[i] == "4" &&
          fridayList.length < howManySubjects) {
        fridayList.add(studentSubjectsList[i]);
      } else if (studentSubjectsPriorityList[i] == "3" &&
          fridayList.length < howManySubjects) {
        fridayList.add(studentSubjectsList[i]);
      } else if (studentSubjectsPriorityList[i] == "2" &&
          fridayList.length < howManySubjects) {
        fridayList.add(studentSubjectsList[i]);
      } else if (studentSubjectsPriorityList[i] == "5" &&
          fridayList.length < howManySubjects) {
        fridayList.add(studentSubjectsList[i]);
      }

      if (studentSubjectsPriorityList[i] == "4" &&
          saturdayList.length < howManySubjects) {
        saturdayList.add(studentSubjectsList[i]);
      } else if (studentSubjectsPriorityList[i] == "3" &&
          saturdayList.length < howManySubjects) {
        saturdayList.add(studentSubjectsList[i]);
      } else if (studentSubjectsPriorityList[i] == "2" &&
          saturdayList.length < howManySubjects) {
        saturdayList.add(studentSubjectsList[i]);
      } else if (studentSubjectsPriorityList[i] == "1" &&
          saturdayList.length < howManySubjects) {
        saturdayList.add(studentSubjectsList[i]);
      }

      if (studentSubjectsPriorityList[i] == "5" &&
          sundayList.length < howManySubjects) {
        sundayList.add(studentSubjectsList[i]);
      } else if (studentSubjectsPriorityList[i] == "3" &&
          sundayList.length < howManySubjects) {
        sundayList.add(studentSubjectsList[i]);
      } else if (studentSubjectsPriorityList[i] == "2" &&
          sundayList.length < howManySubjects) {
        sundayList.add(studentSubjectsList[i]);
      } else if (studentSubjectsPriorityList[i] == "1" &&
          sundayList.length < howManySubjects) {
        sundayList.add(studentSubjectsList[i]);
      }
    }

    todaySubjectsList.add(mondayList.toString());
    todaySubjectsList.add(tuesdayList.toString());
    todaySubjectsList.add(wednesdayList.toString());
    todaySubjectsList.add(thursdayList.toString());
    todaySubjectsList.add(fridayList.toString());
    todaySubjectsList.add(saturdayList.toString());
    todaySubjectsList.add(sundayList.toString());
    todaySubjectsList.add(sundayList.toString());
    todaySubjectsList.add(sundayList.toString());
    todaySubjectsList.add(howManySubjects.toString());

    //refreshEnableData();

    final timeTable = TimeTable(
        monday: todaySubjectsList[0],
        tuesday: todaySubjectsList[1],
        wednesday: todaySubjectsList[2],
        thursday: todaySubjectsList[3],
        friday: todaySubjectsList[4],
        saturday: todaySubjectsList[5],
        sunday: todaySubjectsList[6],
        freedays: todaySubjectsList[7],
        exam: todaySubjectsList[8],
        howManySubjectsPerDay: howManySubjects.toString());

    timetable.create(timeTable, auth.currentUser!.uid);

    String subjects;
    if (DateTime.now().weekday == DateTime.monday) {
      subjects = todaySubjectsList[0];
    } else if (DateTime.now().weekday == DateTime.tuesday) {
      subjects = todaySubjectsList[1];
    } else if (DateTime.now().weekday == DateTime.wednesday) {
      subjects = todaySubjectsList[2];
    } else if (DateTime.now().weekday == DateTime.thursday) {
      subjects = todaySubjectsList[3];
    } else if (DateTime.now().weekday == DateTime.friday) {
      subjects = todaySubjectsList[4];
    } else if (DateTime.now().weekday == DateTime.saturday) {
      subjects = todaySubjectsList[5];
    } else {
      subjects = todaySubjectsList[6];
    }

    subjects = subjects.substring(
        1, subjects.length - 1); // Remove "[" and "]" characters
    updateTodaySubjectsList = subjects.split(',');

    for (int i = 0; i < howManySubjects; i++) {
      Map<String, dynamic> tableEntry = {
        'Monday': mondayList != null && i < mondayList.length
            ? mondayList[i]
            : "null",
        'Tuesday': tuesdayList != null && i < tuesdayList.length
            ? tuesdayList[i]
            : "null",
        'Wednesday': wednesdayList != null && i < wednesdayList.length
            ? wednesdayList[i]
            : "null",
        'Thursday': thursdayList != null && i < thursdayList.length
            ? thursdayList[i]
            : "null",
        'Friday': fridayList != null && i < fridayList.length
            ? fridayList[i]
            : "null",
        'Saturday': saturdayList != null && i < saturdayList.length
            ? saturdayList[i]
            : "null",
        'Sunday': sundayList != null && i < sundayList.length
            ? sundayList[i]
            : "null",
      };

      tableDataList.add(tableEntry);
    }
    ;
  }


  void _alertMsg(){
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
    getTodaySubjects();

    

    return Center(
      child: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          const Text(
            "Today Tasks",
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.w900),
          ),
          const SizedBox(
            height: 20,
          ),
          Expanded(
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
                  title: Text(updateTodaySubjectsList[index].toString()),
                  subtitle: Text('Done: ${_enable[index]}'),
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

                        int j=0;
                        for(int i=0; i<howManySubjects; i++){
                          if(_enable[i]==false){
                            j++;
                          }
                        }
                        if(j==0){
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
          Expanded(
            child: Center(
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
        ],
      ),
    );
  }
}
