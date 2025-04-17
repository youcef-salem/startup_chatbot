import 'package:flutter/material.dart';

class About extends StatelessWidget {
  const About({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    body: 
         SafeArea(
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

            child: Center(

              child: Column(
              
                children: [
                   Container(
                              decoration: BoxDecoration(shape: BoxShape.circle),
                              child: ClipOval(
                                child: Image.asset(
                                  'assets/rocket.png',
                                  width: 120,
                                  height: 120,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                  SizedBox(height: 20),
                  
                  Container(
padding: EdgeInsets.all(13),
                    child: Text(
                      "This is a chatbot that can help you , in your startup problems related and also PFE . ",
                      style: TextStyle(color: Colors.white, fontSize: 36),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          )
          
          )

    );
  }
}