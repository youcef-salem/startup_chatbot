
  import 'package:firebase_auth/firebase_auth.dart';

class UserModel {
  final String uid;
  final String email;
  final String displayName;
  final String? photoUrl;
  final String? token;

  UserModel({
    required this.uid,
    required this.email,
    this.displayName = '',
    this.photoUrl,
    this.token,
  });

  // Create from Firebase User
  factory UserModel.fromFirebaseUser(User firebaseUser, {String? token}) {

    return UserModel(
      uid: firebaseUser.uid,
      email: firebaseUser.email ?? '',
      displayName: firebaseUser.displayName ?? '',
      photoUrl: firebaseUser.photoURL,
      token: token,
    );
  }

  // Convert to Map for SharedPreferences
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'displayName': displayName,
      'photoUrl': photoUrl,
      'token': token,
      'isLoggedIn': true,
    };
  }

  // Create from SharedPreferences Map
  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'] ?? '',
      email: map['email'] ?? '',
      displayName: map['displayName'] ?? '',
      photoUrl: map['photoUrl'],
      token: map['token'],
    );
  }
 get IdToken async {
    
     
    return token;
  }

}
  
