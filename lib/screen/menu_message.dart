import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mealmate/screen/chat_bubble.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;

const apiKey = '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';
const apiUrl = 'https://api.openai.com/v1/completions';

List<String> chat = ['만들고 싶은 요리를 입력해주세요.'];
List<bool> userOrGPT = [false];
final StreamController<String> ctrl = StreamController<String>();

Future<String> generateText(String prompt) async {
  ctrl.sink.add('만들고 싶은 요리를 입력해주세요.');
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

class NEWmenu extends StatefulWidget {
  const NEWmenu({Key? key}) : super(key: key);

  @override
  _NEWmenuState createState() => _NEWmenuState();
}

class _NEWmenuState extends State<NEWmenu> {
  final _usercontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      margin: const EdgeInsets.only(top: 8),
      padding: const EdgeInsets.all(8),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: TextField(
                  textInputAction: TextInputAction.go,
                  onSubmitted: (value) async {
                    // ADD User CHAT
                    String prompt = _usercontroller.text;
                    prompt = "$prompt 를 만들고 싶어. 필요한 재료랑 레시피 알려줘";
                    chat.add(_usercontroller.text);
                    userOrGPT.add(true);
                    ctrl.sink.add(_usercontroller.text);

                    setState(() {
                      _usercontroller.clear();
                    });

                    // ADD chatGPT CHAT
                    Future<String> gptAnswer = generateText(prompt);
                    String gptString = '';
                    await gptAnswer.then((String result) {
                      setState(() {
                        gptString = result.trim();
                        print(gptString);
                      });
                    });
                    chat.add(gptString);
                    userOrGPT.add(false);
                    ctrl.sink.add(gptString);

                    String more = "다른 요리의 레시피를 원하시면 원하시는 요리의 이름을 입력해주세요.";
                    chat.add(more);
                    userOrGPT.add(false);
                    ctrl.sink.add(more);
                  },
                  maxLines: null,
                  controller: _usercontroller,
                  decoration: const InputDecoration(
                      labelText: 'Send a message...',
                      labelStyle: TextStyle(
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic,
                      )),
                ),
              ),
              IconButton(
                onPressed: () async {
                  // ADD User CHAT
                  String prompt = _usercontroller.text;
                  prompt = "$prompt 를 만들고 싶어. 필요한 재료랑 레시피 알려줘";
                  chat.add(_usercontroller.text);
                  userOrGPT.add(true);
                  ctrl.sink.add(_usercontroller.text);

                  setState(() {
                    _usercontroller.clear();
                  });

                  // ADD chatGPT CHAT
                  Future<String> gptAnswer = generateText(prompt);
                  String gptString = '';
                  await gptAnswer.then((String result) {
                    setState(() {
                      gptString = result.trim();
                      print(gptString);
                    });
                  });
                  chat.add(gptString);
                  userOrGPT.add(false);
                  ctrl.sink.add(gptString);

                  String more = "다른 요리의 레시피를 원하시면 원하시는 요리의 이름을 입력해주세요.";
                  chat.add(more);
                  userOrGPT.add(false);
                  ctrl.sink.add(more);
                },
                icon: const Icon(Icons.send),
                color: const Color(0xffFF7C33),
              ),
            ],
          ),
          const SizedBox(height: 30)
        ],
      ),
    );
  }
}

class MessagesMenu extends StatelessWidget {
  const MessagesMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: ctrl.stream,
      builder: (context, snapshot) {
        return ListView.builder(
          reverse: true,
          itemCount: chat.length,
          itemBuilder: (context, index) {
            return ChatBubble(chat[chat.length - index - 1],
                userOrGPT[chat.length - index - 1]);
          },
        );
      },
    );
  }
}
