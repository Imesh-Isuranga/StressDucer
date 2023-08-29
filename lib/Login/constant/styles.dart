import 'package:flutter/material.dart';
import 'package:stress_ducer/Login/constant/colors.dart';

const TextStyle descriptionStyle = TextStyle(
  fontSize: 15,
  color:Colors.black,
  fontWeight: FontWeight.w300
);


const TextStyle studentDetailsProfile = TextStyle(
  fontSize: 20,
  color:Colors.black,
  fontWeight: FontWeight.w300
);

const textInputDecoration = InputDecoration(
                          hintText: "Email",
                          fillColor: bgBlack,
                          hintStyle: TextStyle(color: bgBlack),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Color.fromARGB(255, 163, 163, 163),width: 1),
                            borderRadius: BorderRadius.all(
                              Radius.circular(100),
                            ),
                          ),focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Color.fromARGB(255, 163, 163, 163),width: 1),
                            borderRadius: BorderRadius.all(
                              Radius.circular(100),
                            ),
                          )
                        );