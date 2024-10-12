import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:stress_ducer/model/UserModel.dart';
import 'package:stress_ducer/model/student.dart';
import 'package:stress_ducer/services/studentDataBase.dart';
import 'package:stress_ducer/authentication/error.dart';
import 'package:stress_ducer/Home/PopUpMenu/Profile_In_Menu/subjectsEdit.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key,required this.guestFunction});

  final void Function() guestFunction;

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final _authDataBase = dataAuthServices();
  late TextEditingController _semTxt;
  late TextEditingController _numSubTxt;
  late TextEditingController _subTxt;
  late TextEditingController _priTxt;
  bool setEditSem = false;
  bool setEditNumSub = false;
  bool setEditSub = false;
  bool setEditPri = false;
  bool setEditSave = false;

  @override
  void initState() {
    super.initState();
    _semTxt = TextEditingController();
    _numSubTxt = TextEditingController();
    _subTxt = TextEditingController();
    _priTxt = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    String id = Provider.of<UserModel?>(context)!.uid;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Profile",
        ),
      ),
      body: StreamBuilder<Student?>(
        stream: dataAuthServices.readSpecificDocument(id),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text("Error: ${snapshot.error}");
          } else if (snapshot.hasData) {
            final student = snapshot.data;
            if (student != null) {
              _semTxt.text = student.studentCurrentSem ?? '';
              _numSubTxt.text = student.studentNumOfSubjects ?? '';
              _subTxt.text = student.studentSubjects ?? '';
              _priTxt.text = student.studentSubjectsPriority ?? '';

              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(30),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          SizedBox(
                              width: MediaQuery.of(context).size.width * 0.5,
                              child: TextField(
                                enabled: setEditSem,
                                controller: _semTxt,
                                decoration: const InputDecoration(
                                  labelText: 'Current Semester',
                                ),
                              )),
                          const SizedBox(
                            width: 40,
                          ),
                          TextButton(
                              onPressed: () {
                                setState(() {
                                  setEditSem = true;
                                  setEditSave = true;
                                });
                              },
                              child: const Text("Edit"))
                        ],
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Row(
                        children: [
                          SizedBox(
                              width: MediaQuery.of(context).size.width * 0.5,
                              child: TextField(
                                enabled: setEditNumSub,
                                controller: _numSubTxt,
                                decoration: const InputDecoration(
                                  labelText: 'Number Of Subjects',
                                ),
                              )),
                          const SizedBox(
                            width: 40,
                          ),
                          TextButton(
                              onPressed: () {
                                setState(() {
                                  Navigator.push(context,MaterialPageRoute(builder: (context) => const Subjects()));
                                 /* setEditNumSub = true;
                                  setEditSave = true;*/
                                });
                              },
                              child: const Text("Edit"))
                        ],
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      ElevatedButton(
                          onPressed: setEditSave
                              ? () {
                                  try {
                                    _authDataBase.updateWithoutName(
                                        id,
                                        _semTxt.text,
                                        _numSubTxt.text,
                                        _subTxt.text,
                                        _priTxt.text);

                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return Error().msg(context, "Saved");
                                      },
                                    );
                                  } catch (e) {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return Error().errorMsg(
                                            context, "Something went wrong!");
                                      },
                                    );
                                  }
                                }
                              : null,
                          child: const Text("Save"))
                    ],
                  ),
                ),
              );
            } else {
              return const Text("data");
            }
          } else {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "You are logged as a guest",
                    style: GoogleFonts.roboto(
                        fontSize: 15, fontWeight: FontWeight.w400),
                  ),
                  Image.asset(
                    "assets/guest.jpg",
                    width: MediaQuery.of(context).size.width * 0.7,
                    height: MediaQuery.of(context).size.width,
                  ),
                  OutlinedButton(
                    onPressed: () {
                      widget.guestFunction();
                      Navigator.pop(context);
                    },
                    style: OutlinedButton.styleFrom(
                        side: BorderSide(color: Theme.of(context).indicatorColor)),
                    child: const Text(
                      "Back",
                    ),
                    
                  )
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
