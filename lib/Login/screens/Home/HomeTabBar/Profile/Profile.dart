import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
  User? user = FirebaseAuth.instance.currentUser;
  String imageUrl = "";

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
                          child: const Text("Save"))
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
    setState(() {
      imageUrl = user!.photoURL==null ? "" : user!.photoURL.toString();
    });
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
        const SizedBox(height: 20,),
        Container(
          padding: const EdgeInsets.all(20),
          color: Theme.of(context).scaffoldBackgroundColor,
         /* decoration: const BoxDecoration(
              gradient: LinearGradient(colors: [
            Color(0xFF0e6ba8),
            Color(0xFF0a2472)
          ])),*/
          child: Row(
            children: [

           /*   CircleAvatar(
                radius: 46,
                backgroundColor: Theme.of(context).iconTheme.color,
                child: CircleAvatar(
                  radius: 54,
                  child: CircleAvatar(
                    child: Image.asset("assets/man.png"),
                    backgroundColor: Colors.pink,
                    radius: 40,
                  ),
                ),
              ),*/

              Expanded(
                child: Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  height: 100,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: imageUrl.isNotEmpty
                        ? DecorationImage(
                            image: NetworkImage(imageUrl),
                          )
                        : const DecorationImage(
                                    image: AssetImage("assets/man.png"),
                                  ), // Handle the case where imageUrl is empty or invalid
                  ),
                ),
              ),
              const SizedBox(width: 50,),
              
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
                        style: GoogleFonts.roboto(fontSize: 25,),textAlign: TextAlign.center,
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
                child: Container(
                  decoration: BoxDecoration(
    border: Border(
      bottom: BorderSide(width: 0.3, color: Theme.of(context).indicatorColor), // Top border width and color
    ),
  ),
                  child: Card(
                    child: ListTile(
                      leading: Icon(Icons.person),
                      iconColor: Theme.of(context).iconTheme.color,
                      title: Text('Profile'),
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: modelBottomPanelSettings,
                child: Container(
                  decoration: BoxDecoration(
    border: Border(
      bottom: BorderSide(width: 0.3, color: Theme.of(context).indicatorColor), // Top border width and color
    ),
  ),
                  child: Card(
                    child: ListTile(
                      leading: Icon(Icons.settings),
                      iconColor: Theme.of(context).iconTheme.color,
                      title: Text('Settings'),
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: (){},
                child: Container(
                  decoration: BoxDecoration(
    border: Border(
      bottom: BorderSide(width: 0.3, color: Theme.of(context).indicatorColor), // Top border width and color
    ),
  ),
                  child: Card(
                    child: ListTile(
                      leading: Icon(Icons.settings),
                      iconColor: Theme.of(context).iconTheme.color,
                      title: Text('Dark'),
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: modelBottomPanelProfile,
                child: Container(
                  decoration: BoxDecoration(
    border: Border(
      bottom: BorderSide(width: 0.3, color: Theme.of(context).indicatorColor), // Top border width and color
    ),
  ),
                  child: Card(
                    child: ListTile(
                      leading: Icon(Icons.help_center),
                      iconColor: Theme.of(context).iconTheme.color,
                      title: Text('Help & Support'),
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  _auth.signOut();
                },
                child: Container(
                  decoration: BoxDecoration(
    border: Border(
      bottom: BorderSide(width: 0.3, color: Theme.of(context).indicatorColor), // Top border width and color
    ),
  ),
                  child: Card(
                    child: ListTile(
                      leading: Icon(Icons.logout),
                      iconColor: Theme.of(context).iconTheme.color,
                      title: Text('Log Out'),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 100,),
              Column(children: [
              Image.asset("assets/logo.png",width: 50,height: 50,),
              const SizedBox(height: 10,),
              Text("StressDucer",style: GoogleFonts.roboto(fontSize: 15,color: Color.fromARGB(255, 143, 143, 143)),)],)
            ],
          ),
        ),
      ]),
    );
  }
}
