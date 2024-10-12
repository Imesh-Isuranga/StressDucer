import 'package:flutter/material.dart';

class CalenderHelp{
  Future getHelpTextPanel(BuildContext  context){
    return showModalBottomSheet(isScrollControlled: false, context: context, builder: (context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
                                  return SingleChildScrollView(
                                    child: Padding(
                                      padding: const EdgeInsets.all(12.0),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                        const SizedBox(height: 20,),
                                        Text("How to use Magic Calender",style: TextStyle(fontSize: screenWidth*0.05,fontWeight: FontWeight.w400,)),
                                        const SizedBox(height: 10,),
                                        Text("StressReducer's calendar empowers students to conquer their tasks and alleviate stress. It helps to effortlessly manage your tasks and stay on top of your goals with our intuitive calendar.",style: TextStyle(fontSize: screenWidth*0.038),),
                                        const SizedBox(height: 7,),
                                        Text("Using a calendar student can add a flag sign to remind their targets. After you add a flag you will get a notification at 8.00 am on the day on which you added the flag.",style: TextStyle(fontSize: screenWidth*0.038),),
                                        const SizedBox(height: 3,),
                                        Image.asset("assets/flag.png",width: MediaQuery.of(context).size.width*0.1,height: MediaQuery.of(context).size.height*0.1,),
                                        const SizedBox(height: 3,),
                                        Text("Also this calendar shows how many days you have left to work.",style: TextStyle(fontSize: screenWidth*0.038),),
                                      ]),
                                    ),
                                  );
                                },);
  }
}