import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stress_ducer/Login/model/student.dart';
import 'package:stress_ducer/Login/services/studentDataBase.dart';

class Subjects extends StatefulWidget {
  const Subjects({super.key});

  @override
  State<Subjects> createState() => _SubjectsState();
}

class _SubjectsState extends State<Subjects> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final auth_dataBaseStudent = dataAuthServices();
  String studentSubjects = "";
  String studentSubjectsPriority = "";
  late List<String> studentSubjectsList = [];
  late List<String> studentSubjectsPriorityList = [];
  int numOfSubjects = 0;
  bool isUpdating = false;


  final numOfSubjectsConroller = TextEditingController();
  final List<TextEditingController> subjectsControllers = [];
  final List<String> prioritysControllers = [];
  final List<String> selectedOption = []; // Initial selected option

  List<String> options = ['1', '2', '3', '4', '5'];

  void refresh(int numOfSubjects){
    subjectsControllers.clear();
    prioritysControllers.clear();
    studentSubjectsList.clear();
    selectedOption.clear();
    for (int i = 0; i < numOfSubjects; i++) {
          subjectsControllers.add(TextEditingController());
          prioritysControllers.add("1");
          studentSubjectsList.add("Null");
          studentSubjectsPriorityList.add("1");
          selectedOption.add("1");
    }
  }

  bool nextEnable(){
    for (var element in subjectsControllers) {
      if(element.text.isEmpty || numOfSubjectsConroller.text.isEmpty){
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
      title: const Text("Warning",style: TextStyle(color: Colors.red),),
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

void alerttMsg(BuildContext contx) {
    Widget okButton = TextButton(
      child: const Text("OK"),
      onPressed: () {
        Navigator.of(context).pop();
        Navigator.of(contx).pop();
      },
    );

    AlertDialog alert = AlertDialog(
      title: const Text("Alert",style: TextStyle(color: Colors.black),),
      content: const Text("Saved"),
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
  void initState() {
     String? studentDocumentId = auth.currentUser!.uid;
    if (studentDocumentId != null) {
      Stream<Student?> studentStream =
          dataAuthServices.readSpecificDocument(studentDocumentId);

      studentStream.listen((student) {
        if (student != null) {
          if (mounted == true) {
            setState(() {
              try {
                numOfSubjects = int.parse(student.studentNumOfSubjects ?? '1');
                studentSubjects = student.studentSubjects.toString();
                studentSubjectsPriority =student.studentSubjectsPriority.toString();
                studentSubjectsList = studentSubjects.split(',');
                studentSubjectsPriorityList =studentSubjectsPriority.split(',');

              prioritysControllers.clear();
              subjectsControllers.clear();
              for (int i = 0; i < numOfSubjects; i++) {
                subjectsControllers.add(TextEditingController());
                prioritysControllers.add(studentSubjectsPriorityList[i]);
                subjectsControllers[i].text = studentSubjectsList[i];
                selectedOption.add(studentSubjectsPriorityList[i]);
              }
              numOfSubjectsConroller.text = numOfSubjects.toString();
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


    return Scaffold(
          body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 60,),
                      Text("Enter Number Of Subjects",style: GoogleFonts.roboto(fontSize: 18, fontWeight: FontWeight.w400),textAlign: TextAlign.center,),
                      const SizedBox(height: 30,),
                      SizedBox(
                        width: MediaQuery.of(context).size.width*0.2,
                        child: TextField(
                        decoration: InputDecoration(
                          errorText: numOfSubjectsConroller.text.isEmpty ? '*required' : null,
                          border: const OutlineInputBorder(),
                        ),
                        controller: numOfSubjectsConroller,
                        keyboardType: TextInputType.number,
                        onChanged: (value) {
                        setState(() {
                         numOfSubjects = int.parse(value);
                         refresh(numOfSubjects);
                        });
                        }
                        ),
                      ),
                      const SizedBox(height: 40,),
                      Text("Enter Subjects and their Priorities respectively",style: GoogleFonts.roboto(fontSize: 18, fontWeight: FontWeight.w400),textAlign: TextAlign.center,),
                      const SizedBox(height: 40,),
                      Column(
                        children: List.generate(numOfSubjects, (index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 10.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width: MediaQuery.of(context).size.width*0.6,
                                  child: TextField(
                                    decoration: InputDecoration(
                                      errorText: subjectsControllers[index].text.isEmpty ? '*required' : null,
                                      border: const OutlineInputBorder(),
                                      labelText: 'Subject ${(index + 1)}',
                                    ),
                                    controller: subjectsControllers[index],
                                    keyboardType: TextInputType.text,
                                    onChanged: (value) {
                                      setState(() {
                                        studentSubjectsList[index] = value;
                                      });
                                    },
                                  ),
                                ),
                                const SizedBox(
                                  width: 50,
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
                      const SizedBox(
                        height: 40,
                      ),
                      FilledButton.icon(
                        onPressed: nextEnable() ? () async{
                          var connectivityResult = await (Connectivity().checkConnectivity());
                                if (connectivityResult == ConnectivityResult.none) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    backgroundColor: const Color.fromARGB(255, 33, 4, 2),
                                    content: const Text('Something went wrong! May be No internet connection',style: TextStyle(color: Colors.white),),
                                    action: SnackBarAction(
                                      label: 'Close',
                                      onPressed: () {},
                                    ),
                                  ),
                                );
                                }else{
                                  setState(() {
                          isUpdating = true; // Set isUpdating to true when update starts
                        });

                        auth_dataBaseStudent.updateSubjectsWithPri(auth.currentUser!.uid, numOfSubjects.toString(), studentSubjectsList.join(','), prioritysControllers.join(','))
                          .then((_) {
                            setState(() {
                              isUpdating = false; // Set isUpdating to false when update completes
                            });
                            alerttMsg(context);
                          });
                                }
                      } : () {
                        warningtMsg();
                      },
                      icon: isUpdating ? Container(
                                      width: screenHeight*0.025,
                                      height: screenHeight*0.025,
                                      padding: const EdgeInsets.all(1.0),
                                      child: const CircularProgressIndicator(
                                        color: Colors.white,
                                        strokeWidth: 3,
                                      ),
                                    )
                                  : Icon(Icons.save,size: screenWidth*0.045 ,),
                        label: const SizedBox(
                          width: 70,
                          child: Text(
                            'Save',
                            style: TextStyle(fontSize: 20),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
  }
}