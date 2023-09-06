import 'dart:math';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


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
        } else {
          itemColors[i] = color;
        }
      }
    });
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
            itemColors[2] = color;
            itemText[2] = itemText[index];
            itemText[index] = 9;
          }

          if (i == 3 && (index == 0 || index == 4 || index == 6)) {
            itemColors[index] = colorWhite;
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
            itemColors[index] = colorWhite;
            itemColors[5] = color;
            itemText[5] = itemText[index];
            itemText[index] = 9;
          }

          if (i == 6 && (index == 3 || index == 7)) {
            itemColors[index] = colorWhite;
            itemColors[6] = color;
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
        SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Card(
                margin: EdgeInsets.all(0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        const SizedBox(
                          width: 20,
                        ),
                        Text(
                          "Games",
                          style: GoogleFonts.roboto(
                              color: Colors.black,
                              fontSize: 25,
                              fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        const SizedBox(
                          width: 20,
                        ),
                        OutlinedButton(
                            onPressed: () {
                              setState(() {
                                showModalBottomSheet(isScrollControlled: false, context: context, builder: (context) {
                                  return SingleChildScrollView(
                                    child: Container(child: Padding(
                                      padding: const EdgeInsets.all(12.0),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                        const SizedBox(height: 20,),
                                        Text("Game Title: Stress-Relief Slider",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w400),),
                                        const SizedBox(height: 10,),
                                        Text("Game Description:",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w400),),
                                        const SizedBox(height: 10,),
                                        Text("Stress-Relief Slider is a soothing and mind-engaging puzzle game designed to help students unwind, relax, and alleviate stress. In this game, you'll find a 3x3 grid of squares, each with a unique number from 1 to 9. The game's calming visuals and simple mechanics are tailored to provide a stress-free gaming experience."),
                                        const SizedBox(height: 5,),
                                        Image.asset("assets/game-1.png",width: MediaQuery.of(context).size.width*0.5,height: MediaQuery.of(context).size.height*0.5,),
                                        const SizedBox(height: 5,),
                                        Text("1. You have a 3x3 grid consisting of 9 squares. One of these squares is empty and white, while the remaining 8 squares contain numbers from 1 to 9, shuffled randomly."),
                                        const SizedBox(height: 7,),
                                        Text("2. To move a numbered square, tap on it. The square you tapped on will move into the empty square's position, and the empty square will move into the square you tapped on."),
                                        const SizedBox(height: 7,),
                                        Text("3. You can only move a square into the empty square's position if there's a clear path (horizontally or vertically) between the two squares. In other words, you can't jump over other squares to reach the empty square."),
                                        const SizedBox(height: 7,),
                                        Text("4. Continue tapping and sliding squares to reorganize them. Your goal is to arrange the numbers in ascending order (1 to 9) in the shortest number of moves possible."),
                                        const SizedBox(height: 7,),
                                        Text("5. You win the game when you successfully arrange all the numbered squares in order from 1 to 9."),
                                        const SizedBox(height: 5,),
                                        Image.asset("assets/game-2.png",width: MediaQuery.of(context).size.width*0.5,height: MediaQuery.of(context).size.height*0.5,),
                                        const SizedBox(height: 5,),
                                        Text("How to Play for Stress Reduction:",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w400),),
                                        const SizedBox(height: 10,),
                                        Text("1. Mindful Movements: The game encourages players to engage in mindful movements. By tapping and sliding the numbered squares, you'll focus your attention on the task at hand, helping to clear your mind of distracting thoughts."),
                                        const SizedBox(height: 7,),
                                        Text("2. Progressive Relaxation: As you arrange the numbers in ascending order, you'll experience a sense of accomplishment with each successful move. This progressive relaxation can help reduce stress and anxiety."),
                                        const SizedBox(height: 7,),
                                        Text("3. Problem-Solving Therapy: Stress-Relief Slider is a form of problem-solving therapy. It challenges your brain to strategize and plan moves effectively, diverting your thoughts away from stressors."),
                                        const SizedBox(height: 7,),
                                        Text("4. Positive Distraction: Playing the game provides a healthy distraction from academic pressures and daily worries. It's a delightful way to take a break and recharge your mental energy."),
                                        const SizedBox(height: 7,),
                                        Text("5. Sense of Control: In this game, you're in control. You decide the sequence of moves. This sense of control can empower students to feel more confident and less stressed in their daily lives."),
                                        const SizedBox(height: 7,),
                                        Text("6. Self-Care Ritual: Incorporating short gaming sessions into your routine can establish a self-care ritual. Taking time for yourself to enjoy this game is an act of self-compassion and self-care."),
                                        const SizedBox(height: 7,),
                                        Text("7. Achievement Unlocked: Winning the game by arranging the numbers in order creates a sense of achievement. Celebrate your success and acknowledge your ability to overcome challenges.")
                                      ]),
                                    ),),
                                  );
                                },);
                              });
                            },
                            child: Text("Help"),
                            style: ButtonStyle(
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      20.0), // Adjust the radius as needed
                                ),
                              ),
                            ))
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ))),
        Expanded(
          child: Card(
            child: Column(
              children: [
                const SizedBox(
                  height: 50,
                ),
                Expanded(
                  child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
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
                            style: const TextStyle(
                                color: Colors.white, fontSize: 50),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 20,),
                TextButton(
                    onPressed: () {
                      shuffleAll();
                    },
                    child: const Text(
                      "Shuffle",
                      style: TextStyle(
                          fontSize: 20, color: Color.fromARGB(255, 2, 2, 108)),
                    )),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
