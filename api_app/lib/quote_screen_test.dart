import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

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

  Future<void> fetchQuote() async {
    const apiKey = 'ZuERH6N2jkqy5Nuswe5Vjw==dNYdILjcCjYytmir';
    const url = 'https://api-ninjas.com/api/quotes?apiKey=$apiKey';

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body) as Map<String, dynamic>;
        setState(() {
          quote = data['quote'] as String;
          author = data['author'] as String;
        });
      } else {
        // Fehlerbehandlung,
        print('Request failed with status: ${response.statusCode}.');
      }
    } catch (e) {
      // Fehlerbehandlung,
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(quote),
                Text(author),
                const SizedBox(height: 25),
                FloatingActionButton(
                  onPressed: fetchQuote,
                  child: const Icon(Icons.refresh),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}