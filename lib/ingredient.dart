import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

const apiKey = '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';
const apiUrl = 'https://api.openai.com/v1/completions';

Future<String> generateText(String prompt) async {
  final response = await http.post(
    Uri.parse(apiUrl),
    headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $apiKey'
    },
    body: jsonEncode({
      "model": "text-davinci-003",
      'prompt': prompt,
      'max_tokens': 1000,
      'temperature': 0,
      'top_p': 1,
      'frequency_penalty': 0,
      'presence_penalty': 0
    }),
  );

  Map<String, dynamic> newresponse =
      jsonDecode(utf8.decode(response.bodyBytes));

  return newresponse['choices'][0]['text'];
}

class IngredientPage extends StatefulWidget {
  const IngredientPage({super.key});

  @override
  State<IngredientPage> createState() => _IngredientPageState();
}

class _IngredientPageState extends State<IngredientPage> {
  @override
  Widget build(BuildContext context) {
    final TextEditingController textcontroller = TextEditingController();

    return Scaffold(
      backgroundColor: const Color(0xffFF7C33),
      appBar: AppBar(
        title: const Text(
          "MEALMATE",
          style: TextStyle(
            fontSize: 30,
            fontFamily: 'Inter',
            fontStyle: FontStyle.italic,
            fontWeight: FontWeight.w900,
          ),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextField(
            controller: textcontroller,
          ),
          TextButton(
            onPressed: () {
              String prompt = textcontroller.text;
              prompt = "$prompt 이 재료들로 만들 수 있는 음식 5개 추천해줘";
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => ResultPage(prompt)));
            },
            child: const Text("Get Result"),
          ),
        ],
      ),
    );
  }
}

class ResultPage extends StatefulWidget {
  final String prompt;
  const ResultPage(this.prompt, {super.key});

  @override
  State<ResultPage> createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Result from GPT"),
      ),
      // body: Text(widget.prompt),
      body: FutureBuilder<String>(
        future: generateText(widget.prompt),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            return Text('${snapshot.data}');
          }
        },
      ),
    );
  }
}
