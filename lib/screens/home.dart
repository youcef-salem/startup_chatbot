import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:startup_chatbot/screens/drawer.dart';
import 'package:uuid/uuid.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<types.Message> _messages = [];
  final types.User _user = const types.User(id: "user_id");
  final types.User _bot = const types.User(id: "bot_id");
  final TextEditingController _textController = TextEditingController();
  void handlesendpressed(types.PartialText message) async {
    final newMessage = types.TextMessage(
      id: Uuid().v4(),
      author: _user,
      text: message.text,
      createdAt: DateTime.now().millisecondsSinceEpoch,
    );
    setState(() {
      _messages.insert(0, newMessage);
    });
    Future.delayed(Duration(seconds: 1), () {
      final botMessage = types.TextMessage(
        id: Uuid().v4(),
        author: _bot,
        text: "Hello to startup chatbot: how can I help you today?",
        createdAt: DateTime.now().millisecondsSinceEpoch,
      );
      setState(() {
        _messages.insert(0, botMessage);
      });
    });
  }

  void _handleSubmit(String text) {
    if (text.trim().isNotEmpty) {
      handlesendpressed(types.PartialText(text: text));
      _textController.clear();
    }
  }

  void newchat() {
    // Save the messages of the old discussion

    // Clear the current messages to start a new chat
    setState(() {
      _messages.clear();
    });
  }

  @override
  void dispose() {
    _textController.dispose(); // Clean up controller
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    // Initialize any necessary data or state here
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: cuDrawer(), // Add this

      appBar: AppBar(
         automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Startup ',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 30,
              ),
            ),
           Builder(  // Wrap GestureDetector with Builder
      builder: (BuildContext context) => GestureDetector(
        child: Image.asset('assets/startup.png', height: 60, width: 90),
        onTap: () {
          Scaffold.of(context).openDrawer();
        },
      ),
    ),

            Text(
              ' Chatbot',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 30,
              ),
            ),
          ],
        ),
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 12, 51, 59),
      ),

      body: Container(
        color: Color.fromARGB(255, 17, 27, 26),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                reverse: true,
                itemCount: _messages.length,
                itemBuilder: (context, index) {
                  final message = _messages[index];
                  final isBot = message.author.id == _bot.id;

                  return Align(
                    alignment:
                        isBot ? Alignment.centerLeft : Alignment.centerRight,
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color:
                            isBot
                                ? Color.fromARGB(255, 35, 35, 53)
                                : const Color.fromARGB(255, 60, 91, 97),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          if (isBot) Icon(Icons.rocket, color: Colors.white),
                          if (isBot) SizedBox(width: 8),
                          Flexible(
                            child: Text(
                              (message as types.TextMessage).text,
                              style: TextStyle(
                                color: isBot ? Colors.white : Colors.white,
                                fontWeight:
                                    isBot ? FontWeight.normal : FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            GestureDetector(
              onTap: () => newchat(),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  
                  child: Container(
                    color: Color.fromARGB(255, 12, 51, 59),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'New Chat',
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                    
                        IconButton(
                          icon: Icon(Icons.add),
                          color: Colors.white,
                          onPressed: () => newchat(),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(8),
              color: Color.fromARGB(255, 12, 51, 59),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      constraints: BoxConstraints(
                        maxHeight: 120, // Maximum height before scrolling
                        minHeight: 40, // Minimum height
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.black12,
                      ),
                      child: TextField(
                        style: TextStyle(color: Colors.white),
                        controller: _textController,
                        maxLines: null, // Allow multiple lines
                        minLines: 1,
                        textInputAction: TextInputAction.newline,
                        decoration: InputDecoration(
                          hintText: 'Ask your Question',
                          hintStyle: TextStyle(color: Colors.white70),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide.none,
                          ),
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 22,
                          ),
                          filled: true,
                          fillColor: Colors.black12,
                          isCollapsed: true,
                        ),
                        onSubmitted: (text) {
                          if (text.trim().isNotEmpty) {
                            handlesendpressed(types.PartialText(text: text));
                          }
                        },
                      ),
                    ),
                  ),
                  SizedBox(width: 8),
                  Container(
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 73, 112, 120),
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      icon: Icon(Icons.rocket, color: Colors.white),
                      onPressed: () => _handleSubmit(_textController.text),
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
