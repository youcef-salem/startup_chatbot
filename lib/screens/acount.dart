import 'package:flutter/material.dart';

class Acount extends StatefulWidget {
   Acount({super.key});

  @override
  State<Acount> createState() => _AcountState();
}

class _AcountState extends State<Acount> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
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
            child: Container(
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
                      border: Border.all(color: Colors.white, width: 2),
                      borderRadius: BorderRadius.circular(25),
                      color: Colors.black
                    ),
                            child: TextField(
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
                      border: Border.all(color: Colors.white, width: 2),
                      borderRadius: BorderRadius.circular(25),
                      color: const Color.fromARGB(255, 3, 6, 5)
                    ),
                            child: TextField(
                            decoration: InputDecoration(
                              
                              hintText: 'Password',
                              hintStyle: TextStyle(color: Colors.white),
                              border: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              focusedBorder: InputBorder.none,
                            ),
                            style: TextStyle(color: Colors.white , ),
                            ),
                        ),
                      ],
                    ),
                  ) ,
                  SizedBox(height: 30),
                   Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                     children: [
                      
                       Container(
                        width: 150,
                        padding: EdgeInsets.all(16),
                        margin: EdgeInsets.only(bottom: 60 ),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.white, width: 2),
                          borderRadius: BorderRadius.circular(50),
                          color: const Color.fromARGB(255, 227, 75, 48)
                        ),
                        child: Center(
                          child: GestureDetector(
                            
                            onTap: () {
                              // Handle sign-in action
                            
                              
                            },
                            child: Text(
                              'Sign In',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                                         ),
                      SizedBox(width: 10),
                                         Container(
                                          
                    width: 150,
                    padding: EdgeInsets.all(16),
                    margin: EdgeInsets.only(bottom: 60 ),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white, width: 2),
                      borderRadius: BorderRadius.circular(50),
                      color: const Color.fromARGB(255, 44, 15, 123)
                    ),
                    child: Center(
                      child: GestureDetector(
                        
                        onTap: () {
                          // Handle sign-in action
                          
                        },
                        child: Text(
                          'Register',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  )
                     ],
                   )
                ],
              ),
            ),
          ),
        ),
      );
    
  }
}
