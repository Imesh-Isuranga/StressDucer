import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:stress_ducer/mainPlace.dart';
import 'package:stress_ducer/student/studentDetails.dart';
import 'package:stress_ducer/studentWrapper.dart';
import 'package:stress_ducer/temp.dart';

Future main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const StudentWrapper());
}