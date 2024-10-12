import 'package:email_otp/email_otp.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stress_ducer/model/UserModel.dart';
import 'package:stress_ducer/services/auth.dart';
import 'package:stress_ducer/studentWrapper.dart';

class Verify extends StatefulWidget {
  const Verify(
      {super.key,
      required this.email,
      required this.password,
      required this.refresh});

  final String email;
  final String password;
  final void Function(bool) refresh;

  @override
  State<Verify> createState() => _VerifyState();
}

class _VerifyState extends State<Verify> {
  TextEditingController emailController = TextEditingController();
  TextEditingController otpController = TextEditingController();
  final AuthServices _auth = AuthServices();

  Future<bool> reg() async {
    return await _auth.registerWithEmailAndPassword(
        widget.email, widget.password);
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserModel?>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.network(
                "https://img.freepik.com/free-vector/emails-concept-illustration_114360-1355.jpg?w=1380&t=st=1673699432~exp=1673700032~hmac=d65454eb5c72e8310209bf8ae770f849ea388f318dc6b9b1300b24b03e8886ca",
                height: 350,
              ),
            ),
            Card(
              child: Column(
                children: [
                  TextFormField(
                    controller: otpController,
                    decoration: const InputDecoration(
                      hintText: 'Enter OTP',
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      // Call the static method to verify OTP
                      bool isVerified = EmailOTP.verifyOTP(
                        otp: otpController.text, // Add the OTP for verification
                      );

                      if (isVerified) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text("OTP verified successfully")),
                        );
                        // If registration is successful, initialize the user and update the state
                        reg();
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => StudentWrapper(
                                refresh: widget.refresh),
                          ),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text("OTP verification failed")),
                        );
                      }
                    },
                    child: const Text('Verify OTP'),
                  ),
                  ElevatedButton(
                  onPressed: () async {
                    // Call the static method directly on the class
                    bool isOTPSent = await EmailOTP.sendOTP(
                      email: emailController
                          .text, // Add the required email argument
                    );

                    if (isOTPSent) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("OTP has been sent")),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("OTP failed to send")),
                      );
                    }
                  },
                  child: const Text('Send OTP'),
                )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
