import 'package:flutter/material.dart';
import 'package:mealmate/screen/chat_screen.dart';
import 'package:mealmate/screen/home.dart';
import 'package:mealmate/screen/ingredient.dart';

// import 'package:mealmate/screen/new_message.dart';
import 'package:mealmate/screen/start.dart';

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
        '/me': (BuildContext context) => const ChatScreen(),
      },
      theme: ThemeData.light(useMaterial3: true),
    );
  }
}
