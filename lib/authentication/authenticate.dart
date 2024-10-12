import 'package:flutter/material.dart';
import 'package:stress_ducer/authentication/register.dart';
import 'package:stress_ducer/authentication/sign_in.dart';
class Authenticate extends StatefulWidget{
  const Authenticate({super.key,required this.refresh,required this.setStudentDetails});

  final void Function(bool) refresh;
  final void Function(bool) setStudentDetails;

  @override
  State<Authenticate> createState() {
    return _Authenticate();
  }
}

class _Authenticate extends State<Authenticate>{


  bool signinPage = true;

  void switchPages(){
    setState(() {
      signinPage = !signinPage;
    });
  }

  
  @override
  Widget build(BuildContext context) {
    if(signinPage==true){
      return Sign_In(toggle:switchPages,setStudentDetails: widget.setStudentDetails,);
    }else{
      return Register(toggle:switchPages,refresh: widget.refresh,setStudentDetails: widget.setStudentDetails);
    }
  }
}