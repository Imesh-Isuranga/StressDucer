import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stress_ducer/model/studentFirstModel.dart';

class StudentDetails extends StatefulWidget {
  const StudentDetails({super.key, required this.stateChange});

  final Function(StudentFirstModel studentFirstModel) stateChange;

  @override
  State<StudentDetails> createState() => _StudentDetailsState();
}

class _StudentDetailsState extends State<StudentDetails>{
  final TextEditingController controllerStudentName = TextEditingController();
  final TextEditingController controllerStudentUniName =
      TextEditingController();
  final TextEditingController controllerStudentCurrentSem =
      TextEditingController();
  final TextEditingController controllerStudentNumOfSubjects =
      TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    controllerStudentName.dispose();
    controllerStudentUniName.dispose();
    controllerStudentCurrentSem.dispose();
    controllerStudentNumOfSubjects.dispose();
    super.dispose();
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


  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;


    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
              child: Container(
                margin: const EdgeInsets.only(left: 20, right: 30),
                child: Column(
                  children: [
                    SizedBox(height: screenHeight*0.06,),
                    Text("User Registration",style: GoogleFonts.roboto(fontSize: screenWidth*0.07,fontWeight: FontWeight.w800,color: Theme.of(context).primaryColor),),
                    SizedBox(height: screenHeight*0.02,),
                    const Divider(height: 2,),
                    SizedBox(height: screenHeight*0.04,),
                    Text(
                      "Enter Your Name :",
                      style: TextStyle(fontSize: screenWidth*0.04),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width*0.6,
                      child: TextField(
                        onChanged: (value) {
                          setState(() {
                            
                          });
                        },
                        decoration: InputDecoration(
                errorText: controllerStudentName.text.isEmpty ? '*required' : null,
              ),
                        keyboardType: TextInputType.name,
                        controller: controllerStudentName,
                      ),
                    ),
                    SizedBox(
                      height: screenHeight*0.065,
                    ),
                    Text(
                      "Enter Your University Name :",
                      style: TextStyle(fontSize: screenWidth*0.04),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width*0.7,
                      child: TextField(
                        onChanged: (value) {
                          setState(() {
                            
                          });
                        },
                        decoration: InputDecoration(
                errorText: controllerStudentUniName.text.isEmpty ? '*required' : null,
              ),
                        keyboardType: TextInputType.name,
                        controller: controllerStudentUniName,
                      ),
                    ),
                    SizedBox(
                      height: screenHeight*0.065,
                    ),
                    Text(
                      "Enter Your Current Semester :",
                      style: TextStyle(fontSize: screenWidth*0.04),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width*0.2,
                      child: TextField(
                        onChanged: (value) {
                          setState(() {
                            
                          });
                        },
                        decoration: InputDecoration(
                errorText: controllerStudentCurrentSem.text.isEmpty ? '*required' : null,
              ),
                        keyboardType: TextInputType.number,
                        controller: controllerStudentCurrentSem,
                      ),
                    ),
                    SizedBox(
                      height: screenHeight*0.065,
                    ),
                    Text(
                      "Enter Number Of Subjects U have :",
                      style: TextStyle(fontSize: screenWidth*0.04),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width*0.2,
                      child: TextField(
                        onChanged: (value) {
                          setState(() {
                            
                          });
                        },
                        decoration: InputDecoration(
                errorText: controllerStudentNumOfSubjects.text.isEmpty ? '*required' : null,
              ),
                        keyboardType: TextInputType.number,
                        controller: controllerStudentNumOfSubjects,
                      ),
                    ),
                    SizedBox(
                      height: screenHeight*0.08,
                    ),
                    FilledButton(
                      onPressed: ((controllerStudentName.text.isNotEmpty) && (controllerStudentUniName.text.isNotEmpty)  && (controllerStudentCurrentSem.text.isNotEmpty)  && (controllerStudentNumOfSubjects.text.isNotEmpty)) ? 
                      () {
                        widget.stateChange(StudentFirstModel(
                            studentName: controllerStudentName.text,
                            studentUniName: controllerStudentUniName.text,
                            studentCurrentSem: controllerStudentCurrentSem.text,
                            studentNumOfSubjects:
                                controllerStudentNumOfSubjects.text));
                      } : (){warningtMsg();},
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Theme.of(context).primaryColor)),
                      child: SizedBox(
                        width: screenWidth*0.4,
                        child: Text(
                          'Next',
                          style: TextStyle(fontSize: screenWidth*0.05),
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
