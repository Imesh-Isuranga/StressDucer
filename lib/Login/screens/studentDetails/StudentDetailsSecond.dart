import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stress_ducer/Login/constant/colors.dart';
import 'package:stress_ducer/Login/model/studentFirstModel.dart';
import 'package:stress_ducer/Login/services/auth.dart';
import 'package:stress_ducer/Login/services/studentDataBase.dart';

class StudentDetailsSecond extends StatefulWidget {
  const StudentDetailsSecond(this.studentFirstModel,
      {super.key,
      required this.Pressed,
      required this.idNum,
      required this.backPress});

  final String idNum;
  final StudentFirstModel studentFirstModel;
  final void Function(bool) Pressed;
  final void Function() backPress;
  @override
  State<StudentDetailsSecond> createState() => _StudentDetailsSecondState();
}

class _StudentDetailsSecondState extends State<StudentDetailsSecond> {
  final List<TextEditingController> subjectsControllers = [];
  final List<String> subjects = [];
  final List<String> prioritysControllers = [];
  final List<String> selectedOption = []; // Initial selected option

  List<String> options = ['1', '2', '3', '4', '5'];

  @override
  void initState() {
    super.initState();

    for (int i = 0; i < int.parse(widget.studentFirstModel.studentNumOfSubjects); i++) {
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

  bool nextEnable(){
    for (var element in subjectsControllers) {
      if(element.text.isEmpty){
        return false;
      }
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    final _authDataBase = dataAuthServices();

    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              onPressed: () {
                widget.backPress();
              },
              icon: Icon(Icons.arrow_back_ios_new_sharp),
              color: Colors.black,
            ),
            backgroundColor: mainAppBarColor,
            title: const Text(
              "Student Details",
              style: TextStyle(color: appBarTextColor),
            ),
          ),
          body: Container(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Enter Subjects and their Priorities respectively",
                        style: GoogleFonts.roboto(
                            fontSize: 18, fontWeight: FontWeight.w400),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      Column(
                        children: List.generate(int.parse(widget.studentFirstModel.studentNumOfSubjects), (index) {
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
                                      border: OutlineInputBorder(),
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
                      FilledButton(
                        onPressed: nextEnable() ?
                        () {
                          widget.Pressed(false);
                          _authDataBase.create(
                              widget.studentFirstModel,
                              (subjects.join(',')),
                              (prioritysControllers.join(',')),
                              widget.idNum,
                              "0",
                              "[]", []);
                        } : (){},
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all<Color>(Colors.black)),
                        child: const SizedBox(
                          width: 100,
                          child: Text(
                            'Next',
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
          )),
    );
  }
}
