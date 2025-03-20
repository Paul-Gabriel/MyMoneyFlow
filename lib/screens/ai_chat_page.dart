import 'package:flutter/material.dart';
import 'package:my_money_flow/services/ai_api_service.dart';

class AiChatPage extends StatefulWidget {
  const AiChatPage({super.key});

  @override
  _AiChatPageState createState() => _AiChatPageState();
}

class _AiChatPageState extends State<AiChatPage> {
  //final List<Map<String, String>> messages = [];
  final TextEditingController _controller = TextEditingController();
  final List<Map<String, String>> _messages = [];

  // void _sendMessage(String text) {
  //   if (text.isEmpty) return;
  //   setState(() {
  //     messages.add({"sender": "user", "text": text});
  //     // Simulate a response from AI
  //     messages.add({"sender": "ai", "text": "This is a response from AI"});
  //   });
  //   _controller.clear();
  // }

  // Future<void> _sendMessage(String text) async {
  //   String userMessage = _controller.text;
  //   if (userMessage.isEmpty) return;

  //   setState(() {
  //     _messages.add({"role": "user", "content": userMessage});
  //     _controller.clear();
  //   });

  //   String botResponse = await ApiService.sendMessage(userMessage);

  //   setState(() {
  //     _messages.add({"role": "bot", "content": botResponse});
  //   });
  // }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('AI Chat'),
//       ),
//       body: Column(
//         children: [
//           Expanded(
//             child: ListView.builder(
//               itemCount: _messages.length,
//               itemBuilder: (context, index) {
//                 final message = _messages[index];
//                 final isUserMessage = message['sender'] == 'user';
//                 return Align(
//                   alignment: isUserMessage ? Alignment.centerRight : Alignment.centerLeft,
//                   child: Container(
//                     margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
//                     padding: const EdgeInsets.all(10),
//                     decoration: BoxDecoration(
//                       color: isUserMessage ? Colors.blue[100] : Colors.grey[300],
//                       borderRadius: BorderRadius.circular(10),
//                     ),
//                     child: Text(message['text']!),
//                   ),
//                 );
//               },
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Row(
//               children: [
//                 Expanded(
//                   child: TextField(
//                     controller: _controller,
//                     decoration: InputDecoration(
//                       hintText: 'Type a message',
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(10),
//                       ),
//                     ),
//                   ),
//                 ),
//                 IconButton(
//                   icon: const Icon(Icons.send),
//                   onPressed: () => _sendMessage(_controller.text),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }









// void main() {
//   runApp(ChatApp());
// }

// class ChatApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: ChatScreen(),
//     );
//   }
// }

// class ChatScreen extends StatefulWidget {
//   @override
//   _ChatScreenState createState() => _ChatScreenState();
// }

// class _ChatScreenState extends State<ChatScreen> {
//   final TextEditingController _controller = TextEditingController();
//   final List<Map<String, String>> _messages = [];

  void _sendMessage() async {
    String userMessage = _controller.text;
    if (userMessage.isEmpty) return;

    setState(() {
      _messages.add({"role": "user", "content": userMessage});
      _controller.clear();
    });

    String botResponse = await AiApiService.sendMessage(userMessage);

    setState(() {
      _messages.add({"role": "bot", "content": botResponse});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("AI Chatbot")),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                bool isUser = message["role"] == "user";
                return Container(
                  alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
                  padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: isUser ? Colors.blue : Colors.grey[300],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      message["content"]!,
                      style: TextStyle(color: isUser ? Colors.white : Colors.black),
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: const InputDecoration(
                      hintText: "Type your message...",
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: _sendMessage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
