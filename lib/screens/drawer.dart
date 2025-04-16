import 'package:flutter/material.dart';

class cuDrawer extends StatelessWidget {
  const cuDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
   child: Scaffold(
     body: Container(
     
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/backg.png'),
            fit: BoxFit.cover, // 🔥 Makes it fullscreen
          ),
        ),
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.transparent,
            ),
          child: Row(
            children: [
              Text(
                  'Menu',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
                 Container(
                        decoration: BoxDecoration(shape: BoxShape.circle),
                        child: ClipOval(
                          child: Image.asset(
                            'assets/rocket.png',
                            width: 50,
                            height: 50,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
            ],
          ),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Home'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Settings'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
        ],
      )
     ),
   ),
    );
  }
}