import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:startup_chatbot/services/Web_route.dart';
import 'package:startup_chatbot/services/auth.dart';

class Acount extends StatefulWidget {
  Acount({super.key});

  @override
  State<Acount> createState() => _AcountState();
}

class _AcountState extends State<Acount> {
  WebRoute route = WebRoute();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                labelText: 'Adresse Email',
                hintText: 'Entrez votre email',
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Mot de passe',
                hintText: 'Entrez votre mot de passe',
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                try {
                  await context.read<Auth>().signIn(
                    email: emailController.text.trim(),
                    password: passwordController.text.trim(),
                  );
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(SnackBar(content: Text('Connexion réussie')));
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(e.toString()),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              },
              child: Text('Se connecter'),
            ),
          ],
        ),
      ),
    );
  }
}
