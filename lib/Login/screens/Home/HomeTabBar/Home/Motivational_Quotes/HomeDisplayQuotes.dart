import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stress_ducer/Login/screens/Home/HomeTabBar/Home/Motivational_Quotes/motivational_api.dart';

class QuoteDisplay extends StatefulWidget {
  const QuoteDisplay({super.key});

  @override
  State<QuoteDisplay> createState() => _QuoteDisplayState();
}

class _QuoteDisplayState extends State<QuoteDisplay> {
  final motivationalapi = MotivationalApi();

  Future<String> _fetchQuote() async {
    try {
      return await motivationalapi.fetchMotivationalQuote();
    } catch (e) {
      return 'Be the change that you wish to see in the world.― Mahatma Gandhi';
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Center(
      child: Card(
        margin: EdgeInsets.only(top: screenHeight*0.3),
        elevation: 20,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: SizedBox(
            width: screenWidth * 0.7,
            child: Column(children: [
              FutureBuilder<String>(
                future: _fetchQuote(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Text(
                        'Be the change that you wish to see in the world.― Mahatma Gandhi',
                        style: GoogleFonts.montserrat(fontSize: screenWidth*0.038));
                    // return CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text(
                        'Be the change that you wish to see in the world.― Mahatma Gandhi',
                        style: GoogleFonts.montserrat(fontSize: screenWidth*0.038));
                    //   return Text('Error: ${snapshot.error}');
                  } else {
                    final quote = snapshot.data ?? 'Be the change that you wish to see in the world.― Mahatma Gandhi';
                    return Column(
                      children: [
                        Text(quote,style: GoogleFonts.montserrat(fontSize: screenWidth*0.038),),
                      ],
                    );
                  }
                },
              )
            ]),
          ),
        ),
      ),
    );
  }
}
