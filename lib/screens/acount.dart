
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
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/backg.png'),
              fit: BoxFit.cover,
              // 🔥 Makes it fullscreen
            ),
          ),
          child: Consumer<Auth>(
            builder:
                (context, value, child) => Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        child: Column(
                          children: [
                            Container(
                              width: 320,
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.white,
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(25),
                                color: Colors.transparent,
                              ),
                              child: TextField(
                                controller: emailController,
                                decoration: InputDecoration(
                                  hintText: 'Email',
                                  hintStyle: TextStyle(color: Colors.white),
                                  border: InputBorder.none,
                                  enabledBorder: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                ),
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                            SizedBox(height: 25),
                            Container(
                              width: 320,
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.white,
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(25),
                                color:Colors.transparent,
                              ),
                              child: TextField(
                                controller: passwordController,
                                decoration: InputDecoration(
                                  hintText: 'Password',
                                  hintStyle: TextStyle(color: Colors.white),
                                  border: InputBorder.none,
                                  enabledBorder: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                ),
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 30),
                    Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 250,
                            padding: EdgeInsets.all(16),
                            margin: EdgeInsets.only(bottom:20),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.white, width: 2),
                              borderRadius: BorderRadius.circular(25),
                              color: const Color.fromARGB(255, 20, 32, 31),
                            ),
                            child: Center(
                              child: GestureDetector(
                                onTap: () async {
                                  try {
                                    final credential = await value.signIn(
                                      email: emailController.text.trim(),
                                      password: passwordController.text.trim(),
                                    );
                                    if (credential != null) {
                                      print("Sign in successful");
                                      // Navigate to home or show success message
                                    }
                                  } catch (e) {
                                    // Show error to user
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(e.toString()),
                                        backgroundColor: Colors.red,
                                      ),
                                    );
                                  }
                                },
                                child: Consumer<Auth>(
                                  builder: (
                                    BuildContext context,
                                    Auth value,
                                    Widget? child,
                                  ) {
                                    return value.isLoggedIn == false
                                        ? Text(
                                          'Sign In',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        )
                                        : Text(
                                          value.curent_user?.uid.toString() ??
                                              '',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        );
                                  },
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 10,),
                          Container(
                           
                            padding: EdgeInsets.all(0),
                            margin: EdgeInsets.only(bottom: 60),
                            decoration: BoxDecoration(
                             
                              color: Colors.transparent,
                            ),
                            child: Center(
                              child: GestureDetector(
                                onTap: () {
                                  // Handle sign-in action
                                  route.launchWebsite('register');
                                },
                                child: Text(
                                  'you do not have an acount ? ',
                                  style: TextStyle(
                                    color: const Color.fromARGB(255, 193, 193, 193),
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
          ),
        ),
      ),
    );
  }
}
