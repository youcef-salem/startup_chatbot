import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:startup_chatbot/screens/History.dart';
import 'package:startup_chatbot/screens/about.dart';
import 'package:startup_chatbot/screens/acount.dart';
import 'package:startup_chatbot/screens/contact.dart';
import 'package:startup_chatbot/screens/persoanl.dart';
import 'package:startup_chatbot/services/Web_route.dart';
import 'package:startup_chatbot/services/save_data.dart';

class cuDrawer extends StatelessWidget {
  cuDrawer({super.key});
  final WebRoute webRoute = WebRoute();
  @override
  Widget build(BuildContext context) {
    final sharedData = Provider.of<SaveData>(context);
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
                  decoration: BoxDecoration(color: Colors.transparent),
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
                    title: const Text(
                    'Accueil',
                    style: TextStyle(color: Colors.white),
                    ),
                    iconColor: Colors.white,
                    onTap: () {
                    Navigator.pop(context);
                    },
                    ),
                  
                  sharedData.getBoolData() == true
                    ? ListTile(
                    leading: const Icon(Icons.logout),
                    title: const Text(
                      'Déconnexion',
                      style: TextStyle(color: Colors.white),
                    ),
                    iconColor: Colors.white,
                    onTap: () {
                      sharedData.setBoolData(false);
                      sharedData.removeData('uid');
                      
                      sharedData.remove_auth(); 

                      Navigator.pop(context);
                    },
                    )
                    : ListTile(
                     
                    leading: const Icon(Icons.login),
                    title: const Text(
                      'Connexion',
                      style: TextStyle(color: Colors.white),
                    ),
                    iconColor: Colors.white,
                    onTap: () {
                      Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Acount()),
                      );
                    },
                    ),

                  ListTile(
                    leading: const Icon(Icons.contact_page_rounded),
                    title: const Text(
                      ' Information  Personnelle', 
                      style: TextStyle(color: Colors.white),
                    ),
                    iconColor: Colors.white,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Personal()),
                      );
                    },
                  ),

                  ListTile(
                    leading: const Icon(Icons.support_agent),
                    title: const Text(
                      'Contact startup Hall ',
                      style: TextStyle(color: Colors.white),
                    ),
                    iconColor: Colors.white,
                    onTap: () {
                      webRoute.launchWebsite('contact');
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.archive_rounded),
                    title: const Text(
                      'Historique',
                      style: TextStyle(color: Colors.white),
                    ),
                    iconColor: Colors.white,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => History()),
                      );
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.web),
                    title: const Text(
                      'Notre site ',  
                      style: TextStyle(color: Colors.white),
                    ),
                    iconColor: Colors.white,
                    onTap: () {
                     WebRoute().launchWebsite('more');
                    },
                    
                    ),
                  ListTile(
                    leading: const Icon(Icons.inbox),
                    title: const Text(
                      '  Nos  contact  ',
                      style: TextStyle(color: Colors.white),
                    ),
                    iconColor: Colors.white,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Contact()),
                      );
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.info),
                    title: const Text(
                      ' À Propos ',
                      style: TextStyle(color: Colors.white),
                    ),
                    iconColor: Colors.white,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => About()),
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
