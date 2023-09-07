import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stress_ducer/Login/services/auth.dart';
import 'package:stress_ducer/Login/studentWrapper.dart';

class Verify extends StatefulWidget {
  const Verify({super.key, required this.Pressed, required this.StateChange});

  final void Function() Pressed;
  final void Function() StateChange;

  @override
  State<Verify> createState() => _VerifyState();
}

class _VerifyState extends State<Verify> {
  final auth = FirebaseAuth.instance;
  late User? user;
  late Timer timer;

  @override
  void initState() {
    print("00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000");
    user = auth.currentUser;
    user!.sendEmailVerification();

    timer = Timer.periodic(Duration(seconds: 5), (timer) {
      checkEmailVerify();
    });
    super.initState();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text("Verification",style: GoogleFonts.roboto(fontSize: 20,color: Colors.black),),
        ),
        body: Container(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                        "An email has been sent to ${user!.emailVerified}.Please verify.",style: GoogleFonts.roboto(fontSize: 20,fontWeight: FontWeight.w400),textAlign: TextAlign.center,),
                        const SizedBox(height: 20,),
                        OutlinedButton(onPressed: (){AuthServices().signOut();widget.StateChange();}, child: const Text("Back",style: TextStyle(color: Colors.black),),style: OutlinedButton.styleFrom(side: BorderSide(width: 2.0, color: Colors.black),)),
                  ],
                ),
              ),
            )),
      ),
    );
  }

  Future<void> checkEmailVerify() async {
    user = auth.currentUser;
    await user!.reload();
    if (user!.emailVerified) {
      timer.cancel();
      widget.Pressed();
    }
  }
}
