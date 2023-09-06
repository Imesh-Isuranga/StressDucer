import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stress_ducer/Login/model/UserModel.dart';
import 'package:stress_ducer/Login/model/addedTasks.dart';
import 'package:stress_ducer/Login/screens/Home/HomeTabBar/Home/AddTasks/Notification/notification_service.dart';
import 'package:stress_ducer/Login/screens/Home/HomeTabBar/Home/AddTasks/Notification/widgets/notification_button.dart';
import 'package:stress_ducer/Login/services/addTasksDataBase.dart';
import 'package:stress_ducer/Login/services/auth.dart';
import 'package:stress_ducer/Login/services/studentDataBase.dart';

class AddedTasksCards extends StatefulWidget {
  AddedTasksCards({super.key});

  @override
  State<AddedTasksCards> createState() => _AddedTasksCardsState();
}

class _AddedTasksCardsState extends State<AddedTasksCards> {
  final addTasks = AddTasksDatabase();
  NotificationService notificationService = NotificationService();
  final TextEditingController taskNameController = TextEditingController();
  String text = "";
  final FirebaseAuth auth = FirebaseAuth.instance;
  final authAddNewTask = AddTasksDatabase();
  DateTime pickedDate = DateTime.now();
  TimeOfDay pickedTime = TimeOfDay.now();

  List<String?> listAll = [];

  List<List> listAllFull = [];
  static int count = 0;

  @override
  void initState() {
    getData();
    super.initState();
  }

  void setCount() {
    setState(() {
      count++;
    });
  }

  void getData() {
    String? tasksDocumentId = auth.currentUser!.uid;
    if (tasksDocumentId != null) {
      Stream<AddedTasks?> tasksStream =
          AddTasksDatabase.readSpecificDocument(tasksDocumentId);

      tasksStream.listen((task) {
        if (task != null) {
          if (mounted == true) {
            // setState(() {
            try {
              listAll = task.list;
              listAllFull.clear();
              for (int i = 0; i < listAll.length; i++) {
                String? tempText = listAll[i];
                tempText = tempText!.substring(1, tempText.length - 1);
                List<String> elements = tempText.split(',');
                elements = elements.map((element) => element.trim()).toList();
                listAllFull.add(elements);
              }
              setState(() {
                count = listAll.length;
              });
            } catch (e) {
              // Handle the parsing error
              print("Error : $e");
            }
          }
        }
      });
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (pickedDate != null && pickedDate != DateTime.now()) {
      setState(() {
        this.pickedDate = pickedDate;
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (pickedTime != null && pickedTime != TimeOfDay.now()) {
      setState(() {
        this.pickedTime = pickedTime;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    String id = Provider.of<UserModel?>(context)!.uid;
    final AuthServices _auth = AuthServices();
    final dataAuthServices _authData = dataAuthServices();

    for (int i = 0; i < listAllFull.length; i++) {
      DateTime b = DateTime.parse(listAllFull[i][1]);
      if (b.isBefore(DateTime.now())) {
        List<String> parts = (listAllFull[i][2]).split(':');
        int hour = int.parse(parts[0]);
        int minute = int.parse(parts[1]);
        // Create a TimeOfDay instance
        TimeOfDay a = TimeOfDay(hour: hour, minute: minute);
        if (a.hour < TimeOfDay.now().hour ||
            a.hour == TimeOfDay.now().hour &&
                a.minute <= TimeOfDay.now().minute) {
          listAllFull.removeAt(i);
          listAll.removeAt(i);
          authAddNewTask.create(
              AddedTasks(list: listAll), auth.currentUser!.uid);
          count--;
        }
      }
    }

    DateTime pickedDateGetter() {
      return pickedDate;
    }

    TimeOfDay pickedTimeeGetter() {
      return pickedTime;
    }

    String textGetter() {
      return text;
    }

    void showAlert() {
      Widget okButton = TextButton(
        child: const Text("OK"),
        onPressed: () {
          Navigator.of(context).pop();
          ;
        },
      );

      AlertDialog alert = AlertDialog(
        title: const Text(
          "Error",
          style: TextStyle(color: Colors.red, fontSize: 20),
        ),
        content: const Text("Please Enter Task Name"),
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

    return Container(
      child: Card(
        margin: const EdgeInsets.only(top: 3,bottom: 0,left: 0,right: 0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const SizedBox(
              height: 20,
            ),
            Row(children: [
              Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset(
                "assets/todayTasks.jpg",
                width: 200,
                height: 200,
              ),
            ),
            Expanded(
              child: const ListTile(
                  title: Text('Add Task',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w400)),
                  subtitle: Text("Add Task")),
            ),
            ],),
            
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                TextButton(
                  child: const Text('Add Task Sheduler'),
                  onPressed: () {
                    showModalBottomSheet(
                      isScrollControlled: true,
                      context: context,
                      builder: (context) {
                        return Container(
                          height: MediaQuery.of(context)
                              .size
                              .height, // Take up full screen height
                          child: SingleChildScrollView(
                            child: Container(
                              padding: const EdgeInsets.all(30),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  const Text("Task Name : ",
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w400,
                                      )),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                    width: MediaQuery.of(context).size.width *
                                        0.7, // Set the desired width
                                    child: TextField(
                                      controller: taskNameController,
                                      onChanged: (value) {
                                        setState(() {
                                          taskNameController.text = value;
                                          text = value;
                                        });
                                      },
                                      keyboardType: TextInputType.number,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: [
                                      ElevatedButton(
                                        onPressed: () {
                                          setState(() {
                                            _selectDate(context);
                                          });
                                        },
                                        child: const Text('Select Date'),
                                      ),
                                      const SizedBox(
                                        width: 50,
                                      ),
                                      ElevatedButton(
                                        onPressed: () {
                                          setState(() {
                                            _selectTime(context);
                                          });
                                        },
                                        child: const Text('Select Time'),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  NotificationButton(
                                    text: "Add Scheduled",
                                    onPressed: () async {
                                      if (text != "") {
                                        FocusScope.of(context).unfocus();
                                        await NotificationService.showNotification(
                                            id: count,
                                            title:
                                                "You Have to Start your Task.",
                                            body: textGetter(),
                                            scheduled: true,
                                            date: pickedDateGetter(),
                                            time: pickedTimeeGetter());
                                        List<String?> temp = [
                                          textGetter(),
                                          pickedDateGetter().toString(),
                                          ('${pickedTimeeGetter().hour}:${pickedTimeeGetter().minute}'),
                                          count.toString()
                                        ];
                                        setState(() {
                                          taskNameController.clear();
                                          listAll.add(temp.toString());
                                          listAllFull.add(temp);
                                          addTasks.create(
                                              AddedTasks(list: listAll),
                                              auth.currentUser!.uid);
                                          setCount();
                                          text = "";
                                          pickedDate = DateTime.now();
                                          pickedTime = TimeOfDay.now();
                                        });
                                      } else {
                                        showAlert();
                                      }
                                    },
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Container(
                                    height: MediaQuery.of(context).size.height *
                                        0.6,
                                    child: ListView.builder(
                                      itemCount: count,
                                      itemBuilder: (context, index) {
                                        return Dismissible(
                                          key: Key(index.toString()),
                                          onDismissed: (direction) async {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              const SnackBar(
                                                content:
                                                    Text('Deleted your Task'),
                                              ),
                                            );
                                            await NotificationService
                                                .cancelScheduledNotification(
                                                    index);
                                            setState(() {
                                              listAll.removeAt(index);
                                              authAddNewTask.create(
                                                  AddedTasks(list: listAll),
                                                  auth.currentUser!.uid);
                                              count--;
                                            });
                                          },
                                          child: Center(
                                            child: Card(
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: <Widget>[
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            20.0),
                                                    child: ListTile(
                                                      leading: const Icon(
                                                          Icons.alarm),
                                                      title: Text(
                                                          listAllFull[index]
                                                              [0]),
                                                      subtitle: Text(
                                                          'Date : ${DateTime.parse(listAllFull[index][1]).year}:${DateTime.parse(listAllFull[index][1]).month}:${DateTime.parse(listAllFull[index][1]).day}\nTime : ${(listAllFull[index][2])}'),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
