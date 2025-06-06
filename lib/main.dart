import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:startup_chatbot/screens/home.dart';
import 'package:startup_chatbot/services/auth.dart';
import 'package:startup_chatbot/services/recordservice.dart';
import 'package:startup_chatbot/services/save_data.dart';

import 'firebase_options.dart';
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  final saveData = SaveData();
  await saveData.initializeLoginState();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => saveData),
        ChangeNotifierProvider(create: (_) => Auth()),
        ChangeNotifierProvider(create: (_) => Rec_service()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: MyHomePage(),
    );
  }
}

// This widget is the root of your application.
