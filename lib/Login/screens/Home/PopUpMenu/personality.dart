import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:stress_ducer/Login/Transition/sub_transition.dart';
import 'package:stress_ducer/Login/model/UserModel.dart';
import 'package:stress_ducer/Login/model/student.dart';
import 'package:stress_ducer/Login/services/studentDataBase.dart';
import 'dart:io';
import 'package:stress_ducer/Login/screens/error.dart';

class Personality extends StatefulWidget {
  const Personality({super.key});

  @override
  State<Personality> createState() => _PersonalityState();
}

class _PersonalityState extends State<Personality> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final _authDataBase = dataAuthServices();

  late TextEditingController nameTxt;
  late TextEditingController uniTxt;
  User? user = FirebaseAuth.instance.currentUser;
  String imageUrl = 'assets/man.png';
  String imageUrlCover = 'assets/man.png';

  bool setEditName = false;
  bool setEditUni = false;
  bool setEditSave = false;

  @override
  void initState() {
    setState(() {
      imageUrl = user!.photoURL==null ? "" : user!.photoURL.toString();
    });
    nameTxt = TextEditingController();
    uniTxt = TextEditingController();
    super.initState();
  //  _initImageUrl(); // Call a separate method to initialize imageUrl.
  }

  // Method to initialize imageUrl asynchronously.
  Future<void> _initImageUrl() async {
    try {
      String uid = FirebaseAuth.instance.currentUser!.uid;
      Reference storageRef =
          FirebaseStorage.instance.ref().child('user_images/$uid/profile.jpg');
      Reference storageRefCover =
          FirebaseStorage.instance.ref().child('cover_images/$uid/profile.jpg');

      // Get the download URL of the image
      String imageUrlnew = await storageRef.getDownloadURL();
      String imageUrlnewCover = await storageRefCover.getDownloadURL();

      if (mounted == true) {
        setState(() {
          imageUrl = imageUrlnew;
          imageUrlCover = imageUrlnewCover;
        });
      }
    } catch (error) {
      // Handle any potential errors, e.g., display a default image or an error message.
      print('Error loading image: $error');
    }
  }

  void saveProfileImage(String id) async {
    final image = await ImagePicker().pickImage(
        source: ImageSource.gallery,
        maxHeight: 500,
        maxWidth: 500,
        imageQuality: 75);

    Reference ref =
        FirebaseStorage.instance.ref().child("user_images/$id/profile.jpg");

    await ref.putFile(File(image!.path));
    ref.getDownloadURL().then((value) {
      setState(() {
        imageUrl = value;
      });
    });
  }

  void saveCoverProfileImage(String id) async {
    final image = await ImagePicker().pickImage(
        source: ImageSource.gallery,
        maxHeight: 500,
        maxWidth: 500,
        imageQuality: 75);

    Reference refCover =
        FirebaseStorage.instance.ref().child("cover_images/$id/profile.jpg");

    await refCover.putFile(File(image!.path));
    refCover.getDownloadURL().then((value) {
      setState(() {
        imageUrlCover = value;
      });
    });

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Error().msg(context, "Saved");
      },
    );
  }

  @override
  Widget build(BuildContext context1) {
    String id = Provider.of<UserModel?>(context)!.uid;
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.black),
          backgroundColor: Colors.white,
          title: const Text(
            "Personality",
            style: TextStyle(color: Colors.black),
          ),
        ),
        body: StreamBuilder<Student?>(
          stream: dataAuthServices.readSpecificDocument(id),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const TextTransitionSubNew();
            } else if (snapshot.hasError) {
              return Text("Error: ${snapshot.error}");
            } else if (snapshot.hasData) {
              final student = snapshot.data;
              if (student != null) {
                nameTxt.text = student.studentName ?? '';
                uniTxt.text = student.studentUniName ?? '';

                return SingleChildScrollView(
                  child: Container(
                      child: Column(
                    children: [
                      Card(
                          margin: EdgeInsets.all(0),
                          child: Padding(
                            padding: const EdgeInsets.all(30.0),
                            child: Column(
                              children: [
                                Text("Profile Photo",style: GoogleFonts.roboto(fontSize: 18),),
                                const SizedBox(
                                  height: 20,
                                ),
                                Container(
                                  margin: EdgeInsets.only(bottom: 10),
                                  height: 100,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: imageUrl.isNotEmpty
                                        ? DecorationImage(
                                            image: NetworkImage(imageUrl),
                                          )
                                        : DecorationImage(
                                            image: AssetImage("assets/man.png"),
                                          ), // Handle the case where imageUrl is empty or invalid
                                  ),
                                ),

                                const SizedBox(
                                  height: 20,
                                ),
                                //   Image.network(imageUrl,scale: 1.0,),
                                TextButton(
                                  onPressed: () {
                                    saveProfileImage(id);
                                    _initImageUrl();
                                  },
                                  child: const Text("Edit"),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: TextField(
                                        enabled: setEditName,
                                        controller: nameTxt,
                                        decoration: const InputDecoration(
                                          labelText: 'Name',
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 40,
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        setState(() {
                                          setEditName = true;
                                          setEditSave = true;
                                        });
                                      },
                                      child: const Text("Edit"),
                                    )
                                  ],
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: TextField(
                                        enabled: setEditUni,
                                        controller: uniTxt,
                                        decoration: const InputDecoration(
                                          labelText: 'University',
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 40,
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        setState(() {
                                          setEditUni = true;
                                          setEditSave = true;
                                        });
                                      },
                                      child: const Text("Edit"),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
                                  onPressed: setEditSave
                                      ? () {
                                          try {
                                            _authDataBase.updateWithName(
                                              id,
                                              nameTxt.text,
                                              uniTxt.text,
                                            );

                                            showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return Error()
                                                    .msg(context, "Saved");
                                              },
                                            );
                                          } catch (e) {
                                            showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return Error().errorMsg(context,
                                                    "Something went wrong!");
                                              },
                                            );
                                          }
                                        }
                                      : null,
                                  child: Text("Save"),
                                )
                              ],
                            ),
                          )),
                      const SizedBox(height: 3),
                      Card(
                        margin: EdgeInsets.all(0),
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: Padding(
                            padding: const EdgeInsets.all(30.0),
                            child: Column(
                              children: [
                                Text("Cover Photo",style: GoogleFonts.roboto(fontSize: 18),),
                                const SizedBox(
                                  height: 20,
                                ),
                                imageUrl.isEmpty
                                    ? Image.asset("assets/cover_img.jpg")
                                    : Image.network(imageUrlCover),
                                const SizedBox(height: 20),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
                                  onPressed: () {
                                    try {
                                      saveCoverProfileImage(id);
                                    } catch (e) {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return Error().errorMsg(
                                              context, "Something went wrong!");
                                        },
                                      );
                                    }
                                  },
                                  child: Text("Save"),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),
                    ],
                  )),
                );
              } else {
                return const Text("Student not found");
              }
            } else {
              return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "You are loged as a guest",
                    style: GoogleFonts.roboto(
                        fontSize: 15, fontWeight: FontWeight.w400),
                  ),
                  Image.asset(
                    "assets/guest.jpg",
                    width: MediaQuery.of(context).size.width * 0.7,
                    height: MediaQuery.of(context).size.width,
                  ),
                  OutlinedButton(
                    onPressed: () {
                      Navigator.pop(context1);
                    },
                    child: Text(
                      "Back to Login",
                      style: TextStyle(color: Colors.black),
                    ),
                    style: OutlinedButton.styleFrom(
                        side: BorderSide(color: Colors.black)),
                  )
                ],
              ),
            );
            }
          },
        ),
      ),
    );
  }
}
