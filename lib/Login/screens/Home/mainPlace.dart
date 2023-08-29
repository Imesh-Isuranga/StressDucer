import 'package:flutter/material.dart';
import 'package:stress_ducer/Login/constant/colors.dart';
import 'package:stress_ducer/Login/screens/Home/HomeTabBar/Calender.dart';
import 'package:stress_ducer/Login/screens/Home/HomeTabBar/Games.dart';
import 'package:stress_ducer/Login/screens/Home/HomeTabBar/Home.dart';
import 'package:stress_ducer/Login/screens/Home/HomeTabBar/Profile/Profile.dart';
import 'package:stress_ducer/Login/screens/Home/HomeTabBar/TodayTasks.dart';

class MainPlace extends StatefulWidget {
  const MainPlace({Key? key}) : super(key: key);


  @override
  _MainPlaceState createState() => _MainPlaceState();
}

class _MainPlaceState extends State<MainPlace> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this);
  }

  void _changeTabIndex(int index) {
    _tabController.animateTo(index);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
        initialIndex: 0,
        length: 5,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: mainAppBarColor,
            title: const Text('StressDucer',style: TextStyle(color: appBarTextColor),),
            bottom: TabBar(
              controller: _tabController,
              labelColor: Colors.blue,
              indicatorColor: Colors.blue,
              unselectedLabelColor: Colors.black,
              tabs: const <Widget>[
                Tab(icon: Icon(Icons.home_filled),),
                Tab(icon: Icon(Icons.today)),
                Tab(icon: Icon(Icons.gamepad)),
                Tab(icon: Icon(Icons.calendar_month)),
                Tab(icon: Icon(Icons.person)),
              ],
            ),
          ),
          body: TabBarView(
            controller: _tabController,
            children: <Widget>[
              SingleChildScrollView(child: Home(_changeTabIndex)),
              Center(child: TodayTasks()),
              const Center(child: Games()),
              const Center(child: Calender()),
               Center(child: Profile()),
            ],
          ),
        ),
      ),
    );
  }
}
