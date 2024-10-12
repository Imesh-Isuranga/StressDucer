import 'package:flutter/material.dart';
import 'package:stress_ducer/Home/HomeTabBar/Profile/StudentProfile.dart';
import 'package:stress_ducer/Home/PopUpMenu/Profile_In_Menu/edit_profile.dart';

class ProfileMenu extends StatefulWidget {
  const ProfileMenu({super.key});


  @override
  State<ProfileMenu> createState() => _ProfileMenuState();
}

class _ProfileMenuState extends State<ProfileMenu> {
  String text = "Edit";

void guestFunction(){
  setState(() {
    text = "Back to Login";
  });
}

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: const Text("Profile",style: TextStyle(color: Colors.white),),
      ),
      body: SingleChildScrollView(
        child: Column(
          children:[
            const SizedBox(height: 20,),
            const StudentProfile(text: "Current Semester : "),
            const Divider(height: 1),
            const StudentProfile(text: "Number Of Subjects : "),
            const Divider(height: 1),
            const StudentProfile(text: "Subjects : "),
            const Divider(height: 1),
            const StudentProfile(text: "Priorities : "),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
                onPressed: () {
                  if(text == "Edit"){
                  Navigator.push(context,MaterialPageRoute(builder: (context) => EditProfile(guestFunction: guestFunction,)));
                  }else{
                    Navigator.pop(context);
                  }
                },
                child: Text(text))
          ],
        ),
      ),
    );
  }
}
