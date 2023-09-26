import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';


class AboutUs extends StatefulWidget {
  const AboutUs({super.key});



  @override
  State<AboutUs> createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {


  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: const Text("About Us",style: TextStyle(color: Colors.white),),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("About CrossOrigin",style: TextStyle(fontWeight: FontWeight.w600,fontSize: screenWidth*0.04),),
              SizedBox(height: screenHeight*0.03,),
              Text("🌟 Welcome to CrossOrigin - We Connect The Future",style: TextStyle(fontWeight: FontWeight.w500,fontSize: screenWidth*0.04),textAlign: TextAlign.center,),
              SizedBox(height: screenHeight*0.001,),
              Image.asset("assets/CompanyLogo.png",width: MediaQuery.of(context).size.width*0.5,height: MediaQuery.of(context).size.height*0.3,),
              SizedBox(height: screenHeight*0.001,),
              Text("At CrossOrigin, we're more than just a development company; we're creators with a singular dedication to crafting solutions that make a real difference. Our brainchild, StressDucer, is a testament to this commitment, designed specifically to alleviate student stress and empower individuals to excel academically.",style:TextStyle(fontSize: screenWidth*0.035),),
              SizedBox(height: screenHeight*0.03,),
              Text("🛠️ Our Commitment to Excellence",style: TextStyle(fontWeight: FontWeight.w500,fontSize: screenWidth*0.04),textAlign: TextAlign.center,),
              SizedBox(height: screenHeight*0.03,),
              Text("Our team at CrossOrigin is driven by a deep-seated dedication to your success. From mobile app development to software engineering and website creation, we're focused on enhancing your digital experience in every way possible.",style:TextStyle(fontSize: screenWidth*0.035),),
              SizedBox(height: screenHeight*0.03,),
              Text("🗓️ Get in Touch",style: TextStyle(fontWeight: FontWeight.w500,fontSize: screenWidth*0.04),textAlign: TextAlign.center,),
              SizedBox(height: screenHeight*0.03,),
              Text("For any inquiries, including requests for the source code of StressDucer, please reach out to us.We're here to assist you in any way we can.",style:TextStyle(fontSize: screenWidth*0.035),),
              SizedBox(height: screenHeight*0.03,),
              ElevatedButton.icon(onPressed: () async{
                String email = Uri.encodeComponent("crossorigininfo@gmail.com");
                String subject = Uri.encodeComponent("Contact us");
                Uri mail = Uri.parse("mailto:$email?subject=$subject");
                if (await launchUrl(mail)) {
                    print("Opend");
                }else{
                    print("Something went wrong");
                }
              }, icon: const Icon(Icons.contact_mail_outlined), label: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Contact Us",style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.029),),
              ))
           ],
          ),
        ),
      )
    );
  }
}
