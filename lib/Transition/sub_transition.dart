import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TextTransitionSubNew extends StatefulWidget{
  const TextTransitionSubNew({super.key});

  @override
  State<TextTransitionSubNew> createState() =>
      RotationTransitionExampleState();
}

class RotationTransitionExampleState extends State<TextTransitionSubNew> {
  @override
  void initState() {
    super.initState();// Start the animation when the widget initializes
  }

  @override
  Widget build(BuildContext context) {
    return Text('Loading...',style: GoogleFonts.openSans(fontSize: 12),);
  }
}
