import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:startup_chatbot/Widget/rowcontact.dart';

import 'package:startup_chatbot/services/save_data.dart';
import 'package:startup_chatbot/services/userdatinfo.dart';

class Personal extends StatefulWidget {
  Personal({super.key});

  @override
  State<Personal> createState() => _PersonalState();
}

class _PersonalState extends State<Personal> {
  final UserService userService = UserService();

  String name = "";

  String email = "";

  String address = "";

  String phone = "";

  Map<String, dynamic>? userData;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    try {
      final sharedData = Provider.of<SaveData>(context, listen: false);
      final storedUid = await sharedData.getData('uid');
      print('Stored UID: $storedUid'); // Debug log

      if (storedUid == null) {
        throw Exception('No UID stored');
      }

      final userService = UserService();
      final userData = await userService.getUserByUuid(storedUid);

      if (userData != null) {
        setState(() {
          name = userData['name'] ?? '';
          email = userData['email'] ?? ''; // Note the colon
          address = userData['address'] ?? '';
          phone = userData['phone'] ?? '';
        });
      }
    } catch (e) {
      print('Error loading user data: $e');
    }
  }

  Future<void> fetchUserData(String uuid) async {
    try {
      // Assuming you have a way to get the UUID of the user
      // Replace with actual UUID
      userData = await userService.getUserByUuid(uuid);
      if (userData != null) {
        name = userData!['name'];
        print('Name    this is it : ${userData!['name']}');
        ;
        address = userData!['address'];
        phone = userData!['phone'];
      }
    } catch (e) {
      print('Error fetching user data: $e');
    }
  }

  Future<void> saveUserData(String uuid, Map<String, dynamic> data) async {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.teal.shade300, Colors.blue.shade500],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(bottom: 30, top: 50),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 15,
                        offset: Offset(0, 5),
                      ),
                    ],
                  ),
                  child: CircleAvatar(
                    radius: 70,
                    backgroundColor: Colors.white,
                    child: ClipOval(
                      child: Image.asset(
                        'assets/rocket.png',
                        width: 120,
                        height: 120,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Container(
               
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.9),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 20,
                        offset: Offset(0, 10),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      buildInfoRow(Icons.person, "Nom", name),
                      buildDivider(),
                      buildInfoRow(Icons.email, "Gmail", email),
                      buildDivider(),
                      buildInfoRow(Icons.location_on, "Adresse", address),
                      buildDivider(),
                      buildInfoRow(Icons.phone, "Numéro", phone),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildInfoRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child:  Row(
        
          children: [
            Icon(icon, color: Colors.teal, size: 28),
            SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 4),
                  
                     Text(
                      value,
                      maxLines: 2,
                      softWrap: true,
                 overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Colors.black87,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                   
                  ),
                ],
              ),
            ),
          ],
        ),
      
    );
  }
}
