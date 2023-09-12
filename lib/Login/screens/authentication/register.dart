import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stress_ducer/Login/constant/colors.dart';
import 'package:stress_ducer/Login/constant/styles.dart';
import 'package:stress_ducer/Login/services/auth.dart';
import 'package:stress_ducer/Login/services/error.dart';

class Register extends StatefulWidget {
  const Register(
      {super.key,
      required this.toggle,
      required this.setDetails,
      required this.identityGuest});

  final Function toggle;
  final void Function(bool) setDetails;
  final void Function(bool) identityGuest;

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
  bool isRegisterChecking = false;

  String errorDisplay() {
    return Error().getError();
  }

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
                      "REGISTER",
                      style: GoogleFonts.roboto(
                        fontSize: 35,
                        fontWeight: FontWeight.w800,
                        color: Color.fromARGB(255, 3, 110, 6),
                      ),
                    ),
                  ],
                ),
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
                                setState(() {
                                  error = "";
                                  email = value;
                                });
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
                                setState(() {
                                  error = "";
                                  password = value;
                                });
                              }),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            error,
                            style: const TextStyle(
                                color: Colors.red, fontSize: 12),
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
                                widget.identityGuest(false);
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
                          ElevatedButton.icon(
                            onPressed: () async {
                              setState(() {
                                isRegisterChecking = true;
                              });
                              final user =
                                  await _auth.checkIfEmailExists(email);
                              if (user == "0") {
                                setState(() {
                                  error =
                                      "Email is already associated with a Google Sign-In account.Please use google sign in.";
                                  isRegisterChecking = false;
                                });
                              } else if (user == "1") {
                                try {
                                  dynamic result =
                                      await _auth.registerWithEmailAndPassword(
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
                                        isRegisterChecking = false;
                                      });
                                    }
                                  }
                                  widget.identityGuest(false);
                                } catch (e) {
                                  if (mounted) {
                                    setState(() {
                                      error = "Please enter a valid email!";
                                      isRegisterChecking = true;
                                    });
                                  }
                                }
                              } else {
                                if (mounted) {
                                  setState(() {
                                    error = "Please enter a valid email!";
                                    isRegisterChecking = false;
                                  });
                                }
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
                            icon: isRegisterChecking
                                ? Container(
                                    width: 24,
                                    height: 24,
                                    padding: const EdgeInsets.all(2.0),
                                    child: const CircularProgressIndicator(
                                      color: Colors.white,
                                      strokeWidth: 3,
                                    ),
                                  )
                                : const Icon(Icons.co_present_outlined),
                            label: const Text('REGISTER'),
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
      ),
    );
  }
}
