import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mealmate/screen/chat_bubble.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;

const apiKey = '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';
const apiUrl = 'https://api.openai.com/v1/completions';

List<String> chat = ['추천 받고 싶은 음식의 카테고리 혹은 특징을 입력해주세요. 예) 양식, 깔끔한 것'];
List<bool> userOrGPT = [false];
final StreamController<String> ctrl = StreamController<String>();

Future<String> generateText(String prompt) async {
  ctrl.sink.add('추천 받고 싶은 음식의 카테고리 혹은 특징을 입력해주세요. 예) 양식, 깔끔한 것');
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

class NEWmeal extends StatefulWidget {
  const NEWmeal({Key? key}) : super(key: key);

  @override
  _NEWmealState createState() => _NEWmealState();
}

class _NEWmealState extends State<NEWmeal> {
  final _usercontroller = TextEditingController();
  int already = 0;

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
                  if (_usercontroller.text != 'more') {
                    prompt = "$prompt 에 해당되는 음식 메뉴 4개를 추천해줘";
                  } else {
                    prompt =
                        "${chat[2]}를 제외하고 ${chat[1]} 에 해당되는 음식 메뉴 4개를 추천해줘.";
                  }
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

                  if (already != 1) {
                    String more = "추가로 추천해드릴까요? \n더 추천을 원하시면 more 라고 입력해주세요.";
                    chat.add(more);
                    userOrGPT.add(false);
                    ctrl.sink.add(more);
                  }
                  already = 1;
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

class MessagesMeal extends StatelessWidget {
  const MessagesMeal({Key? key}) : super(key: key);

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
