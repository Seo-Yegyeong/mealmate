import 'package:flutter/material.dart';
import 'package:mealmate/screen/ingredient_message.dart';

import 'meal_message.dart';
import 'menu_message.dart';

class ChatPromptPage extends StatefulWidget {
  int type;
  ChatPromptPage({Key? key, required this.type}) : super(key: key);

  @override
  _ChatPromptPageState createState() => _ChatPromptPageState();
}

class _ChatPromptPageState extends State<ChatPromptPage> {
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
      body: Column(
        children: [
          if (widget.type == 1) Expanded(child: MessagesIngre(),)
          else if (widget.type == 2) Expanded(child: MessagesMenu(),)
          else if (widget.type == 3) Expanded(child: MessagesMeal(),),

          if (widget.type == 1) NEWingre()
          else if (widget.type == 2) NEWmenu()
          else if (widget.type == 3) NEWmeal()
        ],
      ),
    );
  }
}
