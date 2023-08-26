import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stress_ducer/Login/constant/colors.dart';
import 'package:stress_ducer/Login/model/UserModel.dart';
import 'package:stress_ducer/Login/model/student.dart';
import 'package:stress_ducer/Login/screens/Home/HomeTabBar/Home.dart';
import 'package:stress_ducer/Login/screens/Home/HomeTabBar/TodayTasks.dart';
import 'package:stress_ducer/Login/services/auth.dart';
import 'package:stress_ducer/Login/services/studentDataBase.dart';

class MainPlace extends StatelessWidget {
  const MainPlace({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthServices _auth = AuthServices();
    final dataAuthServices _authData = dataAuthServices();

    return Scaffold(
      body: DefaultTabController(
        initialIndex: 0,
        length: 5,
        child: Scaffold(
          appBar: AppBar(
            title: const Text(
              'StressDucer',
              style: TextStyle(color: appBarTextColor),
            ),
            backgroundColor: mainAppBarColor,
            bottom: const TabBar(
              unselectedLabelColor:
                  unselectedLabelColor, // Change the unselected icon color
              labelColor: indicatorColor,
              indicatorColor: indicatorColor,
              tabs: <Widget>[
                Tab(
                  icon: Icon(Icons.home_filled),
                ),
                Tab(
                  icon: Icon(Icons.today),
                ),
                Tab(
                  icon: Icon(Icons.gamepad),
                ),
                Tab(
                  icon: Icon(Icons.calendar_month),
                ),
                Tab(
                  icon: Icon(Icons.person),
                ),
              ],
            ),
          ),
          body: const TabBarView(
            children: <Widget>[
              SingleChildScrollView(
                child: Home(),
              ),
              Center(
                child: TodayTasks(),
              ),
              Center(
                child: Text("It's sunny here"),
              ),
              Center(
                child: Text("It's sunny here"),
              ),
              Center(
                child: Text("It's sunny here"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
