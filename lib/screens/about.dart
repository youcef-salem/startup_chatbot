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
                   
                  SizedBox(height:40),
                  Text(
                    "{About}",
                    style: TextStyle(
                      color: const Color.fromARGB(255, 225, 218, 218),
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      
                    ),
                  ),
                  SizedBox(height:40),
                  
                  Container(
                    decoration: BoxDecoration(
                      color:  Color.fromARGB(0, 203, 210, 207),
                      
                      borderRadius: BorderRadius.circular(50),
                    ),
padding: EdgeInsets.all(13),

                    child: Text(
                      "This is a chatbot that can help you , in your startup problems related and also PFE . ",
                      style: TextStyle(color: const Color.fromARGB(255, 255, 255, 255
                      
                      ), 
                      
                      fontSize: 20
                      
                      ),
                      
                      textAlign: TextAlign.center,

                    ),
                  ),
                  SizedBox(height: 20),
                  Container(
                              decoration: BoxDecoration(shape: BoxShape.circle),
                              child: ClipOval(
                                child: Image.asset(
                                  'assets/rocket.png',
                                  width: 200,
                                  height: 200,
                                  fit: BoxFit.cover,
                                ),
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