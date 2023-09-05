import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:stress_ducer/Login/Transition/sub_transition.dart';
import 'package:stress_ducer/Login/model/UserModel.dart';
import 'package:stress_ducer/Login/model/student.dart';
import 'package:stress_ducer/Login/services/studentDataBase.dart';
import 'dart:io';

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
  String imageUrl = '';
  String imageUrlCover = '';

  bool setEditName = false;
  bool setEditUni = false;
  bool setEditSave = false;

  @override
  void initState() {
    nameTxt = TextEditingController();
    uniTxt = TextEditingController();
    super.initState();
    _initImageUrl(); // Call a separate method to initialize imageUrl.
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
  }

  @override
  Widget build(BuildContext context) {
    String id = Provider.of<UserModel?>(context)!.uid;
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Personality"),
        ),
        body: StreamBuilder<Student?>(
          stream: dataAuthServices.readSpecificDocument(id),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return TextTransitionSubNew();
            } else if (snapshot.hasError) {
              return Text("Error: ${snapshot.error}");
            } else if (snapshot.hasData) {
              final student = snapshot.data;
              if (student != null) {
                nameTxt.text = student.studentName ?? '';
                uniTxt.text = student.studentUniName ?? '';

                return Padding(
                  padding: const EdgeInsets.all(20),
                  child: SingleChildScrollView(
                    child: Container(
                        child: Column(
                      children: [
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
                          onPressed: setEditSave
                              ? () {
                                  _authDataBase.updateWithName(
                                    id,
                                    nameTxt.text,
                                    uniTxt.text,
                                  );
                                }
                              : null,
                          child: Text("Save"),
                        ),

                        imageUrl.isEmpty
                            ? Image.asset("assets/cover_img.jpg")
                            : Image.network(imageUrlCover),

                        ElevatedButton(
                          onPressed: () {
                            saveCoverProfileImage(id);
                          },
                          child: Text("Save"),
                        ),
                      ],
                    )),
                  ),
                );
              } else {
                return const Text("Student not found");
              }
            } else {
              return const Text("No data available");
            }
          },
        ),
      ),
    );
  }
}
