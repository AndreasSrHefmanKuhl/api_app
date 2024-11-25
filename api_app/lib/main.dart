import 'dart:convert';

import 'package:flutter/material.dart';

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
  Widget build(BuildContext context) {
    const JsonDecoder decoder = JsonDecoder();

    const String jsonString = '''
    {
      "quote": "Success, as I see it, is a result, not a goal.",
      "author": "Flaubert, George",
      "category": "success"
    }''';

    final Map<String, dynamic> quotes = decoder.convert(jsonString);
    final quote = quotes.toString();

    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Text(quote),
              const SizedBox(height: 25),
              FloatingActionButton(onPressed: () {}),
            ]),
          ),
        ),
      ),
    );
  }
}
