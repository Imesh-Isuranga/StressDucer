import 'package:flutter/material.dart';
import 'package:stress_ducer/Login/constant/colors.dart';
import 'package:stress_ducer/Login/screens/Home/HomeTabBar/Calender.dart';
import 'package:stress_ducer/Login/screens/Home/HomeTabBar/Games.dart';
import 'package:stress_ducer/Login/screens/Home/HomeTabBar/Home/Home.dart';
import 'package:stress_ducer/Login/screens/Home/HomeTabBar/Profile/Profile.dart';
import 'package:stress_ducer/Login/screens/Home/HomeTabBar/TodayTasks/TodayTasks.dart';
import 'package:stress_ducer/Login/screens/Home/PopUpMenu/pop_upMenu.dart';

class MainPlace extends StatefulWidget {
  const MainPlace({Key? key}) : super(key: key);

  @override
  _MainPlaceState createState() => _MainPlaceState();
}

class _MainPlaceState extends State<MainPlace>
    with SingleTickerProviderStateMixin {
  final Map<int, double> tabHeights = {
    0: 100, // Home
    1: 60, // TodayTasks (customize the height as needed)
    2: 60, // Games
    3: 60, // Calendar
    4: 60, // Profile
  };

  final List<String> appTitles = ["StressDucer", "", "", "", ""];

  late TabController _tabController;
  double height = 100;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this);

    // Listen for tab changes
    _tabController.addListener(() {
      setState(() {
        // Update the height based on the selected tab
        height = tabHeights[_tabController.index] ?? 50;
      });
    });
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
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(height),
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                  //   bottomLeft: Radius.circular(20.0), // Adjust the bottom-left radius
                  //    bottomRight: Radius.circular(20.0), // Adjust the bottom-right radius
                  ),
              child: AppBar(
                flexibleSpace: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Color.fromARGB(255, 255, 255, 255),
                        Color.fromARGB(255, 255, 255, 255)
                      ], // Replace with your gradient colors
                    ),
                  ),
                ),
                title: Row(
                  children: [
                    Text(
                      appTitles[_tabController.index],
                      style: TextStyle(color: appBarTextColor),
                    ),
                    if (_tabController.index == 0)
                      Image.asset(
                        "assets/G.png",
                        width: 50,
                        height: 50,
                      ),
                  ],
                ),
                bottom: TabBar(
                  controller: _tabController,
                  labelColor: Colors.blue,
                  indicatorColor: Colors.blue,
                  unselectedLabelColor: Colors.black,
                  tabs: const <Widget>[
                    Tab(
                      icon: Icon(Icons.home_filled),
                    ),
                    Tab(icon: Icon(Icons.today)),
                    Tab(icon: Icon(Icons.gamepad)),
                    Tab(icon: Icon(Icons.calendar_month)),
                    Tab(icon: Icon(Icons.person)),
                  ],
                ),
              ),
            ),
          ),
          body: TabBarView(
            controller: _tabController,
            children: <Widget>[
              SingleChildScrollView(child: Home(_changeTabIndex)),
              const Center(child: TodayTasks()),
              const Center(child: Games()),
              const Center(child: Calender()),
              Center(child: Profile()),
            ],
          ),endDrawer: Drawer(child: Container(child: Column(children: [PopUpScreen()]),)),
        ),
      ),
    );
  }
}
