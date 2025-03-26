import 'package:flutter/material.dart';
import 'package:my_money_flow/models/plata.dart';
import 'package:my_money_flow/services/ai_api_service.dart';

class AiChatPage extends StatefulWidget {
  final List<Plata> plati;
  
  const AiChatPage({super.key, required this.plati});

  @override
  AiChatPageState createState() => AiChatPageState();
}

class AiChatPageState extends State<AiChatPage> {
  final TextEditingController _controller = TextEditingController();
  final List<Map<String, String>> _messages = [];

  void _sendMessage(String userMessage) async {
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
            child: Column(
              children: [
                Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          onPressed: () => _sendMessage("Care sunt cele mai bune practici pentru economisire?"),
                          child: const Text("Economisire"),
                        ),
                        ElevatedButton(
                          onPressed: () => _sendMessage("Cum pot investi mai eficient?"),
                          child: const Text("Investiții"),
                        ),
                        ElevatedButton(
                          onPressed: () => _sendMessage("Cum să reduc cheltuielile lunare? Acestea sunt platile mele: ${widget.plati.map((plata) => "\n${plata.categorie}: ${plata.descriere} ->${plata.suma} RON").join(", ")}"),
                          child: const Text("Cheltuieli"),
                        ),
                      ],
                    ),
                Row(
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
                      onPressed: () => _sendMessage(_controller.text),
                    ),
                  ],
                ),
              ]
            )
          ),
        ],
      ),
    );
  }
}
