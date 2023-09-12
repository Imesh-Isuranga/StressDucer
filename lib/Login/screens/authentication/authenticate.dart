import 'package:flutter/material.dart';
import 'package:stress_ducer/Login/screens/authentication/register.dart';
import 'package:stress_ducer/Login/screens/authentication/sign_in.dart';
class Authenticate extends StatefulWidget{
  const Authenticate({super.key,required this.setDetails,required this.identityGuest});

  final void Function(bool) setDetails;
  final void Function(bool) identityGuest;



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
      return Sign_In(toggle:switchPages,setDetails:widget.setDetails,identityGuest:widget.identityGuest);
    }else{
      return Register(toggle:switchPages,setDetails:widget.setDetails,identityGuest:widget.identityGuest);
    }
  }
}