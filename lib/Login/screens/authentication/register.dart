import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:stress_ducer/Login/constant/colors.dart';
import 'package:stress_ducer/Login/constant/styles.dart';
import 'package:stress_ducer/Login/services/auth.dart';

class Register extends StatefulWidget {
  const Register({super.key, required this.toggle, required this.isPressed});

  final Function toggle;
  final void Function() isPressed;

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Register",style: TextStyle(color: appBarTextColor),),
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
                          onTap: () {},
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
                          onPressed: ()async {
                            widget.isPressed();
                            dynamic result = await _auth
                                .registerWithEmailAndPassword(email, password);
                            if (result == null) {
                              setState(() {
                                error = "Please enter a valid email!";
                              });
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: loginButtonColors,
                            padding: const EdgeInsets.only(left: 15, right: 15),
                            minimumSize: Size(300,40),
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