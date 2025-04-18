import 'package:dialog_flowtter/dialog_flowtter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:provider/provider.dart';
import 'package:startup_chatbot/Widget/snackbare.dart';
import 'package:startup_chatbot/screens/drawer.dart';
import 'package:startup_chatbot/services/ChatService.dart';
import 'package:startup_chatbot/services/recordservice.dart';
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
  final TextEditingController _textController = TextEditingController();
  final Rec_service rec_service = Rec_service();
  final String text = '';
  String respond = '';

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
    Future.delayed(Duration(seconds: 1), () {
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
    });
  }

  void _handleSubmit(String text) {
    if (text.trim().isNotEmpty) {
      handlesendpressed(types.PartialText(text: text));
      _textController.clear();
    }
    if (_messages.length > 4) {
      setState(() {
        newchatvisible = true;
      });
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
    rec_service.initilasation();
    _textController.addListener(updateicon);
    // Initialize any necessary data or state here
  }

  void updateicon() {
    setState(() {
      txtinputforion = _textController.text.toString();
    });
  }

  Future<void> _initSpeechService() async {
    await rec_service.requestPermission();
    bool isAvailable = await rec_service.initilasation();
    if (isAvailable) {
      setState(() {
        pemisionrequest = true;
      });
    }
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
    final rec_serv = Provider.of<Rec_service>(context);

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
                                (message as types.TextMessage).text,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
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
                                  if (_textController.text.isEmpty) {
                                    value.startListening(_updateTextcontrol);
                                    Snackshow(
                                      context,
                                      true,
                                    ); // Show Snackbar when starting to listen
                                  } else {
                                    _handleSubmit(_textController.text);
                                  }
                                },
                                onLongPressUp: () {
                                  if (_textController.text.isEmpty) {
                                    value.stopListening();
                                    Snackshow(
                                      context,
                                      false,
                                    ); // Hide Snackbar when stopping
                                  } else {
                                    _handleSubmit(_textController.text);
                                  }
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
