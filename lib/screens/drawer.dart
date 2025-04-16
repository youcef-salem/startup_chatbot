import 'package:flutter/material.dart';
import 'package:startup_chatbot/screens/acount.dart';
import 'package:startup_chatbot/services/Web_route.dart';

class cuDrawer extends StatelessWidget {
  cuDrawer({super.key});
final WebRoute webRoute = WebRoute();
  @override
  Widget build(BuildContext context) {
    return Drawer(
   child: Scaffold(
     body: Container(
  
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/backg.png'),
            fit: BoxFit.cover, 
            // 🔥 Makes it fullscreen
          ),
        ),
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          Container(
            height: 150,
            child: DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.transparent,
                
              ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                
                    
                    Text(
                        'Menu',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
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
            ),
            ),
          ),
          Column(
            children: [
            ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Home',style: TextStyle(color: Colors.white),),
             iconColor: Colors.white,
            onTap: () {
              Navigator.pop(context);
            },
          ),
         ListTile(
            leading: const Icon(Icons.person),
            title: const Text('Acount',style: TextStyle(color: Colors.white),),
             iconColor: Colors.white,
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => Acount()));
            },
          ),
          ListTile(
            leading: const Icon(Icons.contact_page_rounded),
            title: const Text('Personal Information ',style: TextStyle(color: Colors.white),),
             iconColor: Colors.white,
            onTap: () {
              Navigator.pop(context);
            },
          ),
          
          ListTile(
            leading: const Icon(Icons.support_agent),
            title: const Text('Contact Us ',style: TextStyle(color: Colors.white),),
             iconColor: Colors.white,
            onTap: () {
              webRoute.launchWebsite(webRoute.routes['contact']!);
            },
          )
          ,ListTile(
            leading: const Icon(Icons.question_mark_rounded),
            title: const Text('About App ',style: TextStyle(color: Colors.white),),
             iconColor: Colors.white,
            onTap: () {
            
            },
          ),
            ],
          )
          
        ],
      )
     ),
   ),
    );
  }
}