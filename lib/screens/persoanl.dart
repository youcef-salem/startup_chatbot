import 'package:flutter/material.dart';
import 'package:startup_chatbot/Widget/Rowdata.dart';

class Personal extends StatelessWidget {
  const Personal({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     body: SafeArea(
          child: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/backg.png'),
                fit: BoxFit.cover,
              ),
            ),
            
            child:Column(
              children: [
                 Container(
                  margin: EdgeInsets.only(bottom: 50,top: 50),
                  decoration: BoxDecoration(shape: BoxShape.circle),
                  child: ClipOval(
                    child: Image.asset(
                      'assets/rocket.png',
                      width: 130,
                      height: 130,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 30),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Rowdata(rec: "name", data: "youcef"),
                      Rowdata(rec: "name", data: "youcef salem hhh"),
                      Rowdata(rec: "name", data: "youcef")
                    ],
                  ),
                ),
              ],
            ),
          )
    ),
    );
  }
}
