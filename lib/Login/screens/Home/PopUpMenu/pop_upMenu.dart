import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:stress_ducer/Login/Transition/sub_transition.dart';
import 'package:stress_ducer/Login/model/student.dart';
import 'package:stress_ducer/Login/screens/Home/HomeTabBar/Home/AddTasks/addedTasksCard.dart';
import 'package:stress_ducer/Login/screens/Home/HomeTabBar/TodayTasks.dart';
import 'package:stress_ducer/Login/screens/Home/PopUpMenu/Profile_In_Menu/profile_menu.dart';
import 'package:stress_ducer/Login/screens/Home/PopUpMenu/personality.dart';
import 'package:stress_ducer/Login/services/studentDataBase.dart';

class PopUpScreen extends StatefulWidget {
  const PopUpScreen({super.key});

  @override
  State<PopUpScreen> createState() => _PopUpScreenState();
}

class _PopUpScreenState extends State<PopUpScreen> {

  final FirebaseAuth _auth = FirebaseAuth.instance;
  String imageUrl = '';

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
    return Container(
      child: Column(
        children: [
          Container(
            color: Colors.green,
            child: Column(
              children: [
                SizedBox(
                  height: 60,
                ),Container(
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
            
                SizedBox(
                  height: 20,
                ),
                
                Text("Hi"),

                StreamBuilder<Student?>(
                      stream: dataAuthServices
                          .readSpecificDocument(_auth.currentUser!.uid),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return TextTransitionSubNew();
                        } else if (snapshot.hasError) {
                          return Text("Error: ${snapshot.error}");
                        } else if (snapshot.hasData) {
                          final student = snapshot.data;
                          if (student != null) {
                            return Text(student
                                .studentName!); // Return your actual widget
                          } else {
                            return const Text("Student not found");
                          }
                        } else {
                          return const Text("No data available");
                        }
                      },
                    ),

                    const SizedBox(height: 20,)
              ],
            ),
          ),
          Container(
            height: 300,
              child: ListView(
                children: [
                  ListTile(
                    leading: Icon(Icons.person),
                    title: Text("Profile"),
                    onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context) => ProfileMenu()));},
                  ),
                  Divider(height: 1,),
                  ListTile(
                    leading: Icon(Icons.alarm),
                    title: Text("Today Task"),
                    onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context) => MaterialApp(home: Scaffold(appBar: AppBar(title: Text("Today Tasks"),),body: TodayTasks(),))));},
                  ),
                  Divider(height: 1,),
                  ListTile(
                    leading: Icon(Icons.abc),
                    title: Text("Personality"),
                    onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context) => Personality()));},
                  ),
                  Divider(height: 1,),
                  ListTile(
                    leading: Icon(Icons.abc),
                    title: Text("data"),
                    onTap: (){},
                  )
                ],
              ),
            
          )
        ],
      ),
    );
  }
}
