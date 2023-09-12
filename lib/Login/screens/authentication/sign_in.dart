import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stress_ducer/Login/constant/colors.dart';
import 'package:stress_ducer/Login/constant/styles.dart';
import 'package:stress_ducer/Login/services/auth.dart';
import 'package:email_validator/email_validator.dart';
import 'package:stress_ducer/Login/services/error.dart';

class Sign_In extends StatefulWidget {
  const Sign_In(
      {super.key,
      required this.toggle,
      required this.setDetails,
      required this.identityGuest});

  final Function toggle;
  final void Function(bool) setDetails;
  final void Function(bool) identityGuest;

  @override
  State<Sign_In> createState() => _SignInState();
}

class _SignInState extends State<Sign_In> {
  final AuthServices _auth = AuthServices();

  final _formKey = GlobalKey<FormState>();
  String email = "";
  String password = "";
  String error = "";
  bool isLoginChecking = false;

  final emailController = TextEditingController();
  final passController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
            image: DecorationImage(
              opacity: 0.3,
              image: AssetImage(
                  'assets/newAuth.jpg'), // Path to your background image
              fit: BoxFit.cover, // Adjust the BoxFit as needed
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 15, right: 10),
            child: Column(
              children: [
                const SizedBox(
                  height: 80,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/logo.png",
                      width: 50,
                      height: 50,
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Text(
                      "LOGIN",
                      style: GoogleFonts.roboto(
                        fontSize: 35,
                        fontWeight: FontWeight.w800,
                        color: const Color.fromARGB(255, 3, 110, 6),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          SizedBox(
                            width: 250,
                            child: TextField(
                              style: const TextStyle(color: Colors.black),
                              controller: emailController,
                              decoration: InputDecoration(
                                labelStyle:
                                    const TextStyle(color: Colors.black),
                                labelText: 'Email',
                                errorText: EmailValidator.validate(
                                        emailController.text)
                                    ? null
                                    : 'Please enter valid email',
                              ),
                              onChanged: (value) => setState(() {
                                email = value;
                              }),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          SizedBox(
                            width: 250,
                            child: TextField(
                              obscureText: true,
                              style: const TextStyle(color: Colors.black),
                              controller: passController,
                              decoration: InputDecoration(
                                labelStyle:
                                    const TextStyle(color: Colors.black),
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
                            height: 18,
                          ),
                          Text(error,
                              style: const TextStyle(
                                  color: Colors.red, fontSize: 12),
                              textAlign: TextAlign.center),
                          const SizedBox(
                            height: 5,
                          ),
                          const Text(
                            "Login with social accounts",
                            style: descriptionStyle,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          GestureDetector(
                            onTap: () async {
                              final user = await _auth.handleGoogleSignIn();
                              if (user == "0") {
                                print('Logged in');
                              } else if (user == "1") {
                                widget.setDetails(true);
                                print('Registered');
                                widget.identityGuest(false);
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
                                child: const Text("REGISTER"),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          ElevatedButton.icon(
                            onPressed: () async {
                              setState(() {
                                isLoginChecking = true;
                              });
                              final user =
                                  await _auth.checkIfEmailExists(email);
                              if (user == "0") {
                                setState(() {
                                  error =
                                      "Email is already associated with a Google Sign-In account.Please use google sign in.";
                                  isLoginChecking = false;
                                });
                              } else if (user == "1") {
                                dynamic result =
                                    await _auth.signInUsingEmailAndPassword(
                                        email, password);
                                if (result == null) {
                                  if (mounted) {
                                    setState(() {
                                      String err = (Error().getError());
                                      int startindex = err.indexOf('[');
                                      int lastindex = err.indexOf(']');
                                      error = err.substring(0, startindex) +
                                          Error()
                                              .getError()
                                              .substring(lastindex + 1);
                                      isLoginChecking = false;
                                    });
                                  }
                                }
                              } else {
                                setState(() {
                                  error = "Please enter a valid email!";
                                  isLoginChecking = false;
                                });
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              backgroundColor: loginButtonColors,
                              padding:
                                  const EdgeInsets.only(left: 15, right: 15),
                              minimumSize: const Size(300, 40),
                            ),
                            icon: isLoginChecking
                                ? Container(
                                    width: 24,
                                    height: 24,
                                    padding: const EdgeInsets.all(2.0),
                                    child: const CircularProgressIndicator(
                                      color: Colors.white,
                                      strokeWidth: 3,
                                    ),
                                  )
                                : const Icon(Icons.sports_handball_sharp),
                            label: const Text('LOGIN'),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          ElevatedButton(
                            onPressed: () async {
                              await _auth.signInAnonymously();
                              widget.identityGuest(true);
                            },
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              backgroundColor: loginButtonColors,
                              padding:
                                  const EdgeInsets.only(left: 15, right: 15),
                              minimumSize: const Size(300, 40),
                            ),
                            child: const Text(
                              "LOG AS GUEST",
                              style: TextStyle(fontSize: 15),
                            ),
                          )
                        ],
                      )),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

