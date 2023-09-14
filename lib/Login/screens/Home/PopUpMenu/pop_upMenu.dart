import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stress_ducer/Login/Transition/sub_transition.dart';
import 'package:stress_ducer/Login/model/student.dart';
import 'package:stress_ducer/Login/screens/Home/HomeTabBar/TodayTasks/TodayTasks.dart';
import 'package:stress_ducer/Login/screens/Home/PopUpMenu/Profile_In_Menu/profile_menu.dart';
import 'package:stress_ducer/Login/screens/Home/PopUpMenu/personality.dart';
import 'package:stress_ducer/Login/screens/Home/PopUpMenu/Test/testMain.dart';
import 'package:stress_ducer/Login/services/auth.dart';
import 'package:stress_ducer/Login/services/studentDataBase.dart';

class PopUpScreen extends StatefulWidget {
  const PopUpScreen({super.key});



  @override
  State<PopUpScreen> createState() => _PopUpScreenState();
}

class _PopUpScreenState extends State<PopUpScreen> {

  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? user = FirebaseAuth.instance.currentUser;
  String imageUrl = '';

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
    return Column(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(colors: [
            Color(0xFF0e6ba8),
            Color(0xFF0a2472)
          ])),
            child: Column(
              children: [
                const SizedBox(
                  height: 60,
                ),Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  height: 80,
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
            
                const SizedBox(
                  height: 20,
                ),
                
                Text("Hi",style: GoogleFonts.roboto(fontSize: 10,color: Colors.white),),

                StreamBuilder<Student?>(
                      stream: dataAuthServices
                          .readSpecificDocument(_auth.currentUser!.uid),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const TextTransitionSubNew();
                        } else if (snapshot.hasError) {
                          return Text("Error: ${snapshot.error}");
                        } else if (snapshot.hasData) {
                          final student = snapshot.data;
                          if (student != null) {
                            return Text(student
                                .studentName!,style: GoogleFonts.roboto(fontSize: 20,color: Colors.white),); // Return your actual widget
                          } else {
                            return const Text("Student not found");
                          }
                        } else {
                          return OutlinedButton(
                    onPressed: () {
                      AuthServices().signOut();
                    },
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Colors.white),),
                        child: const Text("Login",
                      style: TextStyle(color: Colors.white),
                    )
                  );
                        }
                      },
                    ),

                    const SizedBox(height: 20,)
              ],
            ),
          ),
          SizedBox(
            height: 300,
              child: ListView(
                children: [
                  ListTile(
                    leading: const Icon(Icons.person),
                    title: const Text("Profile"),
                    onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context) => const ProfileMenu()));},
                  ),
                  const Divider(height: 1,),
                  ListTile(
                    leading: const Icon(Icons.alarm),
                    title: const Text("Today Task"),
                    onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context) => MaterialApp(home:Scaffold(body: TodayTasks(currentContext: context,),),)));},
                  ),
                  const Divider(height: 1,),
                  ListTile(
                    leading: const Icon(Icons.image_aspect_ratio),
                    title: const Text("Personality"),
                    onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context) => const Personality()));},
                  ),
                  Divider(height: 1,),
                  ListTile(
                    leading:const Icon(Icons.book_online),
                    title: const Text("Take A Test"),
                    onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context) => const TestMain()));},
                  ),
                ],
              ),
            
          )
        ],
      );
  }
}
