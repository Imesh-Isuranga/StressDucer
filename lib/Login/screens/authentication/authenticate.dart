import 'package:flutter/material.dart';
import 'package:stress_ducer/Login/screens/authentication/register.dart';
import 'package:stress_ducer/Login/screens/authentication/sign_in.dart';
class Authenticate extends StatefulWidget{
  const Authenticate({super.key,required this.pressed});

  final void Function() pressed;


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
      return Sign_In(toggle:switchPages, isPressed:widget.pressed);
    }else{
      return Register(toggle:switchPages, isPressed:widget.pressed);
    }
  }
}