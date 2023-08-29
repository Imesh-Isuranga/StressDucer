import 'package:flutter/material.dart';

/// Flutter code sample for custom list items.

void main() => runApp(const CustomListItemApp());

class CustomListItemApp extends StatelessWidget {
  const CustomListItemApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(useMaterial3: true),
      home: const CustomListItemExample(),
    );
  }
}

class CustomListItemExample extends StatelessWidget {
  const CustomListItemExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Custom List Item Sample')),
      body: ListView(
        padding: const EdgeInsets.all(10.0),
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: SizedBox(
              height: 100,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  AspectRatio(
                    aspectRatio: 1.0,
                    child: Container(
                      decoration: const BoxDecoration(color: Colors.pink),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                        padding: const EdgeInsets.fromLTRB(20.0, 0.0, 2.0, 0.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              "title",
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const Padding(
                                padding: EdgeInsets.only(bottom: 2.0)),
                            Expanded(
                              child: Text(
                                "subtitle",
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontSize: 12.0,
                                  color: Colors.black54,
                                ),
                              ),
                            ),
                            Text(
                              "author",
                              style: const TextStyle(
                                fontSize: 12.0,
                                color: Colors.black87,
                              ),
                            ),
                            Text(
                              'publishDatereadDuration',
                              style: const TextStyle(
                                fontSize: 12.0,
                                color: Colors.black54,
                              ),
                            ),
                          ],
                        )),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
