import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:startup_chatbot/services/save_data.dart';

class UserService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<Map<String, dynamic>?> getUserByUuid(String uid) async {
    try {
      print('Attempting to fetch user with UID: $uid'); // Debug log

      // Get the authenticated user's UID
      final currentUser = _auth.currentUser;
      if (currentUser == null) {
        throw Exception('Not authenticated');
      }

      // Query using the document ID directly instead of 'uid:' field
      final docSnapshot =
          await _firestore
              .collection('Users')
              .where(
                'uid', // Use the field name 'uid' instead of 'uid:'
                isEqualTo: currentUser.uid,
              ) // Use the Firebase Auth UID as document ID
              .get();
if (docSnapshot.docs.isNotEmpty) {
        final userData = docSnapshot.docs.first.data();
        print('User data fetched successfully: $userData'); // Debug log
        return userData;
      } else {
        print('No user found with UID: $uid'); // Debug log
        return null;
      }
    } catch (e) {
      print('Error fetching user data: $e'); // Debug log
      return null;
    }
  }
}
