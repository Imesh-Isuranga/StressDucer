import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stress_ducer/Login/constant/colors.dart';
import 'package:stress_ducer/Login/screens/Home/HomeTabBar/Game/gameHelp.dart';



class Games extends StatefulWidget {
  const Games({super.key});

  @override
  _GamesState createState() => _GamesState();
}

class _GamesState extends State<Games> {
  static Color color = const Color.fromARGB(255, 1, 90, 27);
  static Color colorWhite = const Color.fromARGB(255, 255, 255, 255).withOpacity(0);
  int state = 1;

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
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return ListView(
      children: [   
            Card(
              margin: const EdgeInsets.all(0),
              child: Padding(
                padding: EdgeInsets.only(left: screenWidth*0.05),
                child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                      SizedBox(height: screenHeight*0.02,),
                      Text("Games",style: GoogleFonts.roboto(fontSize: screenWidth*0.053, fontWeight: FontWeight.w600),),
                      SizedBox(height: screenHeight*0.02,),
                      Row(
                        children: [
                          SizedBox(
                            width: screenWidth*0.2,
                            height: screenWidth*0.0625,
                            child: ElevatedButton(
                                    onPressed: () {
                                      GameHelp().getHelpTextPanel(context);
                                    },
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor:
                                            btnBackGreen.withOpacity(0.5),
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(20))),
                                    child: Text("Help",style: GoogleFonts.roboto(fontSize: screenWidth * 0.033,fontWeight: FontWeight.w600),),
                                  ),
                          ),
                                SizedBox(width: screenWidth*0.04,),
                                if(state == 2)SizedBox(
                                  width: screenWidth*0.2,
                                  height: screenWidth*0.0625,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      setState(() {
                                        state = 1;
                                      });
                                    },
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor:
                                            btnBackGreen.withOpacity(0.5),
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(20))),
                                    child: Text("Back",style: GoogleFonts.roboto(fontSize: screenWidth * 0.033,fontWeight: FontWeight.w600),),
                                  ),
                                ),
                        ],
                      ),
                      SizedBox(height: screenHeight*0.02,)
                      ]),
              ),
              ),
              SizedBox(height: screenHeight * 0.0025,),
              Divider(height: 0.3, color: Theme.of(context).indicatorColor,),
              SizedBox(height: screenHeight * 0.0025,),
              if(state==1)SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Card(
                    margin: const EdgeInsets.all(0),
                    child: Padding(
                      padding: const EdgeInsets.all(13.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          if(Theme.of(context).brightness==Brightness.dark)
                          Image.asset("assets/cardGame-dark.jpg",width: MediaQuery.of(context).size.width*0.5,height: MediaQuery.of(context).size.width*0.5),
                          if(Theme.of(context).brightness==Brightness.light)
                          Image.asset("assets/cardGame.jpg",width: MediaQuery.of(context).size.width*0.5,height: MediaQuery.of(context).size.width*0.5),
                          Text("This is simple Game Develop for Mind Relax",style: GoogleFonts.roboto(fontSize: screenWidth*0.029,fontWeight: FontWeight.w400),textAlign: TextAlign.center,),
                        SizedBox(height: screenHeight*0.02,),
                        SizedBox(
                          width: screenWidth*0.64,
                          height: screenWidth*0.06,
                          child: ElevatedButton(
                                      onPressed: () {
                                        setState(() {
                                          state = 2;
                                        });
                                      },
                                      style: ElevatedButton.styleFrom(
                                      backgroundColor:btnBackGreen.withOpacity(0.5),
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
                                      child: Text("Play Now",style: GoogleFonts.roboto(fontSize: screenWidth * 0.029,fontWeight: FontWeight.w600),),
                                    ),
                        )
                      ]),
                    ),
                  ),
                ),
                if(state==2)Card(
                  child: Column(
                  children: [ 
                    GridView.builder(
                    shrinkWrap: true,
                    gridDelegate:const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,),
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
                              style: TextStyle(color: Theme.of(context).scaffoldBackgroundColor, fontSize: screenWidth*0.09),
                            ),
                          ),
                        );
                      },
                    ),
                
                  SizedBox(height: screenHeight*0.02,),
                  TextButton(
                      onPressed: () {
                        shuffleAll();
                      },
                      child: Text("Shuffle",style: TextStyle(fontSize: screenWidth*0.05),
                      )),
                ],
              ),
          ),
      ],
    );
  }
}
