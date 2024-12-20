import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stress_ducer/services/auth.dart';
import 'package:email_validator/email_validator.dart';
import 'package:stress_ducer/services/error.dart';

class Sign_In extends StatefulWidget {
  const Sign_In(
      {super.key, required this.toggle, required this.setStudentDetails});

  final Function toggle;
  final void Function(bool) setStudentDetails;

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
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        height: screenHeight,
        width: screenWidth,
        decoration: const BoxDecoration(
          image: DecorationImage(
            opacity: 0.3,
            image: AssetImage(
                'assets/newAuth.jpg'), // Path to your background image
            fit: BoxFit.cover, // Adjust the BoxFit as needed
          ),
        ),
        alignment: Alignment.center,
        child: Container(
          height: screenHeight * 0.85,
          width: screenWidth * 0.9,
          color: const Color.fromARGB(186, 255, 255, 255),
          alignment: Alignment.center,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/logo.png",
                      width: screenWidth * 0.1,
                      height: screenHeight * 0.1,
                    ),
                    SizedBox(
                      width: screenWidth * 0.02,
                    ),
                    Text(
                      "LOGIN",
                      style: GoogleFonts.roboto(
                        fontSize: screenWidth * 0.08,
                        fontWeight: FontWeight.w800,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: screenHeight * 0.002,
                ),
                Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: screenWidth * 0.7,
                          child: TextField(
                            style: GoogleFonts.roboto(
                                color: const Color.fromARGB(255, 0, 0, 0),
                                fontSize: screenWidth * 0.035),
                            controller: emailController,
                            decoration: InputDecoration(
                              labelStyle: GoogleFonts.roboto(
                                  color: const Color.fromARGB(255, 0, 0, 0),
                                  fontSize: screenWidth * 0.035),
                              labelText: 'Email',
                              errorText:
                                  EmailValidator.validate(emailController.text)
                                      ? null
                                      : '*Please enter valid Email',
                              errorStyle: GoogleFonts.roboto(
                                  color: const Color.fromARGB(255, 255, 0, 0),
                                  fontSize: screenWidth * 0.03),
                            ),
                            onChanged: (value) => setState(() {
                              error = "";
                              email = value;
                            }),
                          ),
                        ),
                        SizedBox(
                          height: screenHeight * 0.02,
                        ),
                        SizedBox(
                          width: screenWidth * 0.7,
                          child: TextField(
                            obscureText: true,
                            style: GoogleFonts.roboto(
                                color: const Color.fromARGB(255, 0, 0, 0),
                                fontSize: screenWidth * 0.035),
                            controller: passController,
                            decoration: InputDecoration(
                              labelStyle: GoogleFonts.roboto(
                                  color: const Color.fromARGB(255, 0, 0, 0),
                                  fontSize: screenWidth * 0.035),
                              labelText: 'Password',
                              errorText: passController.text.length > 5
                                  ? null
                                  : '*Please enter valid Password',
                              errorStyle: GoogleFonts.roboto(
                                  color: const Color.fromARGB(255, 255, 0, 0),
                                  fontSize: screenWidth * 0.03),
                            ),
                            onChanged: (value) => setState(() {
                              error = "";
                              password = value;
                            }),
                          ),
                        )
                      ],
                    )),
                SizedBox(
                  height: screenHeight * 0.02,
                ),
                Text(error,
                    style: GoogleFonts.roboto(
                        color: Colors.red, fontSize: screenWidth * 0.03),
                    textAlign: TextAlign.center),
                SizedBox(
                  height: screenHeight * 0.02,
                ),
                Text(
                  "Login with social accounts",
                  style: GoogleFonts.roboto(
                      color: const Color.fromARGB(255, 0, 0, 0),
                      fontSize: screenWidth * 0.035),
                ),
                //    SizedBox(height: screenHeight*0.02,),
                GestureDetector(
                  onTap: () async {
                    var connectivityResult =
                        await (Connectivity().checkConnectivity());
                    if (connectivityResult == ConnectivityResult.none) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          backgroundColor: const Color.fromARGB(255, 33, 4, 2),
                          content: const Text(
                            'Something went wrong! May be No internet connection',
                            style: TextStyle(color: Colors.white),
                          ),
                          action: SnackBarAction(
                            label: 'Close',
                            onPressed: () {},
                          ),
                        ),
                      );
                    } else {
                      final user = await _auth.handleGoogleSignIn();
                      widget.setStudentDetails(true);
                      print(
                          'Logged in--------------------------------------------------------------123');
                      print(user);
                      if (user == "0") {
                        print(
                            'Logged in--------------------------------------------------------------');
                      } else if (user == "1") {
                        print(
                            'Registered--------------------------------------------------------------');
                        //widget.identityGuest(false,false);
                      } else {
                        print('Sign-in failed.');
                      }
                    }
                  },
                  child: Center(
                    child: Image.asset(
                      "assets/G.png",
                      width: screenWidth * 0.12,
                      height: screenHeight * 0.12,
                    ),
                  ),
                ),
                //    SizedBox(height: ScreenHeight*0.02,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Do not have an account",
                      style: GoogleFonts.roboto(
                          color: const Color.fromARGB(255, 0, 0, 0),
                          fontSize: screenWidth * 0.035),
                    ),
                    SizedBox(
                      width: screenWidth * 0.02,
                    ),
                    TextButton(
                      onPressed: () {
                        widget.toggle();
                      },
                      child: Text("REGISTER",
                          style: GoogleFonts.roboto(
                              color: const Color.fromARGB(255, 0, 0, 0),
                              fontSize: screenWidth * 0.036)),
                    )
                  ],
                ),
                //  SizedBox(height: ScreenHeight*0.02,),
                ElevatedButton.icon(
                  onPressed: () async {
                    var connectivityResult =
                        await (Connectivity().checkConnectivity());
                    if (connectivityResult == ConnectivityResult.none) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          backgroundColor: const Color.fromARGB(255, 33, 4, 2),
                          content: const Text(
                            'Something went wrong! May be No internet connection',
                            style: TextStyle(color: Colors.white),
                          ),
                          action: SnackBarAction(
                            label: 'Close',
                            onPressed: () {},
                          ),
                        ),
                      );
                    } else {
                      setState(() {
                        isLoginChecking = true;
                      });
                      final user = await _auth.checkIfEmailExists(email);
                      if (user == "0") {
                        setState(() {
                          error =
                              "Email is already associated with a Google Sign-In account.Please use google sign in.";
                          isLoginChecking = false;
                        });
                      } else if (user == "1") {
                        dynamic result = await _auth
                            .signInUsingEmailAndPassword(email, password);
                        print(result);
                        print(result);
                        if (result == null) {
                          if (mounted) {
                            setState(() {
                              String err = (Error().getError());
                              int startindex = err.indexOf('[');
                              int lastindex = err.indexOf(']');
                              error = err.substring(0, startindex) +
                                  Error().getError().substring(lastindex + 1);
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
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    backgroundColor: Theme.of(context).primaryColor,
                    padding: EdgeInsets.only(
                        left: screenWidth * 0.02, right: screenWidth * 0.02),
                    minimumSize: Size(screenWidth * 0.8, screenHeight * 0.05),
                  ),
                  icon: isLoginChecking
                      ? Container(
                          width: screenHeight * 0.03,
                          height: screenHeight * 0.03,
                          padding: const EdgeInsets.all(2.0),
                          child: const CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 3,
                          ),
                        )
                      : Icon(
                          Icons.sports_handball_sharp,
                          size: screenWidth * 0.045,
                        ),
                  label: Text('LOGIN',
                      style: GoogleFonts.roboto(
                          color: const Color.fromARGB(255, 255, 255, 255),
                          fontSize: screenWidth * 0.035,
                          fontWeight: FontWeight.w500)),
                ),
                SizedBox(height: screenHeight * 0.02),
                ElevatedButton(
                  onPressed: () async {
                    var connectivityResult =
                        await (Connectivity().checkConnectivity());
                    if (connectivityResult == ConnectivityResult.none) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          backgroundColor: const Color.fromARGB(255, 33, 4, 2),
                          content: const Text(
                            'Something went wrong! May be No internet connection',
                            style: TextStyle(color: Colors.white),
                          ),
                          action: SnackBarAction(
                            label: 'Close',
                            onPressed: () {},
                          ),
                        ),
                      );
                    } else {
                      await _auth.signInAnonymously();
                      //widget.identityGuest(true,false);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    backgroundColor: Theme.of(context).primaryColor,
                    padding: EdgeInsets.only(
                        left: screenWidth * 0.02, right: screenWidth * 0.02),
                    minimumSize: Size(screenWidth * 0.8, screenHeight * 0.05),
                  ),
                  child: Text("LOG AS GUEST",
                      style: GoogleFonts.roboto(
                          color: const Color.fromARGB(255, 255, 255, 255),
                          fontSize: screenWidth * 0.035,
                          fontWeight: FontWeight.w500)),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
