/*import 'package:flutter/material.dart';
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
    duration: const Duration(seconds: 3),
    vsync: this,
  )..repeat();
  late final Animation<double> _animation = CurvedAnimation(
    parent: _controller,
    curve: Curves.fastOutSlowIn,
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
            child: Image.asset("assets/logo.png",scale: 5,),
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
              child: const Text('Take It Easy',style: TextStyle(fontWeight: FontWeight.w600),) ,
            ),
          ),
        ],
      ),
    );
  }
}

*/


import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';

class TextTransitionNew extends StatelessWidget {
  const TextTransitionNew({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SpinKitThreeBounce(
              itemBuilder: (context, index) {
                final colors = [Color.fromARGB(255, 0, 103, 36),Color.fromARGB(255, 17, 200, 0),Color.fromARGB(255, 0, 215, 107)];
                final color = colors[index%colors.length];
                return DecoratedBox(decoration: BoxDecoration(color: color,shape: BoxShape.circle),);
              },
              size: MediaQuery.of(context).size.width*0.07,
            ),
            const SizedBox(height: 50,),
          Center(
            child: AnimatedDefaultTextStyle(
              duration: const Duration(milliseconds: 300),
              style: GoogleFonts.arimo(
                      color: const Color.fromARGB(255, 94, 213, 98),
                      fontSize: MediaQuery.of(context).size.width*0.07,
                      fontWeight: FontWeight.w400
                    ),
              curve: Curves.easeInCubic,
              child: const Text('Take It Easy',style: TextStyle(fontWeight: FontWeight.w600),) ,
            ),
          ),
          ],
        ),
      ),
    );
  }
}
