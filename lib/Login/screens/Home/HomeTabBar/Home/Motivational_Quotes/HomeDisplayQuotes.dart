import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:googleapis/calendar/v3.dart';
import 'package:stress_ducer/Login/constant/colors.dart';
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
    return Center(
      child: Card(
        margin: const EdgeInsets.only(top: 230),
        elevation: 20,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.7,
            child: Column(children: [
              FutureBuilder<String>(
                future: _fetchQuote(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Text(
                        'Be the change that you wish to see in the world.― Mahatma Gandhi',
                        style: GoogleFonts.montserrat(fontSize: 16));
                    // return CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text(
                        'Be the change that you wish to see in the world.― Mahatma Gandhi',
                        style: GoogleFonts.montserrat(fontSize: 16));
                    //   return Text('Error: ${snapshot.error}');
                  } else {
                    final quote = snapshot.data ??
                        'Be the change that you wish to see in the world.― Mahatma Gandhi';
                    // final quote = snapshot.data ?? 'No quote available';
                    return Column(
                      children: [
                        Text(
                          quote,
                          // style: const TextStyle(fontSize: 18),
                          style: GoogleFonts.montserrat(fontSize: 16),
                        ),
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
