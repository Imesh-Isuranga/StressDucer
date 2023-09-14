import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:stress_ducer/Login/screens/Home/HomeTabBar/Game/gameCard.dart';
import 'package:stress_ducer/Login/screens/Home/HomeTabBar/Home/AddTasks/addedTasksCard.dart';
import 'package:stress_ducer/Login/screens/Home/HomeTabBar/TodayTasks/TodayTaskCard.dart';
import 'package:stress_ducer/Login/screens/Home/HomeTabBar/Home/Motivational_Quotes/HomeDisplayQuotes.dart';
import 'package:stress_ducer/Login/screens/Home/HomeTabBar/Home/Motivational_Quotes/motivational_api.dart';

class Home extends StatefulWidget {
  const Home(this.changeTab, {super.key});

  final Function(int) changeTab;

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  static String imageUrl = '';


  Future<void> _initImageUrl() async {
    try {
      String uid = _auth.currentUser!.uid;
      Reference storageRef = FirebaseStorage.instance.ref().child('cover_images/$uid/profile.jpg');

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

  @override
  void initState() {
    _initImageUrl();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final api = MotivationalApi();

    return Center(
      child: Column(
        children: [
          Stack(
            children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                child: imageUrl.isEmpty ? Image.asset("assets/cover_img.jpg", width: double.infinity, height: screenHeight*0.3,fit: BoxFit.cover,)
                    : Image.network(imageUrl, width: double.infinity,height: screenHeight*0.3,fit: BoxFit.cover,),
              ),
            ),
            const QuoteDisplay(),
          ]),
          SizedBox(height: screenWidth*0.01,),
          AddedTasksCards(),
          SizedBox(height: screenWidth*0.01,),
          TodayTaskCard(changeTab: widget.changeTab,),
          SizedBox(height: screenWidth*0.01,),
          GameCard(changeTab: widget.changeTab)
        ],
      ),
    );
  }
}
