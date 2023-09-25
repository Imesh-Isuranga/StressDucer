import 'package:flutter/material.dart';
import 'package:stress_ducer/Login/screens/Home/PopUpMenu/Test/test.dart';
import 'package:stress_ducer/Login/screens/Home/PopUpMenu/Test/result.dart';

class TestMain extends StatefulWidget {
  const TestMain({super.key});

  @override
  State<TestMain> createState() => _TestMainState();
}

class _TestMainState extends State<TestMain> {
  int changeWindow = 0;
  int answerCount = 0;

  void changetoResult(int answers) {
    setState(() {
      changeWindow = 1;
      answerCount = answers;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 1, 69, 3),
        title: const Text("Test",style: TextStyle(color: Colors.white),),
      ),
      body: changeWindow == 0
          ? Test(
              changeScreen: changetoResult,
            )
          : StressResult(count: answerCount),
    );
  }
}
