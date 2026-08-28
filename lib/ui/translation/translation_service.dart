import 'dart:convert';
import 'package:http/http.dart' as http;

Future<String> translateText(String text, String from, String to) async {
  final String url = 'https://api.mymemory.translated.net/get?q=$text&langpair=$from|$to';

  final response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    final data = json.decode(response.body);
    return data['responseData']['translatedText'];
  } else {
    return 'Translation failed';
  }
}
