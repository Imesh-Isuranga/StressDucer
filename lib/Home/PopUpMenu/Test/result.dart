import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class StressResult extends StatefulWidget {
  const StressResult({super.key, required this.count});

  final int count;

  @override
  State<StressResult> createState() => _StressResultState();
}

class _StressResultState extends State<StressResult> {
  String text1 = "";
  String text2 = "";
  Color txtColor = Colors.black;

  void checkStatus() {
    if (widget.count <= 5) {
      text1 = "Mild stress";
      text2 = "Try to take it easy";
      txtColor = const Color.fromARGB(255, 1, 195, 46);
    } else if (widget.count <= 10) {
      text1 = "Moderate stress";
      text2 = "You need to make some changes and learn stress management";
      txtColor = const Color.fromARGB(255, 63, 202, 68);
    } else {
      text1 = "You may be in the danger zone";
      text2 = "Talk to a medical provider ASAP";
      txtColor = Colors.red;
    }
  }

  @override
  Widget build(BuildContext context) {
    checkStatus();
    return Center(
        child: Padding(
          padding: const EdgeInsets.all(50.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(text1,
                  style: GoogleFonts.roboto(
                      fontSize: 25,
                      color: txtColor,
                      fontWeight: FontWeight.w500),
                  textAlign: TextAlign.center),
              const SizedBox(
                height: 30,
              ),
              Text(
                text2,
                style: GoogleFonts.roboto(
                  fontSize: 19,
                  color: txtColor,
                  fontWeight: FontWeight.w400,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 40,
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text("Home"),
              )
            ],
          ),
        ),
      );
  }
}
