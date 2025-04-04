import 'package:flutter/material.dart';
import 'package:glitch_ai/constants/colors.dart';
import 'package:glitch_ai/constants/const.dart';
import 'package:glitch_ai/constants/images.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:iconsax/iconsax.dart';

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _controller = TextEditingController();
  List<Map<String, String>> messages = [];
  bool isTyping = false;

  Future<void> sendMessage(String message) async {
    setState(() {
      messages.add({'role': 'user', 'text': message});
      isTyping = true;
    });

    final response = await http.post(
      Uri.parse("https://api.openai.com/v1/chat/completions"),
      headers: {
        "Authorization": "Bearer $API_KEY",
        "Content-Type": "application/json",
      },
      body: jsonEncode({
        "model": "gpt-4o-mini",
        "messages": [
          {"role": "system", "content": "You are a helpful assistant."},
          {"role": "user", "content": message}
        ]
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      setState(() {
        messages.add({'role': 'ai', 'text': data['choices'][0]['message']['content']});
        isTyping = false;
      });
    } else {
      setState(() {
        messages.add({'role': 'ai', 'text': "Error fetching response!"});
        isTyping = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: AppColors.primaryGradient,
      ),
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          centerTitle: true,
          leading: Image.asset(AppImages.bot, width: 30, height: 50, color: AppColors.white),
          title: Text('GLITCH AI', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          backgroundColor: AppColors.black,
        ),
        body: Column(
          children: [
            Expanded(
              child: messages.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Image.asset(AppImages.bot, width: 150, height: 150, color: Colors.white,),
                          SizedBox(height: 20),
                          Text(
                            "Start chatting with Glitch AI",
                            style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    )
                  : ListView.builder(
                      padding: EdgeInsets.all(8.0),
                      itemCount: messages.length + (isTyping ? 1 : 0),
                      itemBuilder: (context, index) {
                        if (isTyping && index == messages.length) {
                          return Align(
                            alignment: Alignment.centerLeft,
                            child: Container(
                              padding: EdgeInsets.all(10),
                              margin: EdgeInsets.symmetric(vertical: 4),
                              decoration: BoxDecoration(
                                color: Colors.grey[300],
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Text("Glitch is typing...",
                                  style: TextStyle(color: Colors.black, fontStyle: FontStyle.italic)),
                            ),
                          );
                        }
                        final message = messages[index];
                        return Align(
                          alignment: message['role'] == 'user' ? Alignment.centerRight : Alignment.centerLeft,
                          child: Container(
                            padding: EdgeInsets.all(10),
                            margin: EdgeInsets.symmetric(vertical: 4),
                            decoration: BoxDecoration(
                              color: message['role'] == 'user' ? AppColors.primaryColor : Colors.grey[300],
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              message['text']!,
                              style: TextStyle(color: message['role'] == 'user' ? Colors.white : Colors.black),
                            ),
                          ),
                        );
                      },
                    ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 25),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[850],
                        borderRadius: BorderRadius.circular(15),
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: _controller,
                              style: TextStyle(color: Colors.white),
                              decoration: InputDecoration(
                                hintText: "Type a message",
                                hintStyle: TextStyle(color: Colors.grey[500]),
                                border: InputBorder.none,
                              ),
                              onChanged: (text) => setState(() {}),
                            ),
                          ),
                          if (_controller.text.isNotEmpty)
                            IconButton(
                              icon: Icon(Iconsax.direct_right, color: AppColors.white),
                              onPressed: () {
                                sendMessage(_controller.text);
                                _controller.clear();
                                setState(() {});
                              },
                            ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
