import 'package:flutter/material.dart';
import 'package:my_money_flow/models/plata.dart';
import 'package:my_money_flow/models/user.dart';
import 'package:my_money_flow/providers/user_provider.dart';
import 'package:my_money_flow/services/ai_api_service.dart';
import 'package:provider/provider.dart';

class AiChatPage extends StatefulWidget {
  final List<Plata> plati;

  const AiChatPage({super.key, required this.plati});

  @override
  AiChatPageState createState() => AiChatPageState();
}

class AiChatPageState extends State<AiChatPage> {
  late final User? user;

  @override
  void initState() {
    super.initState();
    user = Provider.of<UserProvider>(context, listen: false).user;
  }

  final TextEditingController _controller = TextEditingController();
  final List<Map<String, String>> _messages = [
    {
      "role": "bot",
      "content":
          "Salut! Sunt MyMoneyFlow, asistentul tău financiar virtual. Cum te pot ajuta?"
    }
  ];

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
      appBar: AppBar(title: const Text("Asistentul Financiar AI")),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                bool isUser = message["role"] == "user";
                return Container(
                  alignment:
                      isUser ? Alignment.centerRight : Alignment.centerLeft,
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: isUser ? Colors.blue : Colors.green,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      message["content"]!,
                      style: TextStyle(
                          color: isUser ? Colors.white : Colors.black),
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        _controller.text =
                            "Care sunt cele mai bune practici pentru economisire?";
                      },
                      child: const Text(
                        "Economisire",
                        style:
                            TextStyle(color: Color.fromARGB(255, 19, 44, 49)),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        _controller.text = "Cum pot investi mai eficient?";
                      },
                      child: const Text("Investiții",
                          style: TextStyle(
                              color: Color.fromARGB(255, 19, 44, 49))),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        _controller.text =
                            "Cum să reduc cheltuielile lunare? Venitul meu lunar este de ${user?.venit}, iar procentele bugetelor sunt de ${user?.procentNevoi}% pentru nevoi, ${user?.procentDorinte}% pentru dorinte, ${user?.procentEconomi}% pentru economii. Acestea sunt platile mele: ${widget.plati.map((plata) => "\n${plata.categorie}: ${plata.descriere} ->${plata.suma} RON").join(", ")}";
                      },
                      child: const Text("Cheltuieli",
                          style: TextStyle(
                              color: Color.fromARGB(255, 19, 44, 49))),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _controller,
                        minLines: 1,
                        maxLines: 5,
                        decoration: const InputDecoration(
                          hintText: "Type your message...",
                          border: OutlineInputBorder(),
                        ),
                        keyboardType: TextInputType.multiline,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.send),
                      onPressed: () => _sendMessage(_controller.text),
                    ),
                  ],
                ),
              ])),
        ],
      ),
    );
  }
}
