import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:stress_ducer/Login/Theme/ChangeThemeButtonWidget.dart';
import 'package:stress_ducer/Login/screens/Home/HomeTabBar/Calender/Calender.dart';
import 'package:stress_ducer/Login/screens/Home/HomeTabBar/Game/Games.dart';
import 'package:stress_ducer/Login/screens/Home/HomeTabBar/Home/Home.dart';
import 'package:stress_ducer/Login/screens/Home/HomeTabBar/Profile/Profile.dart';
import 'package:stress_ducer/Login/screens/Home/HomeTabBar/TodayTasks/TodayTasks.dart';
import 'package:stress_ducer/Login/screens/Home/PopUpMenu/pop_upMenu.dart';

class MainPlace extends StatefulWidget {
  const MainPlace({super.key});
  @override
  _MainPlaceState createState() => _MainPlaceState();
}

class _MainPlaceState extends State<MainPlace>
    with SingleTickerProviderStateMixin, WidgetsBindingObserver {
  User? user = FirebaseAuth.instance.currentUser;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  static String imageUrl = '';

  @override
  void initState() {
    _initImageUrl();
    super.initState();
    imageUrl = user!.photoURL == null ? "" : user!.photoURL.toString();
  }

  void _changeTabIndex(int index) {
    setState(() {
      currentPageIndex = index;
    });
  }

  Future<void> _initImageUrl() async {
    try {
      String uid = FirebaseAuth.instance.currentUser!.uid;
      Reference storageRef =
          FirebaseStorage.instance.ref().child('user_images/$uid/profile.jpg');

      // Get the download URL of the image
      String imageUrlnew = await storageRef.getDownloadURL();

      if (mounted == true) {
        setState(() {
          imageUrl = imageUrlnew;
        });
      }
    } catch (error) {
      // Handle any potential errors, e.g., display a default image or an error message.
      print('Error loading image: $error');
    }
  }

  int currentPageIndex = 0;
  NavigationDestinationLabelBehavior labelBehavior =
      NavigationDestinationLabelBehavior.alwaysShow;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(20.0), // Adjust the bottom-left radius
            bottomRight:
                Radius.circular(20.0), // Adjust the bottom-right radius
          ),
          child: AppBar(
            shape: Border(
              bottom: BorderSide(
                color: Theme.of(context).indicatorColor, // Set your border color here
                width: 0.3, // Set your border thickness here
              ),
            ),
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            leading: IconButton(
                onPressed: () {
                 _scaffoldKey.currentState?.openEndDrawer();
                },
                icon: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                        width: 3, color: Theme.of(context).indicatorColor),
                    shape: BoxShape.circle,
                    image: imageUrl.isNotEmpty
                        ? DecorationImage(
                            image: NetworkImage(imageUrl),
                          )
                        : const DecorationImage(
                            image: AssetImage("assets/man.png"),
                          ), // Handle the case where imageUrl is empty or invalid
                  ),
                )),
            actions: [
              ChangeThemeButtonWidget(),
            ],
            iconTheme: Theme.of(context).iconTheme,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "StressDucer",
                  style: TextStyle(color: Colors.red),
                ),
                Image.asset(
                  "assets/G.png",
                  width: 50,
                  height: 50,
                )
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(
              color: Theme.of(context)
                  .indicatorColor, // Set your border color here
              width: 0.5, // Set your border thickness here
            ),
          ),
        ),
        child: BottomNavigationBar(
          iconSize: 25,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          type:
              BottomNavigationBarType.fixed, // Ensures all icons are displayed
          showSelectedLabels: false, // Hide labels
          showUnselectedLabels: false, // Hide labels
          selectedItemColor: Theme.of(context).iconTheme.color,
          unselectedItemColor:
              Theme.of(context).indicatorColor, // Adjust the color as needed
          currentIndex: currentPageIndex,
          onTap: (int index) {
            setState(() {
              currentPageIndex = index;
            });
          },
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: '', // Set an empty string as the label
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.today_rounded),
              label: '', // Set an empty string as the label
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.border_all_rounded),
              label: '', // Set an empty string as the label
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.calendar_month_rounded),
              label: '', // Set an empty string as the label
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_2_outlined),
              label: '', // Set an empty string as the label
            ),
          ],
        ),
      ),
      body: <Widget>[
        Container(
          alignment: Alignment.center,
          child: SingleChildScrollView(child: Home(_changeTabIndex)),
        ),
        Container(
          alignment: Alignment.center,
          child: const Center(child: TodayTasks()),
        ),
        Container(
          alignment: Alignment.center,
          child: const Center(child: Games()),
        ),
        Container(
          alignment: Alignment.center,
          child: const Center(child: Calender()),
        ),
        Container(
          alignment: Alignment.center,
          child: Center(child: Profile()),
        ),
      ][currentPageIndex],
      endDrawer: const Drawer(
        child: Column(children: [PopUpScreen()]),
      ),
    );
  }
}
