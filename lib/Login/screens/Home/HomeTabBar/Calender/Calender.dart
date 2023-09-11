import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stress_ducer/Login/model/student.dart';
import 'package:stress_ducer/Login/screens/Home/HomeTabBar/Home/AddTasks/Notification/notification_service.dart';
import 'package:stress_ducer/Login/services/studentDataBase.dart';
import 'package:intl/intl.dart';
import 'package:stress_ducer/Login/constant/colors.dart';
import 'package:stress_ducer/Login/screens/Home/HomeTabBar/Calender/calenderHelp.dart';




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
    DateTime currentDate = DateTime.now();
    int daysInCurrentMonth =
        DateTime(currentDate.year, currentDate.month + 1, 0).day;

    return Column(
      children: [SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Card(
          margin: const EdgeInsets.all(0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                const SizedBox(
                  height: 20,
                ),
                Row(children: [
                  const SizedBox(width: 20,),
                  Text(
                  "Magic Calender",
                  style: GoogleFonts.roboto(
                      fontSize: 25,
                      fontWeight: FontWeight.w600),
                ),
                ]),
                const SizedBox(
                        height: 10,
                      ),
                Row(
                        children: [
                          const SizedBox(
                            width: 20,
                          ),
                          ElevatedButton(
                            onPressed: () {
                              setState(() {
                                CalenderHelp().getHelpTextPanel(context);
                              });
                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    btnBackGreen.withOpacity(0.5),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20))),
                            child: const Text("Help"),
                          )
                        ],
                      ),
                const SizedBox(
                  height: 20,
                )
              ]),
            ),
      ),
        Divider(
  color: Theme.of(context).indicatorColor,
  thickness: 0.3, // Adjust the thickness of the line
),
        Expanded(
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  const SizedBox(height: 40),
                  Text(
                    "You have only ${daysInCurrentMonth - currentDate.day} days for this month",
                    style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Colors.red),
                  ),
                  const SizedBox(height: 40),
                  Text("${DateFormat.MMMM().format(DateTime.now())}",style: GoogleFonts.roboto(
                      fontSize: 22,
                      fontWeight: FontWeight.w600)),
                  const SizedBox(height: 20),
                  Expanded(
                    child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 7,
                      ),
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
                                  NotificationService.cancelScheduledNotification(
                                      index);
                                }
                              }
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: calenderSquare,
                                border: Border.all(color: Colors.black)),
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(number.toString(),style: TextStyle(color: Colors.black),),
                                  if (!isValidNumber)
                                    const Icon(
                                      Icons.clear,
                                      color: calenderMarks,
                                    ),
                                  if ((flag[index] == true) && isValidNumber)
                                    const Expanded(
                                      child: Icon(
                                        Icons.flag,
                                        color: calenderMarks,
                                      ),
                                    )
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
