import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:stress_ducer/Transition/maintransition.dart';
import 'package:stress_ducer/model/UserModel.dart';
import 'package:stress_ducer/authentication/authenticate.dart';
import 'package:provider/provider.dart';
import 'package:stress_ducer/Home/mainPlace.dart';
import 'package:stress_ducer/authentication/verify.dart';
import 'package:stress_ducer/services/studentDataBase.dart';
import 'package:stress_ducer/studentWrapper.dart';

class Wrapper extends StatefulWidget {
  const Wrapper({super.key});

  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  bool isgoogleSignIn = false;
  bool hasStudent = false;
  final _authDataBase = dataAuthServices();

  void setStudentDetails(bool setVar) async {
    User? us = FirebaseAuth.instance.currentUser;
    bool studentExists = await _authDataBase.doesStudentExist(us!); // Await the result of the async call
    setState(() {
      hasStudent = studentExists;
      isgoogleSignIn = setVar;
    });
  }

  void refresh(bool setbool) {
    setState(() {});
  }


  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserModel?>(context);

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
            return Authenticate(
              refresh: refresh,
              setStudentDetails: setStudentDetails,
            );
          } else if (isgoogleSignIn && !hasStudent) {
            return StudentWrapper(
                                refresh: refresh);
          } else {
            return const MainPlace();
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
