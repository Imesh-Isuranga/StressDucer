import 'package:firebase_auth/firebase_auth.dart';

class TimeTableView{

static List<String> getTableView(
  List<String> updateTodaySubjectsList,
  List<String> studentSubjectsList,
    List<String> studentSubjectsPriorityList,
    List<String> todaySubjectsList,
    List<List<String>> dayList,
    FirebaseAuth auth,
    List<Map<String, dynamic>> tableDataList,
    int changeSubjectsCount
    ) {

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

   
    for (int i = 0; i < dayList[0].length; i++) {
      Map<String, dynamic> tableEntry = {
        'Monday': dayList[0] != null && i < dayList[0].length
            ? dayList[0][i]
            : "null",
        'Tuesday': dayList[1] != null && i < dayList[1].length
            ? dayList[1][i]
            : "null",
        'Wednesday': dayList[2] != null && i < dayList[2].length
            ? dayList[2][i]
            : "null",
        'Thursday': dayList[3] != null && i < dayList[3].length
            ? dayList[3][i]
            : "null",
        'Friday': dayList[4] != null && i < dayList[4].length
            ? dayList[4][i]
            : "null",
        'Saturday': dayList[5] != null && i < dayList[5].length
            ? dayList[5][i]
            : "null",
        'Sunday': dayList[6] != null && i < dayList[6].length
            ? dayList[6][i]
            : "null",
      };

      tableDataList.add(tableEntry);
}

 subjects = subjects.substring(
        1, subjects.length - 1); // Remove "[" and "]" characters
   updateTodaySubjectsList = subjects.split(',');
   for (int i = 0; i < updateTodaySubjectsList.length; i++) {
     if(updateTodaySubjectsList[i]==" "){
      updateTodaySubjectsList.removeAt(i);
      i--;
     }
   }
        return updateTodaySubjectsList;
}}