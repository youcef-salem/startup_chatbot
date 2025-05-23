import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:startup_chatbot/services/save_data.dart';

class Auth with ChangeNotifier {
  final  FirebaseAuth fireauth = FirebaseAuth.instance;
  User? get curent_user => fireauth.currentUser;
  bool isLoggedIn = false;
  SaveData saveData = SaveData();

  // Initialize auth state from SharedPreferences
  Future<void> initAuthState() async {
    final prefs = await SharedPreferences.getInstance();
    isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
    notifyListeners();
  }

  // Sign in method with error handling
  Future<UserCredential?> signIn({
    required String email,
    required String password,
  }) async {
    try {
      final credential = await fireauth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Save auth state and user email
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isLoggedIn', true);
      await prefs.setString('userEmail', email);

      isLoggedIn = true;
      notifyListeners();
      return credential;
    } on FirebaseAuthException catch (e) {
      print('Code d\'erreur Firebase: ${e.code}');
      if (e.code == 'user-not-found') {
        throw 'Aucun utilisateur trouvé avec cet email.';
      } else if (e.code == 'wrong-password') {
        throw 'Mot de passe incorrect.';
      } else if (e.code == 'invalid-email') {
        throw 'Format d\'email invalide.';
      } else if (e.code == 'invalid-credential') {
        throw 'Échec de l\'authentification. Veuillez vérifier vos identifiants.';
      }
      throw e.message ?? 'Une erreur s\'est produite lors de la connexion';
    }
  }

  // Sign out method
  Future<void> signOut() async {
    await fireauth.signOut();

    // Clear stored auth data
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();

    isLoggedIn = false;
    notifyListeners();
  }

  // Check if user is authenticated
  Future<bool> isAuthenticated() async {
    final prefs = await SharedPreferences.getInstance();
    final storedEmail = prefs.getString('userEmail');

    if (fireauth.currentUser != null && storedEmail != null) {
      isLoggedIn = true;
      notifyListeners();
      return true;
    }

    // Clear stored data if Firebase auth is invalid
    await prefs.clear();
    isLoggedIn = false;
    notifyListeners();
    return false;
  }
}
