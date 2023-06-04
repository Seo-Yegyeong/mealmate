import 'package:flutter/material.dart';
import 'package:mealmate/screen/meal_message.dart';

class MealRecommendPage extends StatefulWidget {
  const MealRecommendPage({Key? key}) : super(key: key);

  @override
  _MealRecommendPageState createState() => _MealRecommendPageState();
}

class _MealRecommendPageState extends State<MealRecommendPage> {
  @override
  void initState() {
    super.initState();
  }

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
        children: [
          Expanded(
            child: MessagesMeal(),
          ),
          NEWmeal(),
        ],
      ),
    );
  }
}
