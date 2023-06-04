import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'ingredient.dart';
import 'meal_recommend.dart';
import 'menu_based.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffFF7C33),
      body: SafeArea(
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Image.asset(
                    'assets/logo.png',
                    width: 250,
                  ),
                  const Center(
                    child: Text(
                      'MEALMATE',
                      style: TextStyle(
                        fontSize: 40,
                        fontFamily: 'Inter',
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                  MenuButton(context, 1, 'Ingredient-based recipe'),
                  MenuButton(context, 2, 'Menu-based recipes'),
                  MenuButton(context, 3, 'Meal Recommendation'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget MenuButton(context, index, text) =>
      Column(
        children: [
          SizedBox(height: 10,),
          SizedBox(
            width: MediaQuery.of(context).size.width *0.9,
            height: MediaQuery.of(context).size.width *0.25,
            child: ElevatedButton(
                  onPressed: () {
                    switch (index) {
                      case 1:
                        Get.to(()=> const IngredientPage());
                      case 2:
                        Get.to(()=> const MenuBasedPage());
                      case 3:
                        Get.to(()=> const MealRecommendPage());
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  ),
                  child: Text(
                    '$text',
                    style: const TextStyle(
                      fontSize: 25,
                      color: Colors.black,
                      fontFamily: 'Inter',
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
            ),
          ),
          const SizedBox(height: 10),
        ],
      );
}
