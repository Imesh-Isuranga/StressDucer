import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:stress_ducer/Login/constant/colors.dart';
import 'package:stress_ducer/Login/constant/styles.dart';
import 'package:stress_ducer/Login/services/auth.dart';
import 'package:stress_ducer/Login/services/error.dart';

class Register extends StatefulWidget {
  const Register({super.key, required this.toggle,required this.setDetails});

  final Function toggle;
  final void Function(bool) setDetails;

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthServices _auth = AuthServices();

  final _formKey = GlobalKey<FormState>();
  String email = "";
  String password = "";
  String error = "";

  final emailController = TextEditingController();
  final passController = TextEditingController();

  String errorDisplay(){
    return Error().getError();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          "Register",
          style: TextStyle(color: appBarTextColor),
        ),
        backgroundColor: mainAppBarColor,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 15, right: 10),
          child: Column(
            children: [
              const SizedBox(
                height: 60,
              ),
              Center(
                  child: ClipRRect(
                borderRadius: BorderRadius.circular(55),
                child: Image.asset(
                  "assets/man.png",
                  height: 150,
                  width: 150,
                  fit: BoxFit.cover,
                ),
              )),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.all(12),
                child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          width: 250,
                          child: TextField(
                            controller: emailController,
                            decoration: InputDecoration(
                              labelText: 'Email',
                              errorText:
                                  EmailValidator.validate(emailController.text)
                                      ? null
                                      : 'Please enter valid email',
                            ),
                            onChanged: (value) => setState(() {
                              email = value;
                            }),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          width: 250,
                          child: TextField(
                            obscureText: true,
                            controller: passController,
                            decoration: InputDecoration(
                              labelText: 'Password',
                              errorText: passController.text.length > 5
                                  ? null
                                  : 'Please enter valid Password',
                            ),
                            onChanged: (value) => setState(() {
                              password = value;
                            }),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          error,
                          style:
                              const TextStyle(color: Colors.red, fontSize: 12),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(
                          height: 60,
                        ),
                        const Text(
                          "Login with social accounts",
                          style: descriptionStyle,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        GestureDetector(
                          onTap: () async {
                            final user = await _auth.handleGoogleSignIn();
                            if (user == "0") {
                              print('Logged in');
                            } else if (user == "1") {
                              widget.setDetails(true);
                              print('Registered');
                            } else {
                              print('Sign-in failed.');
                            }
                          },
                          child: Center(
                            child: Image.asset(
                              "assets/G.png",
                              height: 60,
                              width: 60,
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Do not have an account",
                              style: descriptionStyle,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            TextButton(
                              onPressed: () {
                                widget.toggle();
                              },
                              child: const Text("LOGIN"),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        ElevatedButton(
                          onPressed: () async {
                            final user = await _auth.checkIfEmailExists(email);
                            if (user == "0") {
                              setState(() {
                                error =
                                    "Email is already associated with a Google Sign-In account.Please use google sign in.";
                              });
                            } else if (user == "1") {
                              try {
                              dynamic result =
                                  await _auth.registerWithEmailAndPassword(
                                      email, password);
                              if (result == null) {
                                if(mounted){
                                  setState(() {
                                    String err = (Error().getError());
                                    int startindex = err.indexOf('[');
                                    int lastindex = err.indexOf(']');
                                  error =err.substring(0, startindex) + Error().getError().substring(lastindex + 1);
                                });
                                }
                              }
                              } catch (e) {
                                if(mounted){
                                setState(() {
                                error = "Please enter a valid email!";
                              });
                              }
                              }
                            } else {
                              if(mounted){
                                setState(() {
                                error = "Please enter a valid email!";
                              });
                              }
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: loginButtonColors,
                            padding: const EdgeInsets.only(left: 15, right: 15),
                            minimumSize: Size(300, 40),
                          ),
                          child: const Text(
                            "REGISTER",
                            style: TextStyle(fontSize: 15),
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                      ],
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }
}
