import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:startup_chatbot/model/conversation.dart';
import 'package:startup_chatbot/services/sql_manipulation.dart';

class History extends StatefulWidget {
  History({super.key});

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  SqlManipulation sqlManipulation = SqlManipulation();
  Map<String, List<types.Message>> _chatSessions = {};
  String? _expandedChatId;
  final types.User _user = const types.User(id: "user_id");
  final types.User _bot = const types.User(id: "bot_id");
  final types.User _newchat = const types.User(id: "new_chat");

  @override
  void initState() {
    super.initState();
    _loadMessages();
  }

  ondeleteConversation(String sessionId, List<types.Message> messages) async {
    // Delete a conversation based on the provided IDs
    try {
      await sqlManipulation.deleteConversation(messages);

      // Remove from local state immediately
      setState(() {
        _chatSessions.remove(sessionId);
        // If the deleted session was expanded, clear the expansion
        if (_expandedChatId == sessionId) {
          _expandedChatId = null;
        }
      });
    } catch (e) {
      print('Error deleting conversation: $e');
      // Optionally show a snackbar or dialog to inform user of error
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error deleting conversation: $e')),
      );
    }
  }

  Future<void> _loadMessages() async {
    try {
      final messages = await sqlManipulation.getConversations();

      // Group messages by chat sessions
      final sessions = <String, List<types.Message>>{};
      String? currentSessionId;
      List<types.Message> currentSession = [];

      for (var message in messages) {
        if (message.author.id == _newchat.id) {
          // If we find a new chat message, start a new session
          if (currentSessionId != null) {
            sessions[currentSessionId] = List.from(currentSession);
          }
          currentSessionId = message.id;
          currentSession = [message];
        } else {
          currentSession.add(message);
        }
      }
      // Add the last session
      if (currentSessionId != null) {
        sessions[currentSessionId] = List.from(currentSession);
      }

      setState(() {
        _chatSessions = sessions;
      });
    } catch (e) {
      print('Error loading messages: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_chatSessions.isEmpty) {
      return Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/backg.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'pas de messages',
              style: TextStyle(
                color: Colors.white,
                fontSize: 30,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.5,
                decoration: TextDecoration.none,

                shadows: [
                  Shadow(
                    color: Colors.black54,
                    offset: Offset(2, 2),
                    blurRadius: 5,
                  ),
                ],
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
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            itemCount: _chatSessions.length,
            itemBuilder: (context, index) {
              final sessionId = _chatSessions.keys.elementAt(index);
              final messages = _chatSessions[sessionId]!;
              final isExpanded = sessionId == _expandedChatId;

              return Column(
                children: [
                  // Chat Session Header
                  InkWell(
                    onTap: () {
                      setState(() {
                        _expandedChatId = isExpanded ? null : sessionId;
                      });
                    },
                    child: Container(
                      margin: EdgeInsets.symmetric(vertical: 8),
                      padding: EdgeInsets.all(16),
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
                      child: Slidable(
                        key: ValueKey(sessionId),
                        endActionPane: ActionPane(
                          motion: const ScrollMotion(),
                          children: [
                            SlidableAction(
                              onPressed: (_) async {
                                // Remove from local state first
                                setState(() {
                                  _chatSessions.remove(sessionId);
                                  if (_expandedChatId == sessionId) {
                                    _expandedChatId = null;
                                  }
                                });

                                // Then delete from database
                                try {
                                  await ondeleteConversation(
                                    sessionId,
                                    messages,
                                  );
                                } catch (e) {
                                  // If deletion fails, restore the session
                                  setState(() {
                                    _chatSessions[sessionId] = messages;
                                  });
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        'Failed to delete conversation',
                                      ),
                                      backgroundColor: Colors.red,
                                    ),
                                  );
                                }
                              },
                              backgroundColor: Color(0xFFFE4A49),
                              foregroundColor: Colors.white,
                              icon: Icons.delete,
                              label: 'Delete',
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ],
                        ),
                        child: Container(
                          padding: EdgeInsets.all(8),
                          child: Row(
                            children: [
                              Icon(
                                isExpanded
                                    ? Icons.expand_less
                                    : Icons.expand_more,
                                color: Colors.white,
                              ),
                              SizedBox(width: 10),
                              Text(
                                'Chat Session ${index + 1}',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  // Chat Messages (only shown when expanded)
                  if (isExpanded)
                    ...messages.map((message) {
                      if (message is types.TextMessage) {
                        final isBot = message.author.id == _bot.id;

                        // Your existing message UI code here
                        return isBot
                            ? _buildBotMessage(message)
                            : _buildUserMessage(message);
                      }
                      return SizedBox.shrink();
                    }).toList(),
                ],
              );
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await sqlManipulation.delete();
          _loadMessages();
        },
        backgroundColor: Color(0xFF00FF9B),
        child: Icon(Icons.delete_forever_rounded),
      ),
    );
  }

  Widget _buildBotMessage(types.TextMessage message) {
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
  }

  Widget _buildUserMessage(types.TextMessage message) {
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
  }
}
