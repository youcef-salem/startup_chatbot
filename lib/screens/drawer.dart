import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
class cuDrawer extends StatelessWidget {
  const cuDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
    backgroundColor: Color.fromARGB(255, 12, 51, 59),
     
         
           child: Column(
           children: [
            Padding(
           padding: const EdgeInsets.only(top: 50,left: 15),
           child: 
             Row( children: [Text(
                'Startup ',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                ),
              ),
           
              Image.asset('assets/startup.png', height: 40, width: 40),
              Text(
                ' Chatbot',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                ),
              )],),
            
           
            ),
            // Figma Flutter Generator Androidcompact1Widget - FRAME
      
           
           ])
            
         
    );
  }
}