import 'package:flutter/material.dart';
import 'package:stress_ducer/Login/constant/colors.dart';
import 'package:stress_ducer/Login/screens/Home/HomeTabBar/Home/Motivational_Quotes/motivational_api.dart';

class QuoteDisplay extends StatefulWidget {
  const QuoteDisplay({super.key});

  @override
  State<QuoteDisplay> createState() => _QuoteDisplayState();
}

class _QuoteDisplayState extends State<QuoteDisplay> {
  final motivational_api = MotivationalApi();

  Future<String> _fetchQuote() async {
    try {
      return await motivational_api.fetchMotivationalQuote();
    } catch (e) {
      return 'Failed to load motivational quote';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(0),
        child: Card(
          margin: EdgeInsets.only(top: 230),
          elevation: 20,
          color: Theme.of(context).colorScheme.onPrimaryContainer,
          child: Container(
            decoration: BoxDecoration(gradient: LinearGradient(colors: [Color.fromARGB(255, 255, 255, 255),Color.fromARGB(255, 255, 255, 255)])),
            child: Padding(
              padding: const EdgeInsets.all(35),
              child: SizedBox(
                width: 250,
                child: Container(
                  child: Column(children: [
                    FutureBuilder<String>(
                      future: _fetchQuote(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return CircularProgressIndicator();
                        } else if (snapshot.hasError) {
                          return Text('Error: ${snapshot.error}');
                        } else {
                          final quote = snapshot.data ?? 'No quote available';
                          return Column(
                            children: [
                              Text(
                                quote,
                                style: TextStyle(fontSize: 18),
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
          ),
        ),
      ),
    );
  }
}
