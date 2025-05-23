import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:startup_chatbot/model/Userfire.dart';

class SaveData with ChangeNotifier {
  final prefs = SharedPreferences.getInstance();
  bool _isLoggedIn = false; // Add this local variable

  bool get isLoggedIn => _isLoggedIn; // Add this getter

  Future<void> initializeLoginState() async {
    final prefs = await SharedPreferences.getInstance();
    _isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
    notifyListeners();
  }

  Future<String?> getUuid(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('uid');
  }

  Future<void> setBoolData(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', value);
    _isLoggedIn = value;
    notifyListeners();
  }

  bool getBoolData() {
    // Remove async
    return _isLoggedIn;
  }

  Future<void> saveData(String key, String value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, value);
    notifyListeners();
  }

  Future<String?> getData(String key) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
  }

  Future<void> removeData(String key) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(key);
  }

  Future<String> get_key() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('key') ?? '';
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

  Future<void> remove_auth() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.remove('uid');
    await prefs.remove('email');
    await prefs.remove('displayName');
    await prefs.remove('photoUrl');
    await prefs.remove('isLoggedIn');
    notifyListeners();
  }
}
