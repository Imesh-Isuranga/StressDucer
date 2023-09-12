import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:stress_ducer/Login/Transition/maintransition.dart';
import 'package:stress_ducer/Login/model/UserModel.dart';
import 'package:stress_ducer/Login/screens/authentication/authenticate.dart';
import 'package:provider/provider.dart';
import 'package:stress_ducer/Login/screens/Home/mainPlace.dart';
import 'package:stress_ducer/Login/screens/authentication/verify.dart';
import 'package:stress_ducer/Login/studentWrapper.dart';

class Wrapper extends StatefulWidget {
  const Wrapper({super.key});


  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  bool isSetDetails = false;
  bool isEmailVerified = false;
  bool isGuestUser = false;

  void setStudentDetails(bool setVar) {
    setState(() {
      isSetDetails = setVar; // Toggle the value
    });
  }

void identityGuest(bool setbool) {
    setState(() {
      isGuestUser = setbool; // Toggle the value
      isSetDetails = !setbool;
    });
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserModel?>(context);
    final auth = FirebaseAuth.instance;
    User? us = FirebaseAuth.instance.currentUser;

    return FutureBuilder(
      future: fetchData(user), // Replace fetchData with your data loading logic
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // Show a circular progress indicator while loading
          return const TextTransitionNew();
        } else if (snapshot.hasError) {
          return Text("Error: ${snapshot.error}");
        } else {
          // Depending on your data, conditionally return different widgets
          if (user == null) {
            return Authenticate(setDetails:setStudentDetails,identityGuest:identityGuest);
          }else if(isGuestUser){
            return const MainPlace();
          } else {
            if (!(us!.emailVerified)) {
              return Verify(refresh: setStudentDetails,);
            } else {
              if (isSetDetails) {
                return StudentWrapper(pressed: setStudentDetails, id: user.uid);
              } else {
                return const MainPlace();
              }
            }
          }

          
        }
      },
    );
  }

  Future fetchData(UserModel? user) async {
    // Simulate loading data with a delay for demonstration purposes
    await Future.delayed(const Duration(seconds: 3));
  }
}
