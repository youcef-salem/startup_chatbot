import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:startup_chatbot/services/save_data.dart';

class Auth with ChangeNotifier {
  final FirebaseAuth fireauth = FirebaseAuth.instance;
  User? get curent_user => fireauth.currentUser;
  bool isLoggedIn = false;
SaveData saveData = SaveData();
  // Sign in method with error handling
  Future<UserCredential?> signIn({
    required String email,
    required String password,
  }) async {
    try {
      // Remove setPersistence as it's not needed for mobile
      final credential = await fireauth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      saveData.saveData('uid', credential.user!.uid);
      saveData.saveData('email', credential.user!.email!);
      saveData.saveData('displayName', credential.user!.displayName ?? '');
      saveData.saveData('isLoggedIn', true.toString());
      // Optionally save the token if needed
      String? token = await credential.user?.getIdToken();
      if (token != null) {
        saveData.saveData('token', token);
      }
 

      // Store login state in SharedPreferences
      

      isLoggedIn = true;
      notifyListeners();
      return credential;
    } on FirebaseAuthException catch (e) {
      print('Firebase Auth Error Code: ${e.code}'); // Debug print
      if (e.code == 'user-not-found') {
        throw 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        throw 'Wrong password provided for that user.';
      } else if (e.code == 'invalid-email') {
        throw 'Invalid email format.';
      } else if (e.code == 'invalid-credential') {
        throw 'Authentication failed. Please check your credentials.';
      }
      throw e.message ?? 'An error occurred during sign in';
    }
  }

  // Sign out method
  Future<void> signOut() async {
    // Implement sign-out logic here
    await fireauth.signOut();
    isLoggedIn = false;
    notifyListeners();
  }
  

  // Check if user is authenticated
  Future<bool> isAuthenticated() async {
    // Implement authentication check logic here
    if (fireauth.currentUser != null) {
      isLoggedIn = true;
      notifyListeners();
      return true;
    } else {
      return false;
    }
   
  }
}
