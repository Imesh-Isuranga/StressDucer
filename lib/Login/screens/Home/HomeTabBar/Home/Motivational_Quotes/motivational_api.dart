import 'dart:convert';
import 'package:http/http.dart' as http;

class MotivationalApi{
  Future<String> fetchMotivationalQuote() async {
  final response = await http.get(Uri.parse('https://zenquotes.io/api/random'));
  if (response.statusCode == 200) {
    final jsonData = json.decode(response.body);
    final quote = jsonData[0]['q'] ?? '';
    final author = jsonData[0]['a'] ?? '';
    return '"$quote" - $author';
  } else {
    throw Exception('Failed to load motivational quote');
  }
}
}