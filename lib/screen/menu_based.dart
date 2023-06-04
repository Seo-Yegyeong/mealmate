import 'package:flutter/material.dart';
import 'package:mealmate/screen/menu_message.dart';

class MenuBasedPage extends StatefulWidget {
  const MenuBasedPage({Key? key}) : super(key: key);

  @override
  _MenuBasedPageState createState() => _MenuBasedPageState();
}

class _MenuBasedPageState extends State<MenuBasedPage> {
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
            child: MessagesMenu(),
          ),
          NEWmenu(),
        ],
      ),
    );
  }
}
