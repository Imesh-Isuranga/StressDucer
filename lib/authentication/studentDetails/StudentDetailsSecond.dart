import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:stress_ducer/model/UserModel.dart';
import 'package:stress_ducer/model/studentFirstModel.dart';
import 'package:stress_ducer/Home/HomeTabBar/Home/Home.dart';
import 'package:stress_ducer/Home/mainPlace.dart';
import 'package:stress_ducer/authentication/authenticate.dart';
import 'package:stress_ducer/services/auth.dart';
import 'package:stress_ducer/services/studentDataBase.dart';
import 'package:stress_ducer/services/error.dart';
import 'package:stress_ducer/wrapper.dart';

class StudentDetailsSecond extends StatefulWidget {
  const StudentDetailsSecond(this.studentFirstModel,
      {super.key, required this.backPress, required this.refresh});

  final StudentFirstModel studentFirstModel;
  final void Function() backPress;
  final void Function(bool) refresh;

  @override
  State<StudentDetailsSecond> createState() => _StudentDetailsSecondState();
}

class _StudentDetailsSecondState extends State<StudentDetailsSecond> {
  final List<TextEditingController> subjectsControllers = [];
  final List<String> subjects = [];
  final List<String> prioritysControllers = [];
  final List<String> selectedOption = []; // Initial selected option

  List<String> options = ['1', '2', '3', '4', '5'];

  String error = "";

  @override
  void initState() {
    super.initState();

    for (int i = 0;
        i < int.parse(widget.studentFirstModel.studentNumOfSubjects);
        i++) {
      subjectsControllers.add(TextEditingController());
      prioritysControllers.add("1");
      subjects.add("Null");
      selectedOption.add("1");
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.detached) {
      AuthServices().deleteAccount();
    }
  }

  bool nextEnable() {
    for (var element in subjectsControllers) {
      if (element.text.isEmpty) {
        return false;
      }
    }
    return true;
  }

  void warningtMsg() {
    Widget okButton = TextButton(
      child: const Text("OK"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    AlertDialog alert = AlertDialog(
      title: const Text(
        "Warning",
        style: TextStyle(color: Colors.red),
      ),
      content: const Text("Please Fill All"),
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
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    String id = Provider.of<UserModel?>(context)!.uid;

    final authDataBase = dataAuthServices();

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              widget.backPress();
            },
            icon: const Icon(Icons.arrow_back_ios_new_sharp),
            color: Colors.black,
          ),
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          title: const Text(
            "Student Details",
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: screenHeight * 0.028,
                  ),
                  Text(
                    "Enter Subjects and their Priorities respectively",
                    style: GoogleFonts.roboto(
                        fontSize: screenWidth * 0.042,
                        fontWeight: FontWeight.w400),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: screenHeight * 0.045,
                  ),
                  Text(
                    "Priority 1 to 5 subjects vary from easy to difficult",
                    style: GoogleFonts.roboto(
                        fontSize: screenWidth * 0.037,
                        fontWeight: FontWeight.w400,
                        color: const Color.fromARGB(215, 244, 67, 54)),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    "Ex :- Prioriy 1 mean it is very easy subject for you.",
                    style: GoogleFonts.roboto(
                        fontSize: screenWidth * 0.037,
                        fontWeight: FontWeight.w400,
                        color: const Color.fromARGB(215, 244, 67, 54)),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    "Ex :- Prioriy 5 mean it is very hard subject for you.",
                    style: GoogleFonts.roboto(
                        fontSize: screenWidth * 0.037,
                        fontWeight: FontWeight.w400,
                        color: const Color.fromARGB(215, 244, 67, 54)),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: screenHeight * 0.065,
                  ),
                  Column(
                    children: List.generate(
                        int.parse(
                            widget.studentFirstModel.studentNumOfSubjects),
                        (index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.6,
                              child: TextField(
                                decoration: InputDecoration(
                                  errorText:
                                      subjectsControllers[index].text.isEmpty
                                          ? '*required'
                                          : null,
                                  border: const OutlineInputBorder(),
                                  labelText: 'Subject ${(index + 1)}',
                                ),
                                controller: subjectsControllers[index],
                                keyboardType: TextInputType.text,
                                onChanged: (value) {
                                  setState(() {
                                    subjects[index] = value;
                                  });
                                },
                              ),
                            ),
                            SizedBox(
                              width: screenWidth * 0.08,
                            ),
                            DropdownButton<String>(
                              value: selectedOption[index],
                              onChanged: (String? newValue) {
                                setState(() {
                                  prioritysControllers[index] =
                                      newValue.toString();
                                  selectedOption[index] = newValue!;
                                });
                              },
                              items: options.map<DropdownMenuItem<String>>(
                                  (String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                            ),
                          ],
                        ),
                      );
                    }),
                  ),
                  SizedBox(
                    height: screenHeight * 0.08,
                  ),
                  FilledButton(
                    onPressed: nextEnable()
                        ? () async {
                            int num = int.parse(
                                widget.studentFirstModel.studentNumOfSubjects);
                            int repeatSubject = 0;
                            if (num < 14) {
                              if (num <= 7) {
                                repeatSubject = (14 / num).round();
                              } else {
                                repeatSubject = 2;
                              }
                            } else {
                              repeatSubject = 1;
                            }

                            // Check for internet connectivity
                            var connectivityResult =
                                await (Connectivity().checkConnectivity());
                            if (connectivityResult == ConnectivityResult.none) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  backgroundColor:
                                      const Color.fromARGB(255, 33, 4, 2),
                                  content: const Text(
                                    'Something went wrong! May be No internet connection',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  action: SnackBarAction(
                                    label: 'Close',
                                    onPressed: () {},
                                  ),
                                ),
                              );
                            } else {
                              // Attempt to register the user
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const Wrapper()), // Navigating to Wrapper (or MainPlace)
                              );
                              print('2222222222222222222222222222222222222');
                              print(id);

                              // Proceed with data insertion and navigation
                              authDataBase.create(
                                  widget.studentFirstModel,
                                  (subjects.join(',')),
                                  (prioritysControllers.join(',')),
                                  id, // Ensure user is not null
                                  "[]",
                                  [],
                                  repeatSubject.toString());
                            }
                          }
                        : () {
                            warningtMsg();
                          },
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            Theme.of(context).primaryColor)),
                    child: SizedBox(
                      width: screenWidth * 0.4,
                      child: Text(
                        'Next',
                        style: TextStyle(fontSize: screenWidth * 0.05),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
