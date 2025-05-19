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
      final credential = await fireauth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
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
