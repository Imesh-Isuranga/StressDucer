import 'package:flutter/material.dart';
import 'package:stress_ducer/Login/screens/Home/HomeTabBar/Profile/StudentProfile.dart';
import 'package:stress_ducer/Login/screens/Home/PopUpMenu/Profile_In_Menu/edit_profile.dart';

class ProfileMenu extends StatefulWidget {
  const ProfileMenu({super.key});

  @override
  State<ProfileMenu> createState() => _ProfileMenuState();
}

class _ProfileMenuState extends State<ProfileMenu> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        title: Text(
          "Profile",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
            child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            StudentProfile(text: "Current Semester : "),
            Divider(height: 1),
            StudentProfile(text: "Number Of Subjects : "),
            Divider(height: 1),
            StudentProfile(text: "Subjects : "),
            Divider(height: 1),
            StudentProfile(text: "Priorities : "),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => EditProfile()));
                },
                child: Text("Edit"))
          ],
        )),
      ),
    );
  }
}
