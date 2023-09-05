import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:googleapis/cloudsearch/v1.dart';
import 'package:stress_ducer/Login/model/student.dart';
import 'package:stress_ducer/Login/screens/Home/HomeTabBar/Home/AddTasks/Notification/notification_service.dart';
import 'package:stress_ducer/Login/services/studentDataBase.dart';
import 'package:intl/intl.dart';


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
    DateTime currentDate = DateTime.now();
    for (int i = 1; i < currentDate.day; i++) {
      invalidNumbers.add(i);
    }
    int daysInCurrentMonth =
        DateTime(currentDate.year, currentDate.month + 1, 0).day;
    for (int i = 0; i < daysInCurrentMonth; i++) {
      flag.add(false);
    }
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
                flag = student.flag;
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
          margin: EdgeInsets.all(0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                const SizedBox(
                  height: 20,
                ),
                Row(children: [
                  const SizedBox(width: 20,),
                  Text(
                  "Calender",
                  style: GoogleFonts.roboto(
                      color: Colors.black,
                      fontSize: 25,
                      fontWeight: FontWeight.w600),
                )
                ]),
                const SizedBox(
                  height: 20,
                )
              ]),
            ),
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
                  Text("${DateFormat.MMMM().format(DateTime.now())}",style: GoogleFonts.roboto(color: Colors.black,
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
                                      time: TimeOfDay(hour: 08, minute: 00));
                                } else {
                                  NotificationService.cancelScheduledNotification(
                                      index);
                                }
                              }
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.black)),
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(number.toString()),
                                  if (!isValidNumber)
                                    const Icon(
                                      Icons.clear,
                                      color: Colors.red,
                                    ),
                                  if (flag[index] == true)
                                    Expanded(
                                      child: const Icon(
                                        Icons.flag,
                                        color: Colors.red,
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
