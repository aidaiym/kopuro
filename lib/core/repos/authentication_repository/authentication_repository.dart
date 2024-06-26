import 'dart:async';
import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:kopuro/export_files.dart';

class SignUpWithEmailAndPasswordFailure implements Exception {
  const SignUpWithEmailAndPasswordFailure([
    this.message = 'An unknown exception occurred.',
  ]);

  factory SignUpWithEmailAndPasswordFailure.fromCode(String code) {
    switch (code) {
      case 'invalid-email':
        return const SignUpWithEmailAndPasswordFailure(
          'Email is not valid or badly formatted.',
        );
      case 'user-disabled':
        return const SignUpWithEmailAndPasswordFailure(
          'This user has been disabled. Please contact support for help.',
        );
      case 'email-already-in-use':
        return const SignUpWithEmailAndPasswordFailure(
          'An account already exists for that email.',
        );
      case 'operation-not-allowed':
        return const SignUpWithEmailAndPasswordFailure(
          'Operation is not allowed.  Please contact support.',
        );
      case 'weak-password':
        return const SignUpWithEmailAndPasswordFailure(
          'Please enter a stronger password.',
        );
      default:
        return const SignUpWithEmailAndPasswordFailure();
    }
  }

  final String message;
}

class LogInWithEmailAndPasswordFailure implements Exception {
  const LogInWithEmailAndPasswordFailure([
    this.message = 'An unknown exception occurred.',
  ]);

  factory LogInWithEmailAndPasswordFailure.fromCode(String code) {
    switch (code) {
      case 'invalid-email':
        return const LogInWithEmailAndPasswordFailure(
          'Email is not valid or badly formatted.',
        );
      case 'user-disabled':
        return const LogInWithEmailAndPasswordFailure(
          'This user has been disabled. Please contact support for help.',
        );
      case 'user-not-found':
        return const LogInWithEmailAndPasswordFailure(
          'Email is not found, please create an account.',
        );
      case 'wrong-password':
        return const LogInWithEmailAndPasswordFailure(
          'Incorrect password, please try again.',
        );
      default:
        return const LogInWithEmailAndPasswordFailure();
    }
  }

  final String message;
}

class LogOutFailure implements Exception {}

class AuthenticationRepository {
  AuthenticationRepository({
    CacheClient? cache,
    firebase_auth.FirebaseAuth? firebaseAuth,
    FirebaseFirestore? firestore,
  })  : _cache = cache ?? CacheClient(),
        _firebaseAuth = firebaseAuth ?? firebase_auth.FirebaseAuth.instance;

  final CacheClient _cache;
  final firebase_auth.FirebaseAuth _firebaseAuth;

  bool isWeb = kIsWeb;

  static const userCacheKey = '__user_cache_key__';

  Stream<User> get user {
    return _firebaseAuth
        .authStateChanges()
        .asyncMap<User>((firebaseUser) async {
      if (firebaseUser == null) {
        _cache.write(key: userCacheKey, value: User.empty);
        return User.empty;
      } else {
        final user = await getUserFromFirestore(firebaseUser.uid);
        _cache.write(key: userCacheKey, value: user);
        return user;
      }
    });
  }

  User get currentUser {
    return _cache.read<User>(key: userCacheKey) ?? User.empty;
  }

  Future<void> signUp({
    required String email,
    required String password,
    required bool isStudent,
  }) async {
    try {
      final firebase_auth.UserCredential userCredential =
          await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      final firebase_auth.User? user = userCredential.user;
      if (user != null) {
        if (isStudent) {
          StudentUser student = StudentUser(
            id: user.uid,
            email: user.email ?? '',
            createdTime: DateTime.now(),
          );

          Map<String, dynamic> studentMap = student.toMapStudent();
          await FirebaseFirestore.instance
              .collection('users')
              .doc(user.uid)
              .set(studentMap, SetOptions(merge: true));
          MaterialPageRoute(builder: (context) => const ResumeBuilder());
        } else {
          CompanyUser company = CompanyUser(
            id: user.uid,
            email: user.email ?? '',
            createdTime: DateTime.now(),
            userType: UserType.company,
          );

          Map<String, dynamic> companyMap = company.toMap();
          await FirebaseFirestore.instance
              .collection('users')
              .doc(user.uid)
              .set(companyMap, SetOptions(merge: true));
        }
        MaterialPageRoute(builder: (context) => const CompanyProfileBuilder());
      }
    } on firebase_auth.FirebaseAuthException catch (e) {
      throw SignUpWithEmailAndPasswordFailure.fromCode(e.code);
    } catch (_) {
      throw const SignUpWithEmailAndPasswordFailure();
    }
  }

  Future<void> logInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on firebase_auth.FirebaseAuthException catch (e) {
      throw LogInWithEmailAndPasswordFailure.fromCode(e.code);
    } catch (_) {
      throw const LogInWithEmailAndPasswordFailure();
    }
  }

  Future<void> logOut() async {
    try {
      await Future.wait([
        _firebaseAuth.signOut(),
      ]);
    } catch (_) {
      throw LogOutFailure();
    }
  }
}

Future<User> getUserFromFirestore(String userId) async {
  try {
    final userDoc =
        await FirebaseFirestore.instance.collection('users').doc(userId).get();
    if (userDoc.exists) {
      final userData = userDoc.data() as Map<String, dynamic>;
      final userTypeString = userData['userType'] as String;
      final userType = userTypeFromString(userTypeString);
      return User(
        id: userId,
        email: userData['email'] ?? '',
        userType: userType,
      );
    } else {
      return User.empty;
    }
  } catch (e) {
    log('Error fetching user data: $e');
    rethrow;
  }
}

UserType userTypeFromString(String userTypeString) {
  switch (userTypeString) {
    case 'UserType.student':
      return UserType.student;
    case 'UserType.company':
      return UserType.company;
    default:
      return UserType.student;
  }
}
