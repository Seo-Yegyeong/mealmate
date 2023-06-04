import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mealmate/screen/ingredient.dart';
import 'package:mealmate/screen/home.dart';
import 'package:mealmate/screen/meal_recommend.dart';
import 'package:mealmate/screen/menu_based.dart';

import 'package:mealmate/screen/start.dart';

class MealMateAPP extends StatelessWidget {
  const MealMateAPP({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'MealMate',
      initialRoute: '/',
      routes: {
        '/home': (BuildContext context) => const HomePage(),
        '/ingredient': (BuildContext context) => const IngredientPage(),
        '/menubased': (BuildContext context) => const MenuBasedPage(),
        '/mealrecommend': (BuildContext context) => const MealRecommendPage(),
        '/': (BuildContext context) => const StartPage(),
      },
      theme: ThemeData.light(useMaterial3: true),
    );
  }
}
