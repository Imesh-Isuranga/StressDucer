import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stress_ducer/Login/screens/Home/PopUpMenu/Test/questions.dart';

class Test extends StatefulWidget {
  const Test({super.key, required this.changeScreen});

  final void Function(int) changeScreen;
  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {
  static List<String> questions = [];
  int i = 0;
  int answers = 0;

  @override
  void initState() {
    questions = Questions().getData(); // Call getData on questionsClass
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Padding(
          padding: const EdgeInsets.all(50.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                questions[i],
                textAlign: TextAlign.center,
                style:GoogleFonts.roboto(fontSize: 20, fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  OutlinedButton(
                      style: ButtonStyle(
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                20.0), // Adjust the radius here
                          ),
                        ),
                      backgroundColor: const MaterialStatePropertyAll(Color.fromARGB(255, 3, 42, 171))),
                      onPressed: () {
                        setState(() {
                          if ((questions.length - 1) > i) {
                            i++;
                            answers++;
                          } else {
                            answers++;
                            widget.changeScreen(answers);
                          }
                        });
                      },
                      child: Text("Yes",style:GoogleFonts.roboto(fontSize: 16, fontWeight: FontWeight.w500,color: Colors.white))),
                  const SizedBox(
                    width: 20,
                  ),
                  OutlinedButton(
                      style: ButtonStyle(
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                20.0), // Adjust the radius here
                          ),
                        ),backgroundColor: const MaterialStatePropertyAll(Color.fromARGB(255, 3, 42, 171))
                      ),
                      onPressed: () {
                        setState(() {
                          if ((questions.length - 1) > i) {
                            i++;
                          } else {
                            widget.changeScreen(answers);
                          }
                        });
                      },
                      child: Text("No",style:GoogleFonts.roboto(fontSize: 16, fontWeight: FontWeight.w500,color: Colors.white))),
                ],
              ),
              const SizedBox(height: 40,),
                      Text(
                '${(i+1).toString()})',
                textAlign: TextAlign.center,
                style:GoogleFonts.roboto(fontSize: 13, fontWeight: FontWeight.w500,color: const Color.fromARGB(255, 98, 98, 98)),
              )
            ],
          ),
        ),
      );
  }
}
