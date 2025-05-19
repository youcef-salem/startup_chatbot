
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:startup_chatbot/model/Userfire.dart';

class SaveData    with ChangeNotifier {
  final prefs = SharedPreferences.getInstance();
  Future<void> saveData(String key, String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, value);

  }

  Future<String?> getData(String key) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
  }

  Future<void> removeData(String key) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(key);
  }

  Future<void> Save_auth() async {
    Future<void> saveAuthData(UserModel user) async {
      final prefs = await SharedPreferences.getInstance();

      // Save user data
      await prefs.setString('uid', user.uid);
      await prefs.setString('email', user.email ?? '');
      await prefs.setString('displayName', user.displayName ?? '');
      await prefs.setString('photoUrl', user.photoUrl ?? '');
      await prefs.setBool('isLoggedIn', true);
     
      // Optionally save the token if needed
      String? token = await user.IdToken();
      if (token != null) {
        await prefs.setString('token', token);
      }
      notifyListeners();
    }
  }

}
