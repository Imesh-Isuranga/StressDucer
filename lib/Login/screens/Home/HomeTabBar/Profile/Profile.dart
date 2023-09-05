import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stress_ducer/Login/model/UserModel.dart';
import 'package:stress_ducer/Login/model/student.dart';
import 'package:stress_ducer/Login/screens/Home/HomeTabBar/Profile/StudentProfile.dart';
import 'package:stress_ducer/Login/services/auth.dart';
import 'package:stress_ducer/Login/services/studentDataBase.dart';
import 'package:stress_ducer/Login/services/timeTableDataBase.dart';

class Profile extends StatefulWidget {
  Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String imageUrl = '';

  final _authData = dataAuthServices();
  final FirebaseAuth auth = FirebaseAuth.instance;
  final _authTimeTable = TimeTableDataBase();
  final TextEditingController howManySubjectsPerDayController =
      TextEditingController();

  void modelBottomPanelProfile() {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return Container(
          height:
              MediaQuery.of(context).size.height, // Take up full screen height
          child: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(8),
              child: const Column(
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  StudentProfile(text: "Name : "),
                  Divider(height: 1),
                  StudentProfile(text: "University : "),
                  Divider(height: 1),
                  StudentProfile(text: "Current Semester : "),
                  Divider(height: 1),
                  StudentProfile(text: "Number Of Subjects : "),
                  Divider(height: 1),
                  StudentProfile(text: "Subjects : "),
                  Divider(height: 1),
                  StudentProfile(text: "Priorities : "),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void modelBottomPanelSettings() {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return Container(
          height:
              MediaQuery.of(context).size.height, // Take up full screen height
          child: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  const Text("How many subjects per day : ",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                      )),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width *
                            0.2, // Set the desired width
                        child: TextField(
                          keyboardType: TextInputType.number,
                          controller: howManySubjectsPerDayController,
                        ),
                      ),
                      TextButton(
                          onPressed: () {
                            _authData.updateEnables(
                                auth.currentUser!.uid, [].toString());
                            _authData.updateHowManySubjects(
                                auth.currentUser!.uid,
                                howManySubjectsPerDayController.text != ""
                                    ? howManySubjectsPerDayController.text
                                    : "1");
                          },
                          child: Text("Save"))
                    ],
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    howManySubjectsPerDayController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _initImageUrl();
  }

  Future<void> _initImageUrl() async {
    try {
      String uid = FirebaseAuth.instance.currentUser!.uid;
      Reference storageRef =
          FirebaseStorage.instance.ref().child('user_images/$uid/profile.jpg');

      // Get the download URL of the image
      String imageUrlnew = await storageRef.getDownloadURL();

      if (mounted == true) {
        setState(() {
          imageUrl = imageUrlnew;
        });
      }
    } catch (error) {
      // Handle any potential errors, e.g., display a default image or an error message.
      print('Error loading image: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    final AuthServices _auth = AuthServices();
    String id = Provider.of<UserModel?>(context)!.uid;
    return Center(
      child: Column(children: [
        Container(
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
            Color.fromARGB(255, 232, 230, 229),
            Color.fromARGB(255, 248, 195, 4)
          ])),
          child: Row(
            children: [
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(bottom: 10),
                  height: 100,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: imageUrl.isNotEmpty
                        ? DecorationImage(
                            image: NetworkImage(imageUrl),
                          )
                        : DecorationImage(
                                    image: AssetImage("assets/man.png"),
                                  ), // Handle the case where imageUrl is empty or invalid
                  ),
                ),
              ),
              const SizedBox(width: 100,),
              
              Expanded(child: StreamBuilder<Student?>(
                stream: dataAuthServices.readSpecificDocument(id),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text("Error: ${snapshot.error}");
                  } else if (snapshot.hasData) {
                    final student = snapshot.data;
                    if (student != null) {
                      return Text(
                        student.studentName!,
                        style: TextStyle(fontSize: 30),
                      ); // Return your actual widget
                    } else {
                      return const Text("Student not found");
                    }
                  } else {
                    return const Text("No data available");
                  }
                },
              ))
            ],
          ),
        ),
        Expanded(
          child: ListView(
            children: <Widget>[
              GestureDetector(
                onTap: modelBottomPanelProfile,
                child: Card(
                  child: ListTile(
                    leading: Icon(Icons.person),
                    title: Text('Profile'),
                  ),
                ),
              ),
              GestureDetector(
                onTap: modelBottomPanelSettings,
                child: Card(
                  child: ListTile(
                    leading: Icon(Icons.settings),
                    title: Text('Settings'),
                  ),
                ),
              ),
              GestureDetector(
                onTap: modelBottomPanelProfile,
                child: Card(
                  child: ListTile(
                    leading: Icon(Icons.help_center),
                    title: Text('Help & Support'),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  _auth.signOut();
                },
                child: Card(
                  child: ListTile(
                    leading: Icon(Icons.logout),
                    title: Text('Log Out'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ]),
    );
  }
}
