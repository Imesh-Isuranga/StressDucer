import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TextTransitionNew extends StatefulWidget{
  const TextTransitionNew({super.key});

  @override
  State<TextTransitionNew> createState() =>
      RotationTransitionExampleState();
}

class RotationTransitionExampleState extends State<TextTransitionNew> with TickerProviderStateMixin {
  bool animate = false; // Define the animate variable and set its initial value
  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 2),
    vsync: this,
  )..repeat(reverse: true);
  late final Animation<double> _animation = CurvedAnimation(
    parent: _controller,
    curve: Curves.elasticOut,
  );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
        child: RotationTransition(
          turns: _animation,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset("assets/G.png",scale: 5,),
          ),
        ),
      ),
      const SizedBox(height: 50,),
          Center(
            child: AnimatedDefaultTextStyle(
              duration: const Duration(milliseconds: 300),
              style: animate
                  ? GoogleFonts.arimo(
                      color: const Color.fromARGB(255, 94, 213, 98),
                      fontSize: 26,
                      fontWeight: FontWeight.w400
                    )
                  : GoogleFonts.mulish(
                      color: const Color.fromARGB(255, 233, 1, 1),
                      fontSize: 14,
                      fontWeight: FontWeight.w400
                    ),
              curve: Curves.easeInCubic,
              child: const Text('Take It Easy') ,
            ),
          ),
        ],
      ),
    );
  }
}
