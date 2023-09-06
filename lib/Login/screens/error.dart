import 'package:flutter/material.dart';

class Error{

      Widget button(BuildContext context){
       return TextButton(
      child: const Text("OK"),
      onPressed: () {
        Navigator.of(context).pop();
        ;
      },
    );
      }

    AlertDialog msg(BuildContext context,String text){
      return AlertDialog(
      title: Text(text),
      actions: [
        button(context),
      ],
    );
    }

    AlertDialog errorMsg(BuildContext context,String text){
      return AlertDialog(
      title: Text(
        text,
        style: TextStyle(color: Colors.red),
      ),
      actions: [
        button(context),
      ],
    );
    }
}