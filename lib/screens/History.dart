import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:startup_chatbot/model/conversation.dart';
import 'package:startup_chatbot/services/sql_manipulation.dart';

class History extends StatefulWidget {
  History({super.key});

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  SqlManipulation sqlManipulation = SqlManipulation();
  List<types.Message> _messages = [];
  final types.User _user = const types.User(id: "user_id");
  final types.User _bot = const types.User(id: "bot_id");
final types.User _newchat = const types.User(id: "new_chat");
  @override
  void initState() {
    super.initState();
    _loadMessages(); // Load messages when screen initializes
  }

  // Load messages from database
  Future<void> _loadMessages() async {
    try {
      print('Loading messages from database...'); // Debug log
      final messages = await sqlManipulation.getConversations();
      print('Loaded ${messages.length} messages'); // Debug log

      setState(() {
        _messages = messages;
      });
    } catch (e) {
      print('Error loading messages: $e');
    }
  }

  // Refresh messages when tapped
  void _refreshMessages() async {
    await _loadMessages();
  }

  @override
  Widget build(BuildContext context) {
    if (_messages.isEmpty) {
      return Container(
         decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/backg.png'),
            fit: BoxFit.cover, // 🔥 Makes it fullscreen
          ),
        ),
        //return  message  not recordesd text
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              ' pas de messages',
              style: TextStyle(color: Colors.white, fontSize: 30
             ,textBaseline: null, decoration: TextDecoration.none, fontWeight: FontWeight.bold, letterSpacing: 1.5, shadows: [
                Shadow(
                  color: Colors.black54,
                  offset: Offset(2, 2),
                  blurRadius: 5,
                ),
              ]
              ),
              
            ),
            Container(
              margin: EdgeInsets.only(bottom: 30, top: 50),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 15,
                    offset: Offset(0, 5),
                  ),
                ],
              ),
              child: CircleAvatar(
                radius: 70,
                backgroundColor: Colors.white,
                child: ClipOval(
                  child: Image.asset(
                    'assets/rocket.png',
                    width: 120,
                    height: 120,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }
    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/backg.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: ListView.builder(
            padding: EdgeInsets.symmetric(horizontal: 15),
            itemCount: _messages.length,
            itemBuilder: (context, index) {
              final message = _messages[index];
              if (message is types.TextMessage) {
                // Add type check
                final isBot = message.author.id == _bot.id;
                final isUser = message.author.id == _user.id;
                final isNewChat = message.author.id == _newchat.id;
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
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                ),
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
                            message.text,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              decoration: TextDecoration.none,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }  else if (isUser) {
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
                         
                          child: Text(
                            message.text,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              decoration: TextDecoration.none,
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                  // User message (minimal or not shown in the screenshot)
                }else if(isNewChat){
                  return Padding(
                    padding: EdgeInsets.only(bottom: 15, top: 15 ),
                    child: Align(
                      alignment: Alignment.center,
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
                         
                          child: Text(
                            message.text,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              decoration: TextDecoration.none,
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                } else {
                  // Handle other message types if needed
                  return SizedBox.shrink();

                }
              }
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          sqlManipulation.delete(); 
          _refreshMessages(); // Refresh messages after deletion
          // Refresh messages on button press
        },
        backgroundColor: Color(0xFF00FF9B),
        child: Icon(Icons.delete_forever_rounded),
      ),
    );
  }
}
