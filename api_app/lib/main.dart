import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const QuoteScreen());
}

class QuoteScreen extends StatefulWidget {
  const QuoteScreen({super.key});

  @override
  State<QuoteScreen> createState() => _QuoteScreenState();
}

class _QuoteScreenState extends State<QuoteScreen> {
  String quote = '';
  String author = '';

  @override
  void initState() {
    super.initState();
    loadLastQuote();
  }
  /* const JsonDecoder decoder = JsonDecoder();

    const String jsonString = '''
    {
      "quote": "Success, as I see it, is a result, not a goal.",
      "author": "Flaubert, George",
      "category": "success"
    }''';

    final Map<String, dynamic> quotes = decoder.convert(jsonString);
    final quote = quotes.toString();*/

  Future getQuote() async {
    const apiKey = 'ZZuERH6N2jkqy5Nuswe5Vjw==dNYdILjcCjYytmir';
    const url = 'https://api-ninjas.com/api/quotes?apiKey=$apiKey';
    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);

        setState(() {
          quote = data['quote'];
          author = data['author'];
          _saveQuote(quote, author);
        });
      } else {
        print('Error: ${response.statusCode}');
      }
    } catch (error) {
      print('$error');
    }
  }

  Future<void> loadLastQuote() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      quote = prefs.getString('quote') ?? '';
      author = prefs.getString('author') ?? '';
    });
  }

  Future<void> _saveQuote(String quote, String author) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('quote', quote);
    await prefs.setString('author', author);
  }

  Future<void> _deleteQuote() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('quote');
    await prefs.remove('author');
    setState(() {
      quote = '';
      author = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Text(
                '"$quote"',
                style: const TextStyle(fontSize: 35),
              ),
              const SizedBox(height: 25),
              Text('"$author"', style: const TextStyle(fontSize: 35)),
              const SizedBox(height: 25),
              FloatingActionButton(
                onPressed: getQuote,
                child: const Icon(Icons.delete),
              ),
              const SizedBox(height: 25),
              FloatingActionButton(
                  onPressed: () => _deleteQuote(),
                  child: const Icon(Icons.refresh))
            ]),
          ),
        ),
      ),
    );
  }
}
