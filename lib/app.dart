import 'package:flutter/material.dart';
import 'package:mealmate/home.dart';
import 'package:mealmate/ingredient.dart';
import 'package:mealmate/start.dart';

class MealMateAPP extends StatelessWidget {
  const MealMateAPP({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MealMate',
      initialRoute: '/',
      routes: {
        '/home': (BuildContext context) => const HomePage(),
        '/ingredient': (BuildContext context) => const IngredientPage(),
        '/': (BuildContext context) => const StartPage(),
      },
      theme: ThemeData.light(useMaterial3: true),
    );
  }
}
