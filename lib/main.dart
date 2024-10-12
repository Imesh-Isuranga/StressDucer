import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:stress_ducer/Theme/myTheme.dart';
import 'package:stress_ducer/model/UserModel.dart';
import 'package:stress_ducer/Home/HomeTabBar/Home/AddTasks/Notification/notification_service.dart';
import 'package:stress_ducer/services/auth.dart';
import 'package:stress_ducer/wrapper.dart';



Future main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await NotificationService.initializeNotification();

  //https://stackoverflow.com/questions/71382151/flutter-not-rendering-ui-in-real-device-on-release-apk
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await Future.delayed(const Duration(milliseconds: 150));
  runApp(const MyApp());
}



class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();



  @override
  Widget build(BuildContext context)=>ChangeNotifierProvider(create: (context)=>ThemeProvider(),builder: (context,_){
final themeProvider = Provider.of<ThemeProvider>(context);
    return StreamProvider<UserModel?>.value(
      value: AuthServices().user,
      initialData: UserModel(uid: ""),
      child: MaterialApp(
        themeMode: themeProvider.themeMode,
            theme: MyThemes.lightTheme,
            darkTheme: MyThemes.darkTheme,
        title: "StressDucer",
        home: const Wrapper(),
      ),
    );
    
  },);
}


