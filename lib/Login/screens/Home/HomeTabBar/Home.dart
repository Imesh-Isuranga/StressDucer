import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stress_ducer/Login/model/UserModel.dart';
import 'package:stress_ducer/Login/model/student.dart';
import 'package:stress_ducer/Login/services/auth.dart';
import 'package:stress_ducer/Login/services/studentDataBase.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {

    
    final AuthServices _auth = AuthServices();
    final dataAuthServices _authData = dataAuthServices();

    return Center(
                  child: Column(children: [
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
                              leading:const Icon(Icons.waving_hand_rounded),
                              title: const Text('Welcome'),
                              subtitle: StreamBuilder<Student?>(
                                stream: dataAuthServices.readSpecificDocument(
                                    Provider.of<UserModel?>(context)!.uid),
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
                                  onPressed: () {/* ... */},
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
                  ]),
                );
  }
}