import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TextTransitionNew extends StatefulWidget{
  const TextTransitionNew({super.key});

  @override
  State<TextTransitionNew> createState() =>
      RotationTransitionExampleState();
}

class RotationTransitionExampleState extends State<TextTransitionNew> {
  bool animate = false; // Define the animate variable and set its initial value

  void startAnimation() {
    Future.delayed(const Duration(milliseconds: 150), () {
      setState(() {
        animate = !animate; // Toggle the value of animate after the delay
      });
    });
  }

  @override
  void initState() {
    super.initState();
    startAnimation(); // Start the animation when the widget initializes
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: AnimatedDefaultTextStyle(
          duration: const Duration(milliseconds: 300),
          style: animate
              ? GoogleFonts.arimo(
                  color: Colors.blue,
                  fontSize: 26,
                )
              : GoogleFonts.mulish(
                  color: Color.fromARGB(255, 233, 1, 1),
                  fontSize: 14,
                ),
          curve: Curves.easeInCubic,
          child: Text('Task It Easy'),
        ),
      ),
    );
  }
}
