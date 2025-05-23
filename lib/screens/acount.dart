import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:startup_chatbot/services/Web_route.dart';
import 'package:startup_chatbot/services/auth.dart';
import 'package:startup_chatbot/services/save_data.dart';

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
    final sharedData = Provider.of<SaveData>(context);
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.teal.shade300, Colors.blue.shade500],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
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
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.9),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 20,
                        offset: Offset(0, 10),
                      ),
                    ],
                  ),
                  child: Consumer<Auth>(
                    builder:
                        (context, value, child) => Column(
                          children: [
                            buildInputField(
                              Icons.email,
                              "Email",
                              emailController,
                              false,
                            ),
                            buildDivider(),
                            buildInputField(
                              Icons.lock,
                              "Mot de passe",
                              passwordController,
                              true,
                            ),
                            SizedBox(height: 30),
                            buildLoginButton(context, value, sharedData),
                            buildDivider(),
                            buildRegisterLink(),
                          ],
                        ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildInputField(
    IconData icon,
    String hint,
    TextEditingController controller,
    bool isPassword,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Column(
        children: [
          Row(
            children: [
              Icon(icon, color: Colors.teal, size: 28),
              SizedBox(width: 15),
              Expanded(
                child: TextField(
                  controller: controller,
                  obscureText: isPassword,
                  decoration: InputDecoration(
                    hintText: hint,
                    hintStyle: TextStyle(color: Colors.grey[600], fontSize: 16),
                    border: InputBorder.none,
                  ),
                  style: TextStyle(
                    color: Colors.black87,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildLoginButton(
    BuildContext context,
    Auth value,
    SaveData sharedData,
  ) {
    return Container(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        onPressed: () async {
          try {
            final credential = await value.signIn(
              email: emailController.text.trim(),
              password: passwordController.text.trim(),
            );
            if (credential != null) {
              await sharedData.setBoolData(true);
              await sharedData.saveData('email', emailController.text.trim());
              
              await sharedData.saveData(
                'password',
                passwordController.text.trim(),
              );
              await sharedData.saveData('uid', credential.user!.uid);
              print( "this is credential   ${credential.user!.uid}");

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Bienvenue ${emailController.text.trim()}'),
                  backgroundColor: Colors.teal,
                ),
              );

              await Future.delayed(Duration(seconds: 2));
              Navigator.pop(context);
            }
          } catch (e) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(e.toString()),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.teal,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
          elevation: 5,
        ),
        child: Text(
          'Se connecter',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget buildRegisterLink() {
    return TextButton(
      onPressed: () {
        WebRoute().launchWebsite('register');
      },
      child: Text(
        'Créer un nouveau compte',
        style: TextStyle(
          color: Colors.teal,
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget buildDivider() {
    return Divider(color: Colors.grey[300], thickness: 1, height: 20);
  }
}
