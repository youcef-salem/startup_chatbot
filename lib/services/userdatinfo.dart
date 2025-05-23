import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:startup_chatbot/services/save_data.dart';

class UserService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<Map<String, dynamic>?> getUserByUuid(String uid) async {
    try {
      final currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser == null) {
        throw Exception('Not authenticated. Please sign in first.');
      }

      print('Attempting to fetch user with UID: $uid'); // Debug log

      final querySnapshot =
          await _firestore
              .collection('Users')
              .where('uid', isEqualTo: uid)
              .get();

      if (querySnapshot.docs.isEmpty) {
        print('No document found for UID: $uid');
        return null;
      }

      print('Found user data: ${querySnapshot.docs.first.data()}'); // Debug log
      return querySnapshot.docs.first.data();
    } catch (e) {
      print('Error getting user data: $e');
      throw e;
    }
  }

  // Alternative: If you know the document ID matches the UUID
  Future<Map<String, dynamic>?> getUserByDocId(String uuid) async {
    try {
      // Direct document reference if the document ID is the UUID
      DocumentSnapshot documentSnapshot =
          await _firestore.collection('Users').doc(uuid).get();

      if (documentSnapshot.exists) {
        return documentSnapshot.data() as Map<String, dynamic>;
      } else {
        print('No user found with document ID: $uuid');
        return null;
      }
    } catch (e) {
      print('Error getting user by document ID: $e');
      throw e;
    }
  }

  // Example method to demonstrate data fetching
  Future<void> fetchAndHandleUserData(String uuid) async {
    try {
      // Using the first method (by UUID)
      final userData = await getUserByUuid(uuid);
      if (userData != null) {
        // Access specific fields from userData
        final String? name = userData['name'];
        final String? email = userData['email'];
        final String? address = userData['address'];
        final String? phone = userData['phone'];

        // Handle the data as needed
      }
    } catch (e) {
      print('Error fetching user data: $e');
    }
  }
}
