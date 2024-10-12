import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';


class HelpAndSupport extends StatefulWidget {
  const HelpAndSupport({super.key});



  @override
  State<HelpAndSupport> createState() => _HelpAndSupportState();
}

class _HelpAndSupportState extends State<HelpAndSupport> {


  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: const Text("Help And Support",style: TextStyle(color: Colors.white),),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("Welcome to StressDucer: Your Personal Stress-Busting Companion!",style: TextStyle(fontWeight: FontWeight.w600,fontSize: screenWidth*0.04,),textAlign: TextAlign.center,),
              SizedBox(height: screenHeight*0.03,),
              Text("🌟 About StressDucer 🌟",style: TextStyle(fontWeight: FontWeight.w500,fontSize: screenWidth*0.04),textAlign: TextAlign.center,),
              SizedBox(height: screenHeight*0.03,),
              Text("Embark on a journey towards tranquility with StressDucer, this dedicated mobile app designed to alleviate the burdens of student life. Say goodbye to stress and welcome a newfound sense of balance, productivity, and peace.",style:TextStyle(fontSize: screenWidth*0.035),),
              SizedBox(height: screenHeight*0.03,),
              Text("🛠️ Customized Timetables for Optimal Performance",style: TextStyle(fontWeight: FontWeight.w500,fontSize: screenWidth*0.04),textAlign: TextAlign.center,),
              SizedBox(height: screenHeight*0.03,),
              Text("After a seamless registration process, StressDucer crafts personalized timetables tailored to your unique preferences and commitments. Need a change? Dive into the settings and effortlessly tweak the complexity to align with your goals. Whether it's a refresh or a challenge, your schedule adapts to suit your needs.",style:TextStyle(fontSize: screenWidth*0.035),),
              SizedBox(height: screenHeight*0.03,),
              Text("🗓️ Effortless Task Management with Magic Calendar",style: TextStyle(fontWeight: FontWeight.w500,fontSize: screenWidth*0.04),textAlign: TextAlign.center,),
              SizedBox(height: screenHeight*0.03,),
              Text("Say hello to the Magic Calendar, your secret weapon for task management. Effortlessly organize and track your to-dos, and watch as StressDucer sends timely reminders, ensuring nothing slips through the cracks. Your productivity has never been so enchantingly managed..",style:TextStyle(fontSize: screenWidth*0.035),),
              SizedBox(height: screenHeight*0.03,),
              Text("🎮 Games for Instant Relaxation",style: TextStyle(fontWeight: FontWeight.w500,fontSize: screenWidth*0.04),textAlign: TextAlign.center,),
              SizedBox(height: screenHeight*0.03,),
              Text("Take a break from the hustle and bustle with our curated selection of games. Enjoy moments of light-hearted fun and recharge your mind, all within the StressDucer app.",style:TextStyle(fontSize: screenWidth*0.035),),
              SizedBox(height: screenHeight*0.03,),
              Text("📊 Empowering Stress and Depression Tests",style: TextStyle(fontWeight: FontWeight.w500,fontSize: screenWidth*0.04),textAlign: TextAlign.center,),
              SizedBox(height: screenHeight*0.03,),
              Text("Gain insights into your mental well-being with our doctor-approved stress and depression tests. These assessments serve as a compass for self-awareness, guiding you towards a path of self-improvement and resilience..",style:TextStyle(fontSize: screenWidth*0.035),),
              SizedBox(height: screenHeight*0.03,),
              Text("🆘 Help and Support: We're Here for You",style: TextStyle(fontWeight: FontWeight.w500,fontSize: screenWidth*0.04),textAlign: TextAlign.center,),
              SizedBox(height: screenHeight*0.03,),
              Text("At StressDucer, your well-being is our priority. Should you ever need assistance or have questions about using the app, our dedicated support team is just a message away. Feel free to reach out, and we'll be thrilled to guide you through your stress-busting journey.\n\nRemember, with StressDucer, you're not alone. Together, we'll conquer stress and pave the way for a brighter, more balanced tomorrow.",style:TextStyle(fontSize: screenWidth*0.035),),
              SizedBox(height: screenHeight*0.03,),
              ElevatedButton.icon(onPressed: () async{
                String email = Uri.encodeComponent("crossorigininfo@gmail.com");
                String subject = Uri.encodeComponent("Help And Support");
                Uri mail = Uri.parse("mailto:$email?subject=$subject");
                if (await launchUrl(mail)) {
                    print("Opend");
                }else{
                    print("Something went wrong");
                }
              }, icon: const Icon(Icons.help_center), label: Text("Contact Support",style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.025),))
           ],
          ),
        ),
      )
    );
  }
}
