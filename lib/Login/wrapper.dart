import 'package:flutter/material.dart';
import 'package:stress_ducer/Login/Transition/maintransition.dart';
import 'package:stress_ducer/Login/model/UserModel.dart';
import 'package:stress_ducer/Login/screens/authentication/authenticate.dart';
import 'package:provider/provider.dart';
import 'package:stress_ducer/Login/screens/Home/mainPlace.dart';
import 'package:stress_ducer/Login/screens/authentication/verify.dart';
import 'package:stress_ducer/Login/studentWrapper.dart';

class Wrapper extends StatefulWidget {
  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  bool isSetDetails = false;
  bool isEmailVerified = false;

  void setStudentDetails() {
    setState(() {
      isSetDetails = !isSetDetails; // Toggle the value
    });
  }

  void emailVerified() {
    setState(() {
      print("111111111111111111111111111111111");
      isEmailVerified = true; // Toggle the value
    });
  }

  void setStateAgain() {
    setState(() {
      isSetDetails = false;
      isEmailVerified = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserModel?>(context);
    print(
        "222222222222222222222222222222222222222222222222222222222222222222======================");
    print(isEmailVerified);

    return FutureBuilder(
      future: fetchData(user), // Replace fetchData with your data loading logic
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // Show a circular progress indicator while loading
          return TextTransitionNew();
        } else if (snapshot.hasError) {
          return Text("Error: ${snapshot.error}");
        } else {
          // Depending on your data, conditionally return different widgets
          if (user == null) {
            isEmailVerified = false;
            return Authenticate(pressed: setStudentDetails);
          } else {
            if (isSetDetails) {
              print(
                  "222222222222222222222222222222222222222222222222222222222222222222");
              print(isEmailVerified);
              if (!isEmailVerified) {
                return Verify(Pressed: emailVerified,StateChange:setStateAgain);
              } else {
                return StudentWrapper(Pressed: setStudentDetails, id: user.uid);
              }
            } else {
              return MainPlace();
            }
          }
        }
      },
    );
  }

  Future fetchData(UserModel? user) async {
    // Simulate loading data with a delay for demonstration purposes
    await Future.delayed(Duration(seconds: 2));

    // Replace this with your actual data loading logic
    // You can fetch data, perform computations, etc.
  }
}
