import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode themeMode = ThemeMode.system;


bool get isDarkMode => themeMode == ThemeMode.dark;

/*  bool get isDarkMode {
    if (themeMode == ThemeMode.system) {
      final brightness = SchedulerBinding.instance.window.platformBrightness;
      return brightness == Brightness.dark;
    } else {
      return themeMode == ThemeMode.dark;
    }
  }*/

  void toggleTheme(bool isOn) {
    themeMode = isOn ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }
}

class MyThemes {
  static final darkTheme = ThemeData(
    scaffoldBackgroundColor: Colors.black,
    primaryColor: Color.fromARGB(255, 19, 189, 53),
    primaryColorDark:Colors.white,
    colorScheme: ColorScheme.dark(),
    iconTheme: IconThemeData(color: Color.fromARGB(255, 19, 189, 53),),
    indicatorColor : Colors.white,
    cardColor: Colors.black
  );

  static final lightTheme = ThemeData(
    scaffoldBackgroundColor: Colors.white,
    primaryColor: Color.fromARGB(255, 19, 189, 53),
    primaryColorDark:Color.fromARGB(255, 0, 0, 0),
    colorScheme: ColorScheme.light(),
    iconTheme: IconThemeData(color: Color.fromARGB(255, 19, 189, 53),),
    indicatorColor : Colors.black,
    cardColor: Colors.white
  );
}