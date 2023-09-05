import 'package:firebase_auth/firebase_auth.dart';
import 'package:stress_ducer/Login/model/timeTable.dart';
import 'package:stress_ducer/Login/services/timeTableDataBase.dart';

class TimeTableView{

static List<String> getTableView(
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

 subjects = subjects.substring(
        1, subjects.length - 1); // Remove "[" and "]" characters
   return updateTodaySubjectsList = subjects.split(',');

}}