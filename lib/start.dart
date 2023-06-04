import 'package:flutter/material.dart';

class StartPage extends StatefulWidget {
  const StartPage({Key? key}) : super(key: key);

  @override
  StartPageState createState() => StartPageState();
}

class StartPageState extends State<StartPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffFF7C33),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const SizedBox(height: 60.0),
          Image.asset(
            'assets/logo.png',
            width: 326,
            height: 370,
          ),
          const Center(
            child: Text(
              'MEALMATE',
              style: TextStyle(
                fontSize: 50,
                fontFamily: 'Inter',
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
          Container(
            width: 300,
            height: 50,
            margin: const EdgeInsets.only(bottom: 100),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30),
            ),
            child: TextButton(
              child: const Text(
                'START!',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 25,
                  fontFamily: 'Inter',
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.w900,
                ),
              ),
              onPressed: () {
                Navigator.pushNamed(context, '/home');
              },
            ),
          ),
        ],
      ),
    );
  }
}
