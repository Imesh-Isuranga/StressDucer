import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stress_ducer/Login/model/student.dart';
import 'package:stress_ducer/Login/screens/Home/HomeTabBar/Calender/calenderHelp.dart';
import 'package:stress_ducer/Login/screens/Home/HomeTabBar/Home/AddTasks/Notification/notification_service.dart';
import 'package:stress_ducer/Login/services/studentDataBase.dart';
import 'package:intl/intl.dart';
import 'package:stress_ducer/Login/constant/colors.dart';




class Calender extends StatefulWidget {
  const Calender({Key? key});

  @override
  State<Calender> createState() => _CalenderState();
}

class _CalenderState extends State<Calender> {
  final authStudent = dataAuthServices();
  final FirebaseAuth auth = FirebaseAuth.instance;
  final List<int> invalidNumbers = []; // Example invalid numbers
  static List<bool> flag = [];

  @override
  void initState() {
    getData();
    super.initState();
  }

  void getData() {
    
    DateTime currentDate = DateTime.now();
    for (int i = 1; i < currentDate.day; i++) {
      invalidNumbers.add(i);
    }
    int daysInCurrentMonth =
        DateTime(currentDate.year, currentDate.month + 1, 0).day;
    for (int i = 0; i < daysInCurrentMonth; i++) {
      flag.add(false);
    }


    String? studentDocumentId = auth.currentUser!.uid;
    if (studentDocumentId != null) {
      Stream<Student?> studentStream =
          dataAuthServices.readSpecificDocument(studentDocumentId);

      studentStream.listen((student) {
        if (student != null) {
          if (mounted == true) {
            setState(() {
              try {
                if(student.flag.isNotEmpty){
                flag = student.flag;
                }
              } catch (e) {
                // Handle the parsing error
                print("Error parsing howManySubjects: $e");
              }
            });
          }
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    DateTime currentDate = DateTime.now();
    int daysInCurrentMonth =
        DateTime(currentDate.year, currentDate.month + 1, 0).day;

    return ListView(children: [
        Card(
              margin: const EdgeInsets.all(0),
              child: Padding(
                padding: EdgeInsets.only(left: screenWidth*0.05),
                child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                      SizedBox(height: screenHeight*0.02,),
                      Text("Magic Calendar",style: GoogleFonts.roboto(fontSize: screenWidth*0.053, fontWeight: FontWeight.w600),),
                      SizedBox(height: screenHeight*0.02,),
                      SizedBox(
                        width: screenWidth*0.2,
                        height: screenWidth*0.0625,
                        child: ElevatedButton(
                                onPressed: () {
                                  CalenderHelp().getHelpTextPanel(context);
                                },
                                style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                        btnBackGreen.withOpacity(0.5),
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20))),
                                child: Text("Help",style: GoogleFonts.roboto(fontSize: screenWidth * 0.033,fontWeight: FontWeight.w600),),
                              ),
                      ),
                      SizedBox(height: screenHeight*0.02,)
                      ]),
                ),
              ),
              SizedBox(height: screenHeight * 0.0025,),
              Divider(height: 0.3, color: Theme.of(context).indicatorColor,),
              SizedBox(height: screenHeight * 0.0025,),
              Card(child: Column(children: [
                SizedBox(height: screenHeight * 0.02,),
                Text("You have only ${daysInCurrentMonth - currentDate.day} days for this month",style: GoogleFonts.roboto(fontSize: screenWidth*0.040,fontWeight: FontWeight.w600,color: Colors.red),),
                SizedBox(height: screenHeight * 0.04,),
                Text("${DateFormat.MMMM().format(DateTime.now())}",style: GoogleFonts.roboto(fontSize: screenWidth*0.040,fontWeight: FontWeight.w600)),
                SizedBox(height: screenHeight*0.04),
                GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 7,),
                      itemCount: daysInCurrentMonth,
                      itemBuilder: (context, index) {
                        final number = index + 1;
                        final isValidNumber = !invalidNumbers.contains(number);
        
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              if ((index + 1) > DateTime.now().day) {
                                flag[index] = !flag[index];
                                authStudent.updateFlag(
                                    auth.currentUser!.uid, flag);
        
                                if (flag[index] == true) {
                                  DateTime now = DateTime.now();
                                  NotificationService.showNotification(
                                      id: index,
                                      title: "You Have to Start your Task.",
                                      body: "Calender Flag",
                                      scheduled: true,
                                      date: DateTime(
                                          now.year, now.month, (index + 1)),
                                      time: const TimeOfDay(hour: 08, minute: 00));
                                } else {
                                  NotificationService.cancelScheduledNotification(index);
                                }
                              }
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 1, 89, 4),
                                border: Border.all(color: Colors.white)),
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(number.toString(),style: GoogleFonts.roboto(fontSize: screenWidth*0.05,color: Colors.white),),
                                  if (!isValidNumber)
                                    Icon(Icons.clear,color: Colors.red,size: screenWidth*0.045,),
                                  if ((flag[index] == true) && isValidNumber)
                                    Expanded(
                                      child: Icon(
                                        Icons.flag,color: Colors.red,size: screenWidth*0.045,),)
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                        ),
              ]),)
    ],);
  }
}
