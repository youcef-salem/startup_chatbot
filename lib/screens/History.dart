import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;

class History extends StatefulWidget {
  History({super.key});

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  // Test messages for demonstration
  void _addTestMessages() {
    setState(() {
      _messages.addAll([
        types.TextMessage(author: _user, id: '1', text: 'Helloay?'),
        types.TextMessage(
          author: _bot,
          id: '1',
          text: 'Hello! How can I help you today?',
        ),
        types.TextMessage(
          author: _user,
          id: '2',
          text: 'I have a question about startups',
        ),
        types.TextMessage(
          author: _bot,
          id: '3',
          text:
              'Of course! I\'d be happy to help you with any startup-related questions.',
        ),
      ]);
    });
  }

  final List<types.Message> _messages = [];

  final types.User _user = const types.User(id: "user_id");

  final types.User _bot = const types.User(id: "bot_id");

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GestureDetector(
        onTap: () => _addTestMessages(),
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/backg.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: Expanded(
            child: ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: 15),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                final isBot = message.author.id == _bot.id;
      
                if (isBot) {
                  // Bot message layout
                  return Padding(
                    padding: EdgeInsets.only(bottom: 15),
                    child: Container(
                      width: double.infinity,
                      constraints: BoxConstraints(
                        maxWidth: MediaQuery.of(context).size.width * 0.85,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.4),
                        borderRadius: BorderRadius.circular(25),
                        border: Border.all(
                          color: Color(0xFF00FF9B).withOpacity(0.3),
                          width: 1,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Color(0xFF00FF9B).withOpacity(0.1),
                            blurRadius: 10,
                            spreadRadius: 1,
                          ),
                        ],
                      ),
                      padding: EdgeInsets.all(16),
                      margin: EdgeInsets.only(right: 50),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                decoration: BoxDecoration(shape: BoxShape.circle),
                                child: ClipOval(
                                  child: Image.asset(
                                    'assets/rocket.png',
                                    width: 50,
                                    height: 50,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              SizedBox(width: 10),
                            ],
                          ),
                          SizedBox(height: 8),
                          Text(
                            message is types.TextMessage
                                ? message.text
                                : 'Unsupported message type',
                            style: TextStyle(color: Colors.white, fontSize: 18
                            ,decoration: TextDecoration.none
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                } else {
                  return Padding(
                    padding: EdgeInsets.only(bottom: 15),
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: IntrinsicWidth(
                        child: Container(
                          constraints: BoxConstraints(
                            maxWidth: MediaQuery.of(context).size.width * 0.7,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.4),
                            borderRadius: BorderRadius.circular(25),
                            border: Border.all(
                              color: Color(0xFF00FF9B).withOpacity(0.3),
                              width: 1,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Color(0xFF00FF9B).withOpacity(0.1),
                                blurRadius: 10,
                                spreadRadius: 1,
                              ),
                            ],
                          ),
                          padding: EdgeInsets.all(16),
                          margin: EdgeInsets.only(left: 50),
                          child: Text(
                            message is types.TextMessage
                                ? message.text
                                : 'Unsupported message type',
                            style: TextStyle(color: Colors.white, fontSize: 18,
                            decoration: TextDecoration.none
                            ),
                            
                          ),
                        ),
                      ),
                    ),
                  );
                  // User message (minimal or not shown in the screenshot)
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
