import 'package:flutter/material.dart';

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
    primaryColor: const Color.fromARGB(255, 65, 122, 255),
    primaryColorDark:Colors.white,
    colorScheme: const ColorScheme.dark(),
    iconTheme: const IconThemeData(color: Color.fromARGB(255, 65, 122, 255),),
    indicatorColor : Colors.white,
    cardColor: Colors.black
  );

  static final lightTheme = ThemeData(
    scaffoldBackgroundColor: Colors.white,
    primaryColor:const Color.fromARGB(255, 65, 122, 255),
    primaryColorDark:const Color.fromARGB(255, 0, 0, 0),
    colorScheme: const ColorScheme.light(),
    iconTheme: const IconThemeData(color: Color.fromARGB(255, 65, 122, 255),),
    indicatorColor : Colors.black,
    cardColor: Colors.white
  );
}