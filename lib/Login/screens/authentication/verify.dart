import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stress_ducer/Login/services/auth.dart';
import 'package:stress_ducer/Login/Transition/sizeTransition.dart';

class Verify extends StatefulWidget {
  const Verify(
      {super.key,required this.refresh});

      final void Function(bool) refresh;


  @override
  State<Verify> createState() => _VerifyState();
}

class _VerifyState extends State<Verify>{
  final auth = FirebaseAuth.instance;
  late User? user;
  late Timer timer;
  bool emailVerified = false;
  String text = '';

  @override
  void initState() {
    user = auth.currentUser;
    user!.sendEmailVerification();

    timer = Timer.periodic(const Duration(seconds: 5), (timer) {
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
        body:  Center(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizeTransitionExample(),
                const SizedBox(height: 20,),
                Text(
                  "An email has been sent to verify.Check your inbox.",
                  style: GoogleFonts.roboto(
                      fontSize: 20, fontWeight: FontWeight.w400),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 20,
                ),
                OutlinedButton(
                  onPressed: () {

                    AuthServices().deleteAccount();
                  },
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(width: 2.0, color: Colors.black),
                  ),
                  child: const Text(
                    "Back",
                    style: TextStyle(color: Colors.black),
                  ),
                  
                ),
              ],
            ),
          ),
        )
      ),
    );
  }

  Future<void> checkEmailVerify() async {
    user = auth.currentUser;
    await user!.reload();
    if (user!.emailVerified) {
      print("Email verified successfully!");
      emailVerified = true;
      widget.refresh(true);
      timer.cancel();
    }
  }
}
