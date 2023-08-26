import 'package:flutter/material.dart';
import 'package:stress_ducer/Login/model/UserModel.dart';
import 'package:stress_ducer/Login/screens/authentication/authenticate.dart';
import 'package:provider/provider.dart';
import 'package:stress_ducer/Login/screens/Home/mainPlace.dart';
import 'package:stress_ducer/Login/studentWrapper.dart';

class Wrapper extends StatefulWidget {
  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  bool isSetDetails = false;

  void setStudentDetails() {
    setState(() {
      isSetDetails = !isSetDetails; // Toggle the value
    });
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserModel?>(context);
    print(user==null);
    if (user == null) {
      return Authenticate(pressed: setStudentDetails);
    } else {
      if (isSetDetails) {
        return StudentWrapper(Pressed: setStudentDetails,id:user.uid);
      } else {
        return MainPlace();
      }
    }
  }
}

