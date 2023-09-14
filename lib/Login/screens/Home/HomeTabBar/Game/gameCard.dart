import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class GameCard extends StatefulWidget {
  const GameCard({super.key,required this.changeTab});

  final Function(int) changeTab;

  @override
  State<GameCard> createState() => _GameCardState();
}

class _GameCardState extends State<GameCard> {
  static String imageUrlPlayGames = 'assets/games.jpg';
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Container(
            decoration: BoxDecoration(
            border: Border(top: BorderSide(width: 0.3, color: Theme.of(context).indicatorColor),),),
            margin: const EdgeInsets.only(top: 3, bottom: 3, left: 0, right: 0),
            child: Card(
              margin: const EdgeInsets.only(top: 0, bottom: 3, left: 0, right: 0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  ListTile(
                    leading: Icon(Icons.polymer_sharp,size: screenWidth*0.07),
                    iconColor: Theme.of(context).iconTheme.color,
                    title: Text('Play Games',style:GoogleFonts.roboto(fontSize: screenWidth*0.038, fontWeight: FontWeight.w400),),
                    subtitle: Text("Relaxation Recess",style:GoogleFonts.roboto(fontSize: screenWidth*0.028,)),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Image.asset(
                        imageUrlPlayGames,width: screenWidth*0.4,height: screenWidth*0.4
                      ),
                      Expanded(
                        child: Column(
                          children: <Widget>[
                            const Divider(),
                            ListTile(
                              title: Text('Mindful Playgrounds',style:GoogleFonts.roboto(fontSize: screenWidth*0.037, fontWeight: FontWeight.w500),),
                              subtitle: Text('Engage in games designed for relaxation. Immerse yourself in soothing gameplay to unwind and de-stress.',style:GoogleFonts.roboto(fontSize: screenWidth*0.026,)),),
                            const Divider(),
                            TextButton(
                                onPressed: () {
                                  widget.changeTab(2);
                                },
                                child: Text("Play",style:GoogleFonts.roboto(fontSize: screenWidth*0.028,)))
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
  }
}