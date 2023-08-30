import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stress_ducer/Login/model/UserModel.dart';
import 'package:stress_ducer/Login/model/student.dart';
import 'package:stress_ducer/Login/screens/Home/HomeTabBar/Home/AddTasks.dart';
import 'package:stress_ducer/Login/screens/Home/HomeTabBar/Games.dart';
import 'package:stress_ducer/Login/screens/Home/HomeTabBar/TodayTasks.dart';
import 'package:stress_ducer/Login/services/auth.dart';
import 'package:stress_ducer/Login/services/studentDataBase.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home(this.changeTabtoGame, {super.key});

  final Function(int) changeTabtoGame;

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    String id = Provider.of<UserModel?>(context)!.uid;
    final AuthServices _auth = AuthServices();
    final dataAuthServices _authData = dataAuthServices();

    ListTileTitleAlignment? titleAlignment;

    return Center(
      child: Column(
        children: [
          Image.asset(
            "assets/cover_img.jpg",
            width: double.infinity,
            height: 300,
            fit: BoxFit.cover,
          ),

          const SizedBox(
            height: 4,
          ),

          Container(
            margin: const EdgeInsets.all(10),
            child: Card(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  ListTile(
                    leading: const Icon(Icons.waving_hand_rounded),
                    title: const Text('Welcome',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w400)),
                    subtitle: StreamBuilder<Student?>(
                      stream: dataAuthServices.readSpecificDocument(id),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const CircularProgressIndicator();
                        } else if (snapshot.hasError) {
                          return Text("Error: ${snapshot.error}");
                        } else if (snapshot.hasData) {
                          final student = snapshot.data;
                          if (student != null) {
                            return Text(student
                                .studentName!); // Return your actual widget
                          } else {
                            return const Text("Student not found");
                          }
                        } else {
                          return const Text("No data available");
                        }
                      },
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      TextButton(
                        child: const Text('Login'),
                        onPressed: () {},
                      ),
                      const SizedBox(width: 8),
                      TextButton(
                        child: const Text('Sign Up'),
                        onPressed: () {
                          _auth.signOut();
                        },
                      ),
                      const SizedBox(width: 8),
                    ],
                  ),
                ],
              ),
            ),
          ),

          Container(
            margin: const EdgeInsets.all(10),
            child: Card(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  const ListTile(
                    leading: Icon(Icons.waving_hand_rounded),
                    title: Text('Add Task',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w400)),
                    subtitle: Text("Add Task")
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      TextButton(
                        child: const Text('Login'),
                        onPressed: () {},
                      ),
                      const SizedBox(width: 8),
                      TextButton(
                        child: const Text('Sign Up'),
                        onPressed: () {
                          AddTasks().modelBottomPanelSettings(context);
                        },
                      ),
                      const SizedBox(width: 8),
                    ],
                  ),
                ],
              ),
            ),
          ),

          Container(
            margin: const EdgeInsets.all(8),
            child: Card(
              child: Column(
                children: <Widget>[
                  const ListTile(
                    leading: Icon(Icons.schedule),
                    title: Text('Today Tasks',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w400)),
                    subtitle: Text("Study Schedule"),
                  ),
                  Row(
                    children: [
                      const Expanded(
                          child: ListTile(
                        title: Text("Daily Goals"),
                        subtitle: Text("Plan your day with achievable goals. Break tasks into manageable steps to stay organized and reduce stress."),
                      )),
                      Image.asset(
                        "assets/cover_img.jpg",
                        width: 150,
                        height: 150,
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),

          Container(
            margin: const EdgeInsets.all(10),
            child: Card(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  const ListTile(
                    leading: Icon(Icons.polymer_sharp),
                    title: Text(
                      'Play Games',
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
                    ),
                    subtitle: Text("Relaxation Recess"),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Image.asset(
                        "assets/cover_img.jpg",
                        width: 150,
                        height: 150,
                      ),
                      Expanded(
                        child: Container(
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
                                  child: Text("Play"))
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
