import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
          height: screenHeight*0.85,
        width: screenWidth*0.9,
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
                    Image.asset("assets/logo.png",width: screenWidth*0.1,height: screenHeight*0.1,),
                    SizedBox(width: screenWidth*0.02,),
                    Text("REGISTER",style: GoogleFonts.roboto(fontSize: screenWidth*0.08,fontWeight: FontWeight.w800,color:Theme.of(context).primaryColor,),),
                  ],),
                  SizedBox(height: screenHeight*0.002,),
                  Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                      SizedBox(
                        width: screenWidth*0.7,
                        child: TextField(
                                  style: GoogleFonts.roboto(color: const Color.fromARGB(255, 0, 0, 0), fontSize: screenWidth*0.035),
                                  controller: emailController,
                                  decoration: InputDecoration(
                                    labelStyle: GoogleFonts.roboto(color: const Color.fromARGB(255, 0, 0, 0), fontSize: screenWidth*0.035),
                                    labelText: 'Email',
                                    errorText: EmailValidator.validate(emailController.text)? null: '*Please enter valid Email',
                                    errorStyle: GoogleFonts.roboto(color:const Color.fromARGB(255, 255, 0, 0), fontSize: screenWidth*0.03),
                                    ),
                                  onChanged: (value) => setState(() {
                                    email = value;
                                     error = "";
                                  }),
                                ),
                      ),
                      SizedBox(height: screenHeight*0.02,),
                            SizedBox(
                              width: screenWidth*0.7,
                              child: TextField(
                                obscureText: true,
                                style: GoogleFonts.roboto(color: const Color.fromARGB(255, 0, 0, 0), fontSize: screenWidth*0.035),
                                controller: passController,
                                decoration: InputDecoration(
                                  labelStyle:GoogleFonts.roboto(color: const Color.fromARGB(255, 0, 0, 0), fontSize: screenWidth*0.035),
                                  labelText: 'Password',
                                  errorText: passController.text.length > 5 ? null: '*Please enter valid Password',
                                  errorStyle: GoogleFonts.roboto(color:const Color.fromARGB(255, 255, 0, 0), fontSize: screenWidth*0.03),
                                ),
                                onChanged: (value) => setState(() {
                                  password = value;
                                   error = "";
                                }),
                              ),
                            )
                    ],)
                    ),
                    SizedBox(height: screenHeight*0.02,),
                    Text(error,style: GoogleFonts.roboto(color: Colors.red, fontSize: screenWidth*0.03),textAlign: TextAlign.center),
                    SizedBox(height: screenHeight*0.02,),
                    Text("Login with social accounts",style: GoogleFonts.roboto(color: const Color.fromARGB(255, 0, 0, 0), fontSize: screenWidth*0.035),),
                //    SizedBox(height: screenHeight*0.02,),
                    GestureDetector(
                              onTap: () async {
                                var connectivityResult = await (Connectivity().checkConnectivity());
                                if (connectivityResult == ConnectivityResult.none) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    backgroundColor: Color.fromARGB(255, 33, 4, 2),
                                    content: const Text('Something went wrong! May be No internet connection',style: TextStyle(color: Colors.white),),
                                    action: SnackBarAction(
                                      label: 'Close',
                                      onPressed: () {},
                                    ),
                                  ),
                                );
                                }else{
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
                                }
                              },
                              child: Center(
                                child: Image.asset("assets/G.png",width: screenWidth*0.12,height: screenHeight*0.12,),
                              ),
                            ),
                        //    SizedBox(height: ScreenHeight*0.02,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text("Do not have an account",style: GoogleFonts.roboto(color: const Color.fromARGB(255, 0, 0, 0), fontSize: screenWidth*0.035),),
                                SizedBox(width: screenWidth*0.02,),
                                TextButton(
                                  onPressed: () {
                                    widget.toggle();
                                  },
                                  child: Text("LOGIN",style: GoogleFonts.roboto(color: const Color.fromARGB(255, 0, 0, 0), fontSize: screenWidth*0.036)),
                                )
                              ],
                            ),
                          //  SizedBox(height: ScreenHeight*0.02,),
                            ElevatedButton.icon(
                              onPressed: () async {
                                var connectivityResult = await (Connectivity().checkConnectivity());
                                if (connectivityResult == ConnectivityResult.none) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    backgroundColor: Color.fromARGB(255, 33, 4, 2),
                                    content: const Text('Something went wrong! May be No internet connection',style: TextStyle(color: Colors.white),),
                                    action: SnackBarAction(
                                      label: 'Close',
                                      onPressed: () {},
                                    ),
                                  ),
                                );
                                }else{
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
                                }
                            },
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0),),
                                backgroundColor: Theme.of(context).primaryColor,
                                padding:EdgeInsets.only(left: screenWidth*0.02, right: screenWidth*0.02),
                                minimumSize: Size(screenWidth*0.8, screenHeight*0.05),
                              ),
                              icon: isRegisterChecking ? Container(
                                      width: screenHeight*0.03,
                                      height: screenHeight*0.03,
                                      padding: const EdgeInsets.all(2.0),
                                      child: const CircularProgressIndicator(
                                        color: Colors.white,
                                        strokeWidth: 3,
                                      ),
                                    )
                                  : Icon(Icons.co_present_outlined,size: screenWidth*0.045),
                              label: Text('REGISTER',style: GoogleFonts.roboto(color: const Color.fromARGB(255, 255, 255, 255), fontSize: screenWidth*0.035,fontWeight: FontWeight.w500)),
                            ),
                ],
              ),
            ),
          ),
      ),
    );
  }
}
