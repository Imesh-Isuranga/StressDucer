import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TodayTaskCard extends StatefulWidget {
  const TodayTaskCard({super.key,required this.changeTab});

  final Function(int) changeTab;

  @override
  State<TodayTaskCard> createState() => _TodayTaskCardState();
}

class _TodayTaskCardState extends State<TodayTaskCard> {
  static String imageUrlTodayTasks = 'assets/todo.jpg';
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Container(
            decoration: BoxDecoration(
            border: Border(top: BorderSide(width: 0.3, color: Theme.of(context).indicatorColor),),),
            margin: const EdgeInsets.only(top: 3, bottom: 3, left: 0, right: 0),
            child: Card(
              margin: const EdgeInsets.all(0),
              child: InkWell(
                onTap: () {
                  widget.changeTab(1);;
                },
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    children: <Widget>[
                      Row(
                        children: [
                          Expanded(
                            child: ListTile(
                              title: Text("Today Tasks",style:GoogleFonts.roboto(fontSize: screenWidth*0.038, fontWeight: FontWeight.w400),),
                              leading: Icon(Icons.task,size: screenWidth*0.07),
                              iconColor: Theme.of(context).iconTheme.color,
                              subtitle: Text("Plan your day with achievable goals",style:GoogleFonts.roboto(fontSize: screenWidth*0.028)),),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Image.asset(
                              imageUrlTodayTasks,width: screenWidth*0.4,height: screenWidth*0.4),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
  }
}