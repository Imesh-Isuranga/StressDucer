import 'package:flutter/material.dart';

class GameHelp{
  Future getHelpTextPanel(BuildContext  context){
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return showModalBottomSheet(isScrollControlled: false, context: context, builder: (context) {
                                  return SingleChildScrollView(
                                    child: Padding(
                                      padding: const EdgeInsets.all(12.0),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                        const SizedBox(height: 20,),
                                        Text("Game Title: Stress-Relief Slider",style: TextStyle(fontSize: screenWidth*0.05,fontWeight: FontWeight.w400,),),
                                        const SizedBox(height: 10,),
                                        Text("Game Description:",style: TextStyle(fontSize: screenWidth*0.045,fontWeight: FontWeight.w400),),
                                        const SizedBox(height: 10,),
                                        Text("Stress-Relief Slider is a soothing and mind-engaging puzzle game designed to help students unwind, relax, and alleviate stress. In this game, you'll find a 3x3 grid of squares, each with a unique number from 1 to 9. The game's calming visuals and simple mechanics are tailored to provide a stress-free gaming experience.",style: TextStyle(fontSize: screenWidth*0.038),),
                                        const SizedBox(height: 5,),
                                        Image.asset("assets/game-1.png",width: MediaQuery.of(context).size.width*0.5,height: MediaQuery.of(context).size.height*0.5,),
                                        const SizedBox(height: 5,),
                                        Text("1. You have a 3x3 grid consisting of 9 squares. One of these squares is empty and white, while the remaining 8 squares contain numbers from 1 to 9, shuffled randomly.",style: TextStyle(fontSize: screenWidth*0.038),),
                                        const SizedBox(height: 7,),
                                        Text("2. To move a numbered square, tap on it. The square you tapped on will move into the empty square's position, and the empty square will move into the square you tapped on.",style: TextStyle(fontSize: screenWidth*0.038),),
                                        const SizedBox(height: 7,),
                                        Text("3. You can only move a square into the empty square's position if there's a clear path (horizontally or vertically) between the two squares. In other words, you can't jump over other squares to reach the empty square.",style: TextStyle(fontSize: screenWidth*0.038),),
                                        const SizedBox(height: 7,),
                                        Text("4. Continue tapping and sliding squares to reorganize them. Your goal is to arrange the numbers in ascending order (1 to 9) in the shortest number of moves possible.",style: TextStyle(fontSize: screenWidth*0.038),),
                                        const SizedBox(height: 7,),
                                        Text("5. You win the game when you successfully arrange all the numbered squares in order from 1 to 9.",style: TextStyle(fontSize: screenWidth*0.038),),
                                        const SizedBox(height: 5,),
                                        Image.asset("assets/game-2.png",width: MediaQuery.of(context).size.width*0.5,height: MediaQuery.of(context).size.height*0.5,),
                                        const SizedBox(height: 5,),
                                        Text("How to Play for Stress Reduction:",style: TextStyle(fontSize: screenWidth*0.045,fontWeight: FontWeight.w400),),
                                        const SizedBox(height: 10,),
                                        Text("1. Mindful Movements: The game encourages players to engage in mindful movements. By tapping and sliding the numbered squares, you'll focus your attention on the task at hand, helping to clear your mind of distracting thoughts.",style: TextStyle(fontSize: screenWidth*0.038),),
                                        const SizedBox(height: 7,),
                                        Text("2. Progressive Relaxation: As you arrange the numbers in ascending order, you'll experience a sense of accomplishment with each successful move. This progressive relaxation can help reduce stress and anxiety.",style: TextStyle(fontSize: screenWidth*0.038),),
                                        const SizedBox(height: 7,),
                                        Text("3. Problem-Solving Therapy: Stress-Relief Slider is a form of problem-solving therapy. It challenges your brain to strategize and plan moves effectively, diverting your thoughts away from stressors.",style: TextStyle(fontSize: screenWidth*0.038),),
                                        const SizedBox(height: 7,),
                                        Text("4. Positive Distraction: Playing the game provides a healthy distraction from academic pressures and daily worries. It's a delightful way to take a break and recharge your mental energy.",style: TextStyle(fontSize: screenWidth*0.038),),
                                        const SizedBox(height: 7,),
                                        Text("5. Sense of Control: In this game, you're in control. You decide the sequence of moves. This sense of control can empower students to feel more confident and less stressed in their daily lives.",style: TextStyle(fontSize: screenWidth*0.038),),
                                        const SizedBox(height: 7,),
                                        Text("6. Self-Care Ritual: Incorporating short gaming sessions into your routine can establish a self-care ritual. Taking time for yourself to enjoy this game is an act of self-compassion and self-care.",style: TextStyle(fontSize: screenWidth*0.038),),
                                        const SizedBox(height: 7,),
                                        Text("7. Achievement Unlocked: Winning the game by arranging the numbers in order creates a sense of achievement. Celebrate your success and acknowledge your ability to overcome challenges.",style: TextStyle(fontSize: screenWidth*0.038),)
                                      ]),
                                    ),
                                  );
                                },);
  }
}