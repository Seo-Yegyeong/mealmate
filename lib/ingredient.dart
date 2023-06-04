import 'package:flutter/material.dart';

const apiKey = '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';
const apiUrl = 'https://api.openai.com/v1/completions';

class IngredientPage extends StatefulWidget {
  const IngredientPage({super.key});

  @override
  State<IngredientPage> createState() => _IngredientPageState();
}

class _IngredientPageState extends State<IngredientPage> {
  @override
  Widget build(BuildContext context) {
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
      body: const Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [],
      ),
    );
  }
}
