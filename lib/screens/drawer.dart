import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:startup_chatbot/screens/History.dart';
import 'package:startup_chatbot/screens/about.dart';
import 'package:startup_chatbot/screens/acount.dart';
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
                        'Menue',
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
                      'Home',
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
                          'Logout',
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
                          'Login',
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
                      'Personal Information ',
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
                      'Contact startup ',
                      style: TextStyle(color: Colors.white),
                    ),
                    iconColor: Colors.white,
                    onTap: () {
                      webRoute.launchWebsite(webRoute.routes['contact']!);
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.history),
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
                    leading: const Icon(Icons.add),
                    title: const Text(
                      'plus dinformations',  
                      style: TextStyle(color: Colors.white),
                    ),
                    iconColor: Colors.white,),
                  ListTile(
                    leading: const Icon(Icons.inbox),
                    title: const Text(
                      'contact developeure  ',
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
                  ListTile(
                    leading: const Icon(Icons.info),
                    title: const Text(
                      'application infromation  ',
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
