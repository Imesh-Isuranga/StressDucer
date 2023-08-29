import 'dart:math';
import 'package:flutter/material.dart';




class Games extends StatefulWidget {

  const Games({super.key});

  
  @override
  _GamesState createState() => _GamesState();
}

class _GamesState extends State<Games> {
  static Color color = const Color.fromARGB(255, 3, 27, 163);
  static Color colorWhite = const Color.fromARGB(255, 255, 255, 255);

  List<Color> itemColors = List.generate(9, (index) => color);
  List<int> itemText = [1, 2, 3, 4, 5, 6, 7, 9, 8];
  List<int> itemTextTemp = List.generate(9, (index) => index + 1);

  final random = Random();

  void shuffleAll() {
    setState(() {
      itemText.shuffle();
      for (int i = 0; i <= 8; i++) {
        if (itemText[i] == 9) {
          itemColors[i] = colorWhite;
        }else{
          itemColors[i] = color;
        }
      }
   }
    );
  }
  

  @override
  void initState() {
    shuffleAll();
    super.initState();
  }

  void _handleItemTap(int index) {
    Widget okButton = TextButton(
      child: const Text("OK"),
      onPressed: () {
        Navigator.of(context).pop();
        ;
      },
    );

    AlertDialog alert = AlertDialog(
      title: const Text("Congratulations"),
      content: const Text("You won!"),
      actions: [
        okButton,
      ],
    );
    setState(() {
      // Change the color of the tapped container using the index.
      for (int i = 0; i <= 8; i++) {
        if (itemColors[i] == colorWhite) {
          if (i == 0 && (index == 1 || index == 3)) {
            itemColors[index] = colorWhite;
            itemColors[0] = color;
            itemText[0] = itemText[index];
          itemText[index] = 9;
          }

          if (i == 1 && (index == 0 || index == 2 || index == 4)) {
            itemColors[index] = colorWhite;
            itemColors[1] = color;
            itemText[1] = itemText[index];
          itemText[index] = 9;
          }

          if (i == 2 && (index == 1 || index == 5)) {
            itemColors[index] = colorWhite;
            itemColors[2] =color;
            itemText[2] = itemText[index];
          itemText[index] = 9;
          }

          if (i == 3 && (index == 0 || index == 4 || index==6)) {
            itemColors[index] =colorWhite;
            itemColors[3] = color;
            itemText[3] = itemText[index];
          itemText[index] = 9;
          }

          if (i == 4 &&
              (index == 1 || index == 3 || index == 5 || index == 7)) {
            itemColors[index] = colorWhite;
            itemColors[4] = color;
            itemText[4] = itemText[index];
          itemText[index] = 9;
          }

          if (i == 5 && (index == 2 || index == 4 || index == 8)) {
            itemColors[index] =colorWhite;
            itemColors[5] =color;
            itemText[5] = itemText[index];
          itemText[index] = 9;
          }

          if (i == 6 && (index == 3 || index == 7)) {
            itemColors[index] = colorWhite;
            itemColors[6] =color;
            itemText[6] = itemText[index];
          itemText[index] = 9;
          }
          if (i == 7 && (index == 4 || index == 6 || index == 8)) {
            itemColors[index] = colorWhite;
            itemColors[7] = color;
            itemText[7] = itemText[index];
          itemText[index] = 9;
          }

          if (i == 8 && (index == 5 || index == 7)) {
            itemColors[index] = colorWhite;
            itemColors[8] = color;
            itemText[8] = itemText[index];
          itemText[index] = 9;
          }

        }
      }

      int temp = 0;
      for (int i = 0; i < itemText.length; i++) {
        if (itemText[i] == itemTextTemp[i]) {
          temp++;
        }
      }

      if (temp == itemText.length) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return alert;
          },
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 50,),
        Expanded(
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
            ),
            itemCount: 9,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () => _handleItemTap(index),
                child: Container(
                  color: itemColors[index],
                  margin: const EdgeInsets.all(10.0),
                  alignment: Alignment.center,
                  child: Text(
                    itemText[index].toString(),
                    style: const TextStyle(color: Colors.white, fontSize: 50),
                  ),
                ),
              );
            },
          ),
        ),
        TextButton(
            onPressed: () {
              shuffleAll();
            },
            child: const Text(
              "Shuffle",
              style: TextStyle(fontSize: 20,color: Color.fromARGB(255, 2, 2, 108)),
            )),
      ],
    );
  }
}