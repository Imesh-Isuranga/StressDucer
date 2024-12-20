import 'dart:collection';
import 'dart:math';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:stress_ducer/Home/HomeTabBar/TodayTasks/timeTableView.dart';

class GetTodayData{

static List<String> getTodaySubjects(
  List<String> studentSubjectsList,
    List<String> studentSubjectsPriorityList,
    List<Map<String, dynamic>> tableDataList,
    int changeSubjectsCount
    ) {
final FirebaseAuth auth = FirebaseAuth.instance;
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
    int startingIndex = 0;
    List<int> dayPriorities = [mondayTotalPriority,tuesdayTotalPriority,wednesdayTotalPriority,thursdayTotalPriority,fridayTotalPriority,saturdayTotalPriority,sundayTotalPriority];



    List<String> mondayList = [];
    List<String> tuesdayList = [];
    List<String> wednesdayList = [];
    List<String> thursdayList = [];
    List<String> fridayList = [];
    List<String> saturdayList = [];
    List<String> sundayList = [];
    List<List<String>> dayList = [mondayList,tuesdayList, wednesdayList,thursdayList,fridayList,saturdayList,sundayList];

    List<String> todaySubjectsList = [];
    List<String> updateTodaySubjectsList = [];

    //String priority list make int List
    for(int i=0; i<studentSubjectsPriorityList.length; i++){
      intPriorities.add(int.parse(studentSubjectsPriorityList[i]));
    }



    priority4AND5.clear();
    priority2AND3.clear();
    priority1.clear();
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


int tempLength = priority4AND5.length;
    if(tempLength<=5){
      for (int i = 0; i < 1; i++) {
        for (int j = 0; j < tempLength; j++) {
          priority4AND5.add(priority4AND5[j]);
        }
      }
    }


for (int k = 0; k < 7; k++) {//When repeating below algrothem(refreshing btn) dayList should clear
  dayList[k].clear();
}


for (int k = 0; k < changeSubjectsCount; k++) {//for repeat

  if(k>0){
    List<int> numbersNewTemp = dayPriorities;
    int minNumberNewTemp = numbersNewTemp.reduce(min);
    for (int j=0; j<7; j++) {
      if(minNumberNewTemp==dayPriorities[j]){
        startingIndex = j;
        break;
      }
    }
  }

int j1 = 0;
int lengthpriority4AND5 = priority4AND5.length;
//adding priority 4&5
  for (int i = startingIndex; ((i < 7) && (lengthpriority4AND5 != 0) && (j1<lengthpriority4AND5)) ; i+=2) {

    for(int j=0; j<dayList.length; j++){
      if(i==j){
        dayList[j].add(priority4AND5[j1]);
      dayPriorities[j]+=5;
      break;
      }
    }
    
    j1++;
    if(i==5){
      i=-2;
    }else if(i==6){
      i=-1;
    }

    if(k>0){
    List<int> numbersNewTemp = dayPriorities;
    int minNumberNewTemp = numbersNewTemp.reduce(min);
    for (int j=0; j<7; j++) {
      if(minNumberNewTemp==dayPriorities[j]){
        i = (j-2);
        break;
      }
    }
  }
  }
    
    
//before adding priority 2&3 should check minimum length Listday
List<int> numbers = dayPriorities;
  
int minNumber = numbers.reduce(min);



//adding priority 2&3
int j2 = 0;
int lengthpriority2AND3 = priority2AND3.length;

//adding priority 2&3

while((j2 < lengthpriority2AND3) && (lengthpriority2AND3 != 0)){
  for (int j = 0; j < dayList.length; j++) {
    if(minNumber == dayPriorities[j] && j2 < lengthpriority2AND3){
      dayList[j].add(priority2AND3[j2]);
      dayPriorities[j]+=3;
      j2++;
      break;
    }
    minNumber = numbers.reduce(min);
  }
}


  //Before adding priority 1 should check lowest total priority Days
int priority1SatrtingIndex = 0;
int j3 = 0;

List<int> numbersNew = dayPriorities;
int minNumberNew = numbersNew.reduce(min);


while((j3 < priority1.length) && (priority1.isNotEmpty)){
  for (int j = 0; j < dayList.length; j++) {
    if(minNumberNew == dayPriorities[j] && j3 < priority1.length){
      dayList[j].add(priority1[j3]);
      dayPriorities[j]+=1;
      j3++;
      break;
    }
    minNumberNew = numbersNew.reduce(min);
  }
}
}



//remove duplicates
int i=0;
for (var element in dayList) {
  element = LinkedHashSet<String>.from(element).toList();
  dayList[i] = element;
  i++;
 // Set<String> uniqueNumbers1 = element.toSet();
 // element = uniqueNumbers1.toList();
}
  



List<int> maxLengthFindList = [dayList[0].length,dayList[1].length,dayList[2].length,dayList[3].length,dayList[4].length,dayList[5].length,dayList[6].length];
int maxNumberNew = maxLengthFindList.reduce(max);



for (var element in dayList) {
  if(element.length != maxNumberNew){
    for (int i = element.length; i < maxNumberNew; i++) {
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



   return TimeTableView.getTableView(updateTodaySubjectsList, studentSubjectsList, studentSubjectsPriorityList, todaySubjectsList, dayList , auth, tableDataList,changeSubjectsCount);

  }


}