import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:stress_ducer/model/UserModel.dart';
import 'package:stress_ducer/model/student.dart';
import 'package:stress_ducer/Home/HomeTabBar/Profile/StudentProfile.dart';
import 'package:stress_ducer/Home/HomeTabBar/Profile/aboutUs.dart';
import 'package:stress_ducer/Home/HomeTabBar/Profile/helpAndSupport.dart';
import 'package:stress_ducer/Home/HomeTabBar/Profile/reduceStress.dart';
import 'package:stress_ducer/services/auth.dart';
import 'package:stress_ducer/services/studentDataBase.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});



  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  User? user = FirebaseAuth.instance.currentUser;
  static String imageUrl = "";

  final _authData = dataAuthServices();
  final FirebaseAuth auth = FirebaseAuth.instance;
//  final _authTimeTable = TimeTableDataBase();
  double _currentSliderValue = 20;
  static int number=1;


      

  void modelBottomPanelProfile() {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return SizedBox(
          height:MediaQuery.of(context).size.height, // Take up full screen height
          child: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(8),
              child: Column(
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height*0.05,),
                  const StudentProfile(text: "Name : "),
                  const Divider(height: 1),
                  const StudentProfile(text: "University : "),
                  const Divider(height: 1),
                  const StudentProfile(text: "Current Semester : "),
                  const Divider(height: 1),
                  const StudentProfile(text: "Number Of Subjects : "),
                  const Divider(height: 1),
                  const StudentProfile(text: "Subjects : "),
                  const Divider(height: 1),
                  const StudentProfile(text: "Priorities : "),
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
      context : context,
      builder: (context) {
        return SizedBox(
          height:MediaQuery.of(context).size.height, // Take up full screen height
          child: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height:MediaQuery.of(context).size.height*0.05,),
                  Text("TimeTable Settings",style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.05,fontWeight: FontWeight.w700,)),
                  SizedBox(height: MediaQuery.of(context).size.height*0.02,),
                  Divider(color: Theme.of(context).indicatorColor, thickness: 1,),
                  SizedBox(height: MediaQuery.of(context).size.height*0.02,),
                  Text("Get New TimeTable",style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.042)),
                  TextButton(
                          onPressed: () {
                            if(number>7){
                              number = 1;
                            }
                            _authData.updateEnables(
                                auth.currentUser!.uid, [].toString());
                            _authData.updateChangeSubjectsCount(
                                auth.currentUser!.uid,
                                number.toString() != ""
                                    ? number.toString()
                                    : "1");
                                    number++;
                          },
                          child: Text("Refresh",style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.025),),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height*0.05,),
                    Text("Complex Time Table",style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.042)),
                    SizedBox(height: MediaQuery.of(context).size.height*0.01,),
                    Text('Complexity : $_currentSliderValue',style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.032)),
                    StatefulBuilder(builder: (context, setState) {
                      return Slider(
                      value: _currentSliderValue,
                      max: 100,
                      divisions: 10,
                      label: (_currentSliderValue/10).round().toString(),
                      onChanged: (double value) {
                      setState(() {
                        if(value==0.0){
                          value = 10;
                          _currentSliderValue = value;
                        }else{
                          _currentSliderValue = value;
                        } 
                            _authData.updateEnables(
                                auth.currentUser!.uid, [].toString());
                            _authData.updateChangeSubjectsCount(
                                auth.currentUser!.uid,
                                ((value/10).round()).toString() == ""
                                    ? "1"
                                    : ((value/10).round()).toString());
                      });
                      },
                   );
                    },)
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
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _initImageUrl();

    Stream<Student?> studentStream =
        dataAuthServices.readSpecificDocument(auth.currentUser!.uid);

    studentStream.listen((student) {
      if (student != null) {
        if (mounted == true) {
          setState(() {
            imageUrl = user!.photoURL==null ? "" : user!.photoURL.toString();
            _currentSliderValue = double.parse(student.changeSubjectsCount ?? "1");
          });
        }}},
        );
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
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final AuthServices auth = AuthServices();
    String id = Provider.of<UserModel?>(context)!.uid;

    return ListView(children: [
      Card(
              margin: const EdgeInsets.all(0),
              child: Padding(
                padding: EdgeInsets.only(left: screenWidth*0.09,top: screenWidth*0.09,right: screenWidth*0.02,bottom: screenWidth*0.09),
                child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              SizedBox(
                                width: screenHeight*0.1,
                                height: screenHeight*0.1,
                                child: Container(
                                  margin: const EdgeInsets.only(bottom: 10),
                                  height: screenHeight*0.1,
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
                              SizedBox(width: screenWidth*0.05,),
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
                                        style: GoogleFonts.roboto(fontSize: screenWidth*0.05,),textAlign: TextAlign.center,
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
                          ),
              SizedBox(height: screenHeight * 0.005,),
              GestureDetector(
                onTap: modelBottomPanelProfile,
                child: Container(
                decoration: BoxDecoration(
                border: Border(bottom: BorderSide(width: 0.3, color: Theme.of(context).indicatorColor),),),
                  child: Card(
                    child: ListTile(
                      leading: Icon(Icons.person,size: screenWidth*0.05,),
                      iconColor: Theme.of(context).iconTheme.color,
                      title: Text('Profile',style: GoogleFonts.roboto(fontSize: screenWidth*0.038,fontWeight: FontWeight.w400),),
                    ),
                  ),
                ),
              ),

              GestureDetector(
                onTap: modelBottomPanelSettings,
                child: Container(
                decoration: BoxDecoration(
                border: Border(bottom: BorderSide(width: 0.3, color: Theme.of(context).indicatorColor),),),
                  child: Card(
                    child: ListTile(
                      leading: Icon(Icons.settings,size: screenWidth*0.05,),
                      iconColor: Theme.of(context).iconTheme.color,
                      title: Text('Settings',style: GoogleFonts.roboto(fontSize: screenWidth*0.038,fontWeight: FontWeight.w400),),
                    ),
                  ),
                ),
              ),


              GestureDetector(
                onTap: (){Navigator.push(context,MaterialPageRoute(builder: (context) => const ReduceStress()));},
                child: Container(
                decoration: BoxDecoration(
                border: Border(bottom: BorderSide(width: 0.3, color: Theme.of(context).indicatorColor),),),
                  child: Card(
                    child: ListTile(
                      leading: Icon(Icons.help_center,size: screenWidth*0.05,),
                      iconColor: Theme.of(context).iconTheme.color,
                      title: Text('Stress Relief Tips',style: GoogleFonts.roboto(fontSize: screenWidth*0.038,fontWeight: FontWeight.w400),),
                    ),
                  ),
                ),
              ),


              GestureDetector(
                onTap: (){Navigator.push(context,MaterialPageRoute(builder: (context) => const HelpAndSupport()));},
                child: Container(
                decoration: BoxDecoration(
                border: Border(bottom: BorderSide(width: 0.3, color: Theme.of(context).indicatorColor),),),
                  child: Card(
                    child: ListTile(
                      leading: Icon(Icons.help_center,size: screenWidth*0.05,),
                      iconColor: Theme.of(context).iconTheme.color,
                      title: Text('Help & Support',style: GoogleFonts.roboto(fontSize: screenWidth*0.038,fontWeight: FontWeight.w400),),
                    ),
                  ),
                ),
              ),

              GestureDetector(
                onTap: (){Navigator.push(context,MaterialPageRoute(builder: (context) => const AboutUs()));},
                child: Container(
                decoration: BoxDecoration(
                border: Border(bottom: BorderSide(width: 0.3, color: Theme.of(context).indicatorColor),),),
                  child: Card(
                    child: ListTile(
                      leading: Icon(Icons.groups_2_rounded,size: screenWidth*0.05,),
                      iconColor: Theme.of(context).iconTheme.color,
                      title: Text('About Us',style: GoogleFonts.roboto(fontSize: screenWidth*0.038,fontWeight: FontWeight.w400),),
                    ),
                  ),
                ),
              ),


              GestureDetector(
                onTap: () {
                  auth.signOut();
                },
                child: Container(
                decoration: BoxDecoration(
                border: Border(bottom: BorderSide(width: 0.3, color: Theme.of(context).indicatorColor),),),
                  child: Card(
                    child: ListTile(
                      leading: Icon(Icons.logout,size: screenWidth*0.05,),
                      iconColor: Theme.of(context).iconTheme.color,
                      title: Text('LogOut',style: GoogleFonts.roboto(fontSize: screenWidth*0.038,fontWeight: FontWeight.w400),),
                    ),
                  ),
                ),
              ),

              SizedBox(height: screenHeight*0.08,),
              Column(children: [
              Image.asset("assets/logo.png",width: screenHeight*0.06,height: screenHeight*0.06,),
              SizedBox(height: screenHeight*0.02,),
              Text("StressDucer",style: GoogleFonts.roboto(fontSize: screenWidth*0.03,color: const Color.fromARGB(255, 143, 143, 143)),),],)
    ],
    );
  }
}
