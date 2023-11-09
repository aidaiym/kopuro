import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:kopuro/models/user/user_model.dart' as CustomUser; 

@immutable
class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  AuthService();

  Future<CustomUser.User?> get init async { 
    try {
      User? user = _auth.currentUser;
      if (user != null) {
        return CustomUser.User( 
          accessToken: user.uid,
          username: user.displayName ?? user.email!,
          email: user.email!,
          photoUrl: '',
          uid: '',
          createdTime: DateTime.now(),
          phoneNumber: '',
          password: '',
          userType: 'Student',
        );
      }
      return null;
    } catch (e) {
      print("Error: $e");
      return null;
    }
  }

}
