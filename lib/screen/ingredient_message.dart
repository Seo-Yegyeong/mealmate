import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mealmate/screen/chat_bubble.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;

const apiKey = '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';
const apiUrl = 'https://api.openai.com/v1/completions';

List<String> chat = ['가지고 있는 재료를 입력해주세요.'];
List<bool> userOrGPT = [false];
final StreamController<String> ctrl = StreamController<String>();

Future<String> generateText(String prompt) async {
  ctrl.sink.add('가지고 있는 재료를 입력해주세요.');
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

class NEWingre extends StatefulWidget {
  const NEWingre({Key? key}) : super(key: key);

  @override
  _NEWingreState createState() => _NEWingreState();
}

class _NEWingreState extends State<NEWingre> {
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
                    if (already != 1) {
                      prompt = "$prompt 이 재료들을 활용해서 만들 수 있는 요리 4가지 추천해줘.";
                    } else {
                      prompt = "$prompt 이 재료 이거 레시피 구체적으로 알려줘";
                      already = 2;
                    }
                  } else {
                    prompt =
                        "${chat[2]}를 제외하고 ${chat[1]} 이 재료들을 활용해서 만들 수 있는 요리 4가지 더 알려줘.";
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
                      gptString = result;
                      print(gptString);
                    });
                  });
                  chat.add(gptString);
                  userOrGPT.add(false);
                  ctrl.sink.add(gptString);

                  if (already != 2) {
                    String more = '';
                    if (already == 0) {
                      more =
                          "1) 구체적인 레시피를 알고 싶으시면 메뉴 이름을 입력해주세요!\n2) 다른 메뉴를 보고 싶으시면 more 라고 입력해주세요.";
                    } else {
                      more = "구체적인 레시피를 알고 싶으시면 메뉴 이름을 입력해주세요!";
                    }
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

class MessagesIngre extends StatelessWidget {
  const MessagesIngre({Key? key}) : super(key: key);

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
