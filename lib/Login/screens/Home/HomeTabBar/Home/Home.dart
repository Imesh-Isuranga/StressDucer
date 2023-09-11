import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:stress_ducer/Login/screens/Home/HomeTabBar/Home/AddTasks/addedTasksCard.dart';
import 'package:stress_ducer/Login/screens/Home/HomeTabBar/Home/Motivational_Quotes/HomeDisplayQuotes.dart';
import 'package:stress_ducer/Login/screens/Home/HomeTabBar/Home/Motivational_Quotes/motivational_api.dart';

class Home extends StatefulWidget {
  const Home(this.changeTabtoGame, {super.key});

  final Function(int) changeTabtoGame;

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  static String imageUrl = '';
  static String imageUrlTodayTasks = 'assets/todo.jpg';
  static String imageUrlPlayGames = 'assets/games.jpg';

  Future<void> _initImageUrl() async {
    try {
      String uid = _auth.currentUser!.uid;
      Reference storageRef =
          FirebaseStorage.instance.ref().child('cover_images/$uid/profile.jpg');

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
    final api = MotivationalApi();

    ListTileTitleAlignment? titleAlignment;

    return Center(
      child: Column(
        children: [
          Stack(children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                child: imageUrl.isEmpty
                    ? Image.asset(
                        "assets/cover_img.jpg",
                        width: double.infinity,
                        height: 250,
                        fit: BoxFit.cover,
                      )
                    : Image.network(
                        imageUrl,
                        width: double.infinity,
                        height: 250,
                        fit: BoxFit.cover,
                      ),
              ),
            ),
            const QuoteDisplay(),
          ]),
          const SizedBox(
            height: 1,
          ),
          AddedTasksCards(),
          Container(
            decoration: BoxDecoration(
    border: Border(
      top: BorderSide(width: 0.3, color: Theme.of(context).indicatorColor), // Top border width and color
    ),
  ),
            margin: const EdgeInsets.only(top: 3, bottom: 3, left: 0, right: 0),
            child: Card(
              margin: const EdgeInsets.all(0),
              child: InkWell(
                onTap: () {
                  widget.changeTabtoGame(1);
                  ;
                },
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    children: <Widget>[
                      Row(
                        children: [
                          Expanded(
                            child: ListTile(
                              title: Text("Today Tasks"),
                              leading: Icon(Icons.task),
                  iconColor: Theme.of(context).iconTheme.color,
                              subtitle: Text(
                                  "Plan your day with achievable goals. Break tasks into manageable steps to stay organized and reduce stress."),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Image.asset(
                              imageUrlTodayTasks,
                              width: 200,
                              height: 200,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
    border: Border(
      top: BorderSide(width: 0.3, color: Theme.of(context).indicatorColor), // Top border width and color
    ),
  ),
            child: Card(
              margin: const EdgeInsets.only(top: 0, bottom: 3, left: 0, right: 0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  ListTile(
                    leading: Icon(Icons.polymer_sharp),
                    iconColor: Theme.of(context).iconTheme.color,
                    title: Text(
                      'Play Games',
                      style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
                    ),
                    subtitle: Text("Relaxation Recess"),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Image.asset(
                        imageUrlPlayGames,
                        width: 150,
                        height: 150,
                      ),
                      Expanded(
                        child: Column(
                          children: <Widget>[
                            const Divider(),
                            ListTile(
                              titleAlignment: titleAlignment,
                              title: const Text('Mindful Playgrounds'),
                              subtitle: const Text(
                                  'Engage in games designed for relaxation. Immerse yourself in soothing gameplay to unwind and de-stress.'),
                            ),
                            const Divider(),
                            TextButton(
                                onPressed: () {
                                  widget.changeTabtoGame(2);
                                },
                                child: const Text("Play"))
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
