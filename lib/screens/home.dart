import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:provider/provider.dart';
import 'package:startup_chatbot/Widget/snackbare.dart';
import 'package:startup_chatbot/model/conversation.dart';
import 'package:startup_chatbot/screens/drawer.dart';
import 'package:startup_chatbot/services/ChatService.dart';
import 'package:startup_chatbot/services/recordservice.dart';
import 'package:startup_chatbot/services/sql_manipulation.dart';
import 'package:uuid/uuid.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool newchatvisible = false;
  bool animationapear = false;
  bool pemisionrequest = false;
  String txtinputforion = '';
  ChatService chatsevice = ChatService();
  final List<types.Message> _messages = [];
  final types.User _user = const types.User(id: "user_id");
  final types.User _bot = const types.User(id: "bot_id");
  final types.User _newchat = const types.User(id: "new_chat");
  final TextEditingController _textController = TextEditingController();
  final Rec_service rec_service = Rec_service();
  final String text = '';
  String respond = '';
  SqlManipulation sqlManipulation = SqlManipulation();

  void handlesendpressed(types.PartialText message) async {
    final newMessage = types.TextMessage(
      id: Uuid().v4(),
      author: _user,
      text: message.text,
      createdAt: DateTime.now().millisecondsSinceEpoch,
    );
    setState(() {
      _messages.insert(0, newMessage);
      animationapear = true;
    });
    respond = await chatsevice.sendMessage(message.text);

    final botMessage = types.TextMessage(
      id: Uuid().v4(),
      author: _bot,
      text: respond,
      createdAt: DateTime.now().millisecondsSinceEpoch,
    );
    setState(() {
      _messages.insert(0, botMessage);
      animationapear = false;
    });
  }

  void _handleSubmit(String text) {
    if (text.trim().isNotEmpty) {
      handlesendpressed(types.PartialText(text: text));
      _textController.clear();
    }
    if (_messages.length >= 2) {
      setState(() {
        newchatvisible = true;
      });
    }
  }

  void newchat() {
    // Create a copy of messages to iterate over
    final messagesToSave = List<types.Message>.from(_messages);
sqlManipulation.InsertConversation(
          ChatMessge(
            id: '${Uuid().v4()}',
            text: ' La  discussion  dans : ${DateTime.now() }',
            author: _newchat , // Placeholder for new chat,
          ),
        );
    // Save messages to database
    for (var message in messagesToSave.reversed) {
      if (message is types.TextMessage) {
        if (message.author.id == _bot.id) {
          // Only save bot messages
          print('Saving message to database:  boot ${message.text}'); // Debug log
        }else {
          print('Saving user message to database: human ${message.text}'); // Debug log
        }
        sqlManipulation.InsertConversation(
          ChatMessge(
            id: message.id,
            text: message.text,
            author: message.author,
          ),
        );
      }
    }
    


    // Clear messages after saving
    setState(() {
      _messages.clear();
      newchatvisible = false;
    });
  }

  @override
  void dispose() {
    _textController.dispose();
    sqlManipulation.dispose();
    // Clean up controller
    super.dispose();
  }

  void updateicon() {
    setState(() {
      txtinputforion = _textController.text.toString();
    });
  }

  @override
  void initState() {
    super.initState();
    rec_service.initilasation();
    _textController.addListener(updateicon);
    sqlManipulation.initDatabase();
    // Initialize any necessary data or state here
  }

  

  void _updateTextcontrol(String newText) {
    setState(() {
      _textController.text = newText;
    });
  }

  void Snackshow(BuildContext context, bool show) {
    if (show) {
      ScaffoldMessenger.of(context)
        ..removeCurrentSnackBar()
        ..showSnackBar(CustumSnackbare(context: context).show());
    } else {
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
    }
  }

  @override
  Widget build(BuildContext context) {
 

    return Scaffold(
      // Remove drawer to match the screenshot
      drawer: cuDrawer(),
      body: Container(
        // Create the dark blue gradient background
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/backg.png'),
            fit: BoxFit.cover, // 🔥 Makes it fullscreen
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              _messages.isEmpty
                  ? Row(
                    children: [
                      Container(
                        margin: EdgeInsets.all(30),
                        child: Text(
                          ' Bienvenue \n dans  \n Notre App !   ',
                          style: TextStyle(
                            fontSize: 30,
                            color: Color.fromARGB(255, 231, 231, 231),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(shape: BoxShape.circle),
                        child: ClipOval(
                          child: Image.asset(
                            'assets/rocket.png',
                            width: 90,
                            height: 90,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ],
                  )
                  : Container(),
              Expanded(
                child: ListView.builder(
                  reverse: true,
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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

                                  Container(
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                    ),
                                    child: ClipOval(
                                      child: IconButton(
                                        icon: Icon(
                                          Icons.copy,
                                          color: Color(0xFF00FF9B),
                                        ),
                                        onPressed: () {
                                          FlutterClipboard.copy(
                                            (message as types.TextMessage).text,
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 8),
                              Text(
                                (message as types.TextMessage).text,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                ),
                              ),
                              //new chat button
                              
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
                                maxWidth:
                                    MediaQuery.of(context).size.width * 0.7,
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
                                (message as types.TextMessage).text,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
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
              if (newchatvisible)
                                TextButton(
                                  onPressed: () {
                                    newchat();
                                    setState(() {
                                      newchatvisible = false;
                                    });
                                  },
                                  child: Text(
                                    'Nouvelle discussion',
                                    style: TextStyle(
                                      color: Color(0xFF00FF9B),
                                      fontSize: 16,
                                    ),
                                  ),
                                ),

              // Input field section
              Padding(
                padding: EdgeInsets.only(
                  left: 15,
                  right: 15,
                  bottom: 16,
                  top: 3,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.4),
                          borderRadius: BorderRadius.circular(30),
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
                        child: TextField(
                          // Remove the nested Expanded
                          minLines: 1,
                          maxLines: 5,
                          controller: _textController,
                          style: TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            hintText: 'Posez votre question',
                            hintStyle: TextStyle(
                              color: Color(0xFF00FF9B).withOpacity(0.5),
                            ),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    Consumer<Rec_service>(
                      builder: (
                        BuildContext context,
                        Rec_service value,
                        Widget? child,
                      ) {
                        return Column(
                          children: [
                            Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.4),
                                shape: BoxShape.circle,
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
                              child: GestureDetector(
                                  onLongPress: () {
                                    value.startListening(_updateTextcontrol);
                                    Snackshow(
                                      context,
                                      true,
                                    ); // Show Snackbar when starting to listen
                                  },
                                  onLongPressUp: () {
                                    value.stopListening();
                                    Snackshow(
                                      context,
                                      false,
                                    ); // Ensure Snackbar hides when stopping
                                  },
                                
                          
                                child: IconButton(
                                  icon: Icon(
                                    _textController.text.isNotEmpty
                                        ? Icons.send
                                        : Icons.mic,
                                    color: Color(0xFF00FF9B),
                                  ),
                                  onPressed:
                                      () => _handleSubmit(_textController.text),
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
