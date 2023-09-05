import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:stress_ducer/Login/model/timeTable.dart';
import 'package:stress_ducer/Login/screens/Home/HomeTabBar/TodayTasks/timeTableView.dart';
import 'package:stress_ducer/Login/services/studentDataBase.dart';
import 'package:stress_ducer/Login/services/timeTableDataBase.dart';
import 'package:stress_ducer/Login/screens/Home/HomeTabBar/TodayTasks/TodayTasks.dart';

class GetTodayData{
static List<String> getTodaySubjects(
  List<String> updateTodaySubjectsList,
  List<String> studentSubjectsList,
    List<String> studentSubjectsPriorityList,
    List<String> todaySubjectsList,
    List<String> mondayList,
    List<String> tuesdayList,
    List<String> wednesdayList,
    List<String> thursdayList,
    List<String> fridayList,
    List<String> saturdayList,
    List<String> sundayList,
    int howManySubjects,
    TimeTable? _timeTableData,
    TimeTableDataBase timetable,
    FirebaseAuth auth,
    List<Map<String, dynamic>> tableDataList
    ) {

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

   return TimeTableView.getTableView(updateTodaySubjectsList, studentSubjectsList, studentSubjectsPriorityList, todaySubjectsList, mondayList, tuesdayList, wednesdayList, thursdayList, fridayList, saturdayList, sundayList, howManySubjects, _timeTableData, timetable, auth, tableDataList);

  }


}