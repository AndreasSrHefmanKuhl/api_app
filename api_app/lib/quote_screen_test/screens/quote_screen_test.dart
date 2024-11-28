import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as variable;

class QuoteScreenTest extends StatefulWidget {
  const QuoteScreenTest({super.key});

  @override
  State<QuoteScreenTest> createState() => _QuoteScreenState();
}

class _QuoteScreenState extends State<QuoteScreenTest> {
  String quote = '';
  String author = '';

  Future<void> getQuote() async {
    const apiKey = 'ZuERH6N2jkqy5Nuswe5Vjw==dNYdILjcCjYytmir';
    const url = 'https://api-ninjas.com/api/quotes?apiKey=$apiKey';

    try {
      final response = await variable.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body) as Map<String, dynamic>;
        setState(() {
          quote = data['quote'] as String;
          author = data['author'] as String;
        });
      } else {
        // Fehlerbehandlung,
        throw Exception('Request failed with status: ${response.statusCode}.');
      }
    } catch (e) {
      // Fehlerbehandlung,
      throw Exception('Error: $e');
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
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(quote.toString()),
                const SizedBox(height: 10),
                Text(author.toString()),
                const SizedBox(height: 10),
                FloatingActionButton(
                  onPressed: getQuote,
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
