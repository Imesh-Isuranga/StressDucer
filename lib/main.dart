import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stress_ducer/Login/model/UserModel.dart';
import 'package:stress_ducer/Login/model/studentFirstModel.dart';
import 'package:stress_ducer/Login/screens/studentDetails/StudentDetailsSecond.dart';
import 'package:stress_ducer/Login/screens/studentDetails/studentDetails.dart';
import 'package:stress_ducer/Login/services/auth.dart';
import 'package:stress_ducer/Login/wrapper.dart';

Future main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  void switchState(StudentFirstModel studentFirstModel){
  }

  @override
  Widget build(BuildContext context) {
    return StreamProvider<UserModel?>.value(
      value: AuthServices().user,
      initialData: UserModel(uid: ""),
      child: MaterialApp(
        home: Wrapper(),
      ),
    );
  }
}