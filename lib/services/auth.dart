import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Auth with ChangeNotifier {
  final FirebaseAuth fireauth = FirebaseAuth.instance;
  User? get curent_user => fireauth.currentUser;
  bool isLoggedIn = false;
  // Sign in method
  Future<UserCredential> signIn({
    required String email,
    required String password,
  }) async {
    return await fireauth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
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
