import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:stress_ducer/Login/model/timeTable.dart';
import 'package:stress_ducer/Login/screens/Home/HomeTabBar/TodayTasks/timeTableView.dart';
import 'package:stress_ducer/Login/services/studentDataBase.dart';
import 'package:stress_ducer/Login/services/timeTableDataBase.dart';

class GetTodayData{

static List<String> getTodaySubjects(
  List<String> updateTodaySubjectsList,
  List<String> studentSubjectsList,
    List<String> studentSubjectsPriorityList,
    List<String> todaySubjectsList,

    List<List<String>> dayList,

    int howManySubjects,
    TimeTable? _timeTableData,
    TimeTableDataBase timetable,
    FirebaseAuth auth,
    List<Map<String, dynamic>> tableDataList
    ) {

    List<int> intPriorities = []; //To store priorities 
    
    List<String> priority4AND5 =[];
    List<String> priority2AND3 =[];
    List<String> priority1 =[];
    int mondayTotalPriority =0;
    int tuesdayTotalPriority =0;
    int wednesdayTotalPriority =0;
    int thursdayTotalPriority =0;
    int fridayTotalPriority =0;
    int saturdayTotalPriority=0;
    int sundayTotalPriority=0;

    List<int> dayPriorities = [mondayTotalPriority,tuesdayTotalPriority,wednesdayTotalPriority,thursdayTotalPriority,fridayTotalPriority,saturdayTotalPriority,sundayTotalPriority];

    

    //String priority list make int List
    for(int i=0; i<studentSubjectsPriorityList.length; i++){
      intPriorities.add(int.parse(studentSubjectsPriorityList[i]));
    }

    //seperate subjects according to priority
    for(int i=0; i<intPriorities.length; i++){
      if(intPriorities[i]==5 || intPriorities[i]==4){
        priority4AND5.add(studentSubjectsList[i]);
      }else if(intPriorities[i]==3 || intPriorities[i]==2){
        priority2AND3.add(studentSubjectsList[i]);
      }else{
        priority1.add(studentSubjectsList[i]);
      }
    }


int j1 = 0;
int lengthpriority4AND5 = priority4AND5.length;

//adding priority 4&5
  for (int i = 0; ((i < 7) && (lengthpriority4AND5 != 0) && (j1<lengthpriority4AND5)) ; i+=2) {

    for(int j=0; j<dayList.length; j++){
      if(i==j){
        dayList[j].add(priority4AND5[j1]);
      dayPriorities[j]+=5;
      }
    }
    
    j1++;
    if((i+2)>6){
      List<int> numbersList = [mondayTotalPriority, tuesdayTotalPriority, wednesdayTotalPriority, thursdayTotalPriority, fridayTotalPriority,saturdayTotalPriority,sundayTotalPriority];
  
int minNumber = numbersList.reduce(min);

for (int tempNum=0; tempNum<numbersList.length; tempNum++) {
  if(minNumber == numbersList[tempNum]){
    i = tempNum-2;
    break;
  }
}

    }
  }
    
    
//before adding priority 2&3 should check minimum length Listday
int priority2AND3SatrtingIndex = 0;

List<int> numbers = dayPriorities;
  
int minNumber = numbers.reduce(min);

for (int i=0; i<numbers.length; i++) {
  if(minNumber == numbers[i]){
    priority2AND3SatrtingIndex = i;
    break;
  }
}


//adding priority 2&3
int j2 = 0;
int lengthpriority2AND3 = priority2AND3.length;

//adding priority 2&3
  for (int i = priority2AND3SatrtingIndex; ((i < 7) && (lengthpriority4AND5 != 0) && (j2<lengthpriority2AND3)) ; i+=3) {


for(int j=0; j<dayList.length; j++){
      if(i==j){
        dayList[j].add(priority2AND3[j2]);
      dayPriorities[j]+=3;
      }
    }

  if((i+3)>6){
    List<int> numbersTemp =dayPriorities;
int minNumber = numbersTemp.reduce(min);
for (int temp=0; temp<numbers.length; temp++) {
  if(minNumber == numbersTemp[temp]){
    i = temp-3;
    break;
  }
}
  }

    j2++;
  }

  //Before adding priority 1 should check lowest total priority Days
  int priority1SatrtingIndex = 0;

List<int> numbersNew = dayPriorities;
int j3 = 0;

int minNumberNew = numbersNew.reduce(min);

for (int i = 0; j3 < priority1.length; i++) {
for (int j = 0; j < dayList.length; j++) {
  if(minNumberNew == dayPriorities[j] && j3 < priority1.length){
    dayList[j].add(priority1[j3]);
    dayPriorities[j]+=1;
    j3++;


  }
  
    minNumberNew = numbersNew.reduce(min);
}
}


//repeat above method to increase subjects for timetable/*



//remove duplicates

for (var element in dayList) {
  Set<String> uniqueNumbers1 = element.toSet();
  element = uniqueNumbers1.toList();
}
  



List<int> maxLengthFindList = [dayList[0].length,dayList[1].length,dayList[2].length,dayList[3].length,dayList[4].length,dayList[5].length,dayList[6].length];
int maxNumberNew = maxLengthFindList.reduce(max);


howManySubjects=maxNumberNew;
dataAuthServices().updateHowManySubjects(auth.currentUser!.uid, howManySubjects.toString());

for (var element in dayList) {
  if(element.length != maxNumberNew){
    for (int i = element.length-1; i < maxNumberNew; i++) {
      element.add("");
    }
  }
}



    todaySubjectsList.add(dayList[0].toString());
    todaySubjectsList.add(dayList[1].toString());
    todaySubjectsList.add(dayList[2].toString());
    todaySubjectsList.add(dayList[3].toString());
    todaySubjectsList.add(dayList[4].toString());
    todaySubjectsList.add(dayList[5].toString());
    todaySubjectsList.add(dayList[6].toString());
    todaySubjectsList.add(dayList[6].toString());
    todaySubjectsList.add(dayList[6].toString());
    todaySubjectsList.add(howManySubjects.toString());

    //refreshEnableData();

   return TimeTableView.getTableView(updateTodaySubjectsList, studentSubjectsList, studentSubjectsPriorityList, todaySubjectsList, dayList ,howManySubjects, _timeTableData, timetable, auth, tableDataList);

  }


}