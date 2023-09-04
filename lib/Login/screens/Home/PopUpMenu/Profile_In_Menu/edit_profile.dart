import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stress_ducer/Login/model/UserModel.dart';
import 'package:stress_ducer/Login/model/student.dart';
import 'package:stress_ducer/Login/screens/Home/HomeTabBar/Profile/StudentProfile.dart';
import 'package:stress_ducer/Login/services/studentDataBase.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

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
        title: Text("Profile"),
      ),
      body: StreamBuilder<Student?>(
        stream: dataAuthServices
            .readSpecificDocument(id),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
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
                child: Container(
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
                          TextButton(onPressed: () {setState(() {
                            setEditSem = true;
                            setEditSave = true;
                          });}, child: const Text("Edit"))
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
                          TextButton(onPressed: () {
                            setState(() {
                            setEditNumSub = true;
                            setEditSave = true;
                          });}, child: const Text("Edit"))
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
                                enabled: setEditSub,
                                controller: _subTxt,
                                decoration:const InputDecoration(
                                  labelText: 'Subjects',
                                ),
                              )),
                          const SizedBox(
                            width: 40,
                          ),
                          TextButton(onPressed: () {setState(() {
                            setEditSub = true;
                            setEditSave = true;
                          });}, child: const Text("Edit"))
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
                                enabled: setEditPri,
                                controller: _priTxt,
                                decoration: const InputDecoration(
                                  labelText: 'Priority',
                                ),
                              )),
                         const SizedBox(
                            width: 40,
                          ),
                          TextButton(onPressed: () {setState(() {
                            setEditPri = true;
                            setEditSave = true;
                          });}, child: const Text("Edit"))
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      ElevatedButton(
                          onPressed: setEditSave ? () {
                            _authDataBase.updateWithoutName(
                                id,
                                _semTxt.text,
                                _numSubTxt.text,
                                _subTxt.text,
                                _priTxt.text);
                          } : null,
                          child: Text("Save"))
                    ],
                  ),
                )),
              );
            } else {
              return Text("data");
            }
          } else {
            return Text("data");
          }
        },
      ),
    );
  }
}
