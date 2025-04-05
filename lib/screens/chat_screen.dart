// // ignore_for_file: use_key_in_widget_constructors, library_private_types_in_public_api

// import 'package:flutter/material.dart';
// import 'package:glitch_ai/constants/colors.dart';
// import 'package:glitch_ai/constants/const.dart';
// import 'package:glitch_ai/constants/images.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import 'package:iconsax/iconsax.dart';

// class ChatScreen extends StatefulWidget {
//   @override
//   _ChatScreenState createState() => _ChatScreenState();
// }

// class _ChatScreenState extends State<ChatScreen> {
//   final TextEditingController _controller = TextEditingController();
//   final ScrollController _scrollController = ScrollController();
//   List<Map<String, String>> messages = [];
//   bool isTyping = false;
//   String aiTypingText = "";

//   Future<void> sendMessage(String message) async {
//     setState(() {
//       messages.add({'role': 'user', 'text': message});
//       isTyping = true;
//       aiTypingText = "";
//     });
//     scrollToBottom();

//     final response = await http.post(
//       Uri.parse("https://api.openai.com/v1/chat/completions"),
//       headers: {
//         "Authorization": "Bearer $API_KEY",
//         "Content-Type": "application/json",
//       },
//       body: jsonEncode({
//         "model": "gpt-4o-mini",
//         "messages": [
//           {"role": "system", "content": "You are a helpful assistant."},
//           {"role": "user", "content": message}
//         ]
//       }),
//     );

//     if (response.statusCode == 200) {
//       final data = jsonDecode(response.body);
//       final aiResponse = data['choices'][0]['message']['content'];

//       for (int i = 0; i < aiResponse.length; i++) {
//         await Future.delayed(Duration(milliseconds: 25));
//         setState(() {
//           aiTypingText += aiResponse[i];
//         });
//         scrollToBottom(); // ⬇ Keep scrolling while typing
//       }

//       setState(() {
//         messages.add({'role': 'ai', 'text': aiTypingText});
//         aiTypingText = "";
//         isTyping = false;
//       });

//       scrollToBottom(); // 🔚 Final scroll to bottom
//     } else {
//       setState(() {
//         messages.add({'role': 'ai', 'text': "Error fetching response!"});
//         aiTypingText = "";
//         isTyping = false;
//       });
//       scrollToBottom();
//     }
//   }

//   void scrollToBottom() {
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       if (_scrollController.hasClients) {
//         _scrollController.animateTo(
//           _scrollController.position.maxScrollExtent,
//           duration: Duration(milliseconds: 300),
//           curve: Curves.easeOut,
//         );
//       }
//     });
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     _scrollController.dispose(); // ✅ Dispose controller
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//         gradient: AppColors.primaryGradient,
//       ),
//       child: Scaffold(
//         backgroundColor: Colors.black,
//         appBar: AppBar(
//           automaticallyImplyLeading: false,
//           centerTitle: true,
//           leading: Image.asset(AppImages.bot, width: 30, height: 50, color: AppColors.white),
//           title: Text('GLITCH AI', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
//           backgroundColor: AppColors.black,
//         ),
//         body: Column(
//           children: [
//             Expanded(
//               child: messages.isEmpty
//                   ? Center(
//                       child: Column(
//                         mainAxisSize: MainAxisSize.min,
//                         children: [
//                           Image.asset(AppImages.bot, width: 150, height: 150, color: Colors.white),
//                           SizedBox(height: 20),
//                           Text(
//                             "Start chatting with Glitch AI",
//                             style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w500),
//                           ),
//                         ],
//                       ),
//                     )
//                   : ListView.builder(
//                       controller: _scrollController, // 💡 Linked to scroll
//                       padding: EdgeInsets.all(8.0),
//                       itemCount: messages.length + (isTyping ? 1 : 0),
//                       itemBuilder: (context, index) {
//                         if (isTyping && index == messages.length) {
//                           return Align(
//                             alignment: Alignment.centerLeft,
//                             child: Container(
//                               padding: EdgeInsets.all(10),
//                               margin: EdgeInsets.symmetric(vertical: 4),
//                               decoration: BoxDecoration(
//                                 color: Colors.grey[300],
//                                 borderRadius: BorderRadius.circular(10),
//                               ),
//                               child: Text(
//                                 aiTypingText,
//                                 style: TextStyle(color: Colors.black),
//                               ),
//                             ),
//                           );
//                         }

//                         final message = messages[index];
//                         return Align(
//                           alignment: message['role'] == 'user' ? Alignment.centerRight : Alignment.centerLeft,
//                           child: Container(
//                             padding: EdgeInsets.all(10),
//                             margin: EdgeInsets.symmetric(vertical: 4),
//                             decoration: BoxDecoration(
//                               color: message['role'] == 'user' ? AppColors.primaryColor : Colors.grey[300],
//                               borderRadius: BorderRadius.circular(10),
//                             ),
//                             child: Text(
//                               message['text']!,
//                               style: TextStyle(color: message['role'] == 'user' ? Colors.white : Colors.black),
//                             ),
//                           ),
//                         );
//                       },
//                     ),
//             ),
//             Padding(
//               padding: EdgeInsets.symmetric(horizontal: 20, vertical: 25),
//               child: Row(
//                 children: [
//                   Expanded(
//                     child: Container(
//                       decoration: BoxDecoration(
//                         color: Colors.grey[850],
//                         borderRadius: BorderRadius.circular(15),
//                       ),
//                       padding: EdgeInsets.symmetric(horizontal: 10),
//                       child: Row(
//                         children: [
//                           Expanded(
//                             child: TextField(
//                               controller: _controller,
//                               style: TextStyle(color: Colors.white),
//                               decoration: InputDecoration(
//                                 hintText: "Type a message",
//                                 hintStyle: TextStyle(color: Colors.grey[500]),
//                                 border: InputBorder.none,
//                               ),
//                               onChanged: (text) => setState(() {}),
//                             ),
//                           ),
//                           if (_controller.text.isNotEmpty)
//                             IconButton(
//                               icon: Icon(Iconsax.direct_right, color: AppColors.white),
//                               onPressed: () {
//                                 sendMessage(_controller.text);
//                                 _controller.clear();
//                                 setState(() {});
//                               },
//                             ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// ignore_for_file: use_key_in_widget_constructors, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:glitch_ai/constants/colors.dart';
import 'package:glitch_ai/constants/const.dart';
import 'package:glitch_ai/constants/images.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:iconsax/iconsax.dart';
import 'package:lottie/lottie.dart';

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  List<Map<String, String>> messages = [];
  bool isTyping = false;
  String aiTypingText = "";

  Future<void> sendMessage(String message) async {
    setState(() {
      messages.add({'role': 'user', 'text': message});
      isTyping = true;
      aiTypingText = "";
    });
    scrollToBottom();

    // Convert local messages to OpenAI format
    List<Map<String, String>> openAIMessages = [
      {"role": "system", "content": "You are a helpful assistant."},
      ...messages.map(
        (msg) => {
          "role": msg['role'] == 'user' ? 'user' : 'assistant',
          "content": msg['text']!,
        },
      ),
    ];

    final response = await http.post(
      Uri.parse("https://api.openai.com/v1/chat/completions"),
      headers: {
        "Authorization": "Bearer $API_KEY",
        "Content-Type": "application/json",
      },
      body: jsonEncode({"model": "gpt-4o-mini", "messages": openAIMessages}),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final aiResponse = data['choices'][0]['message']['content'];

      for (int i = 0; i < aiResponse.length; i++) {
        await Future.delayed(Duration(milliseconds: 25));
        setState(() {
          aiTypingText += aiResponse[i];
        });
        scrollToBottom();
      }

      setState(() {
        messages.add({'role': 'ai', 'text': aiTypingText});
        aiTypingText = "";
        isTyping = false;
      });

      scrollToBottom();
    } else {
      setState(() {
        messages.add({'role': 'ai', 'text': "Error fetching response!"});
        aiTypingText = "";
        isTyping = false;
      });
      scrollToBottom();
    }
  }

  void scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(gradient: AppColors.primaryGradient),
      child: Scaffold(
        drawer: Drawer(),
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          centerTitle: true,
          leading: Builder(
            builder:
                (context) => GestureDetector(
                  onTap: () {
                    Scaffold.of(context).openDrawer(); // ✅ Correct context
                  },
                  child: Image.asset(
                    AppImages.menu,
                    width: 10,
                    height: 20,
                    color: AppColors.white,
                  ),
                ),
          ),
          title: Text(
            'GLITCH AI',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          backgroundColor: AppColors.transparent,
        ),
        body: Column(
          children: [
            Expanded(
              child:
                  messages.isEmpty
                      ? Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            // Image.asset(AppImages.bot, width: 150, height: 150, color: Colors.white),
                            Lottie.asset("assets/animations/bot_welcome.json"),
                            SizedBox(height: 20),
                            Text(
                              "Hello! this is Glitch AI",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      )
                      : ListView.builder(
                        controller: _scrollController,
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
                                child: Text(
                                  aiTypingText,
                                  style: TextStyle(color: Colors.black),
                                ),
                              ),
                            );
                          }

                          final message = messages[index];
                          return Align(
                            alignment:
                                message['role'] == 'user'
                                    ? Alignment.centerRight
                                    : Alignment.centerLeft,
                            child: Container(
                              padding: EdgeInsets.all(10),
                              margin: EdgeInsets.symmetric(vertical: 4),
                              decoration: BoxDecoration(
                                color:
                                    message['role'] == 'user'
                                        ? Colors.grey.shade900
                                        : Colors.grey[300],
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Text(
                                message['text']!,
                                style: TextStyle(
                                  color:
                                      message['role'] == 'user'
                                          ? Colors.white
                                          : Colors.black,
                                ),
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
                              icon: Icon(
                                Iconsax.direct_right,
                                color: AppColors.white,
                              ),
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
