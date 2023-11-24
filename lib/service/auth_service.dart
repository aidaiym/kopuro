import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:kopuro/export_files.dart';


class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<User?> signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user;
    } catch (e) {
      print('Error signing in: $e');
      return null;
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }

  Future<User?> signUpAsAdmin(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      AdminUser admin = AdminUser(id: userCredential.user?.uid ?? '', username: '', email: '', createdTime: DateTime.now());
      await saveUser(admin);
      return userCredential.user;
    } catch (e) {
      print('Error signing up as an admin: $e');
      return null;
    }
  }

  Future<User?> signUpAsCompany(String email, String password, CompanyUser company) async {
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      company = company.copyWith(id: userCredential.user?.uid, createdTime: DateTime.now());
      await saveUser(company);

      return userCredential.user;
    } catch (e) {
      print('Error signing up as a company: $e');
      return null;
    }
  }

  Future<User?> signUpAsStudent(String email, String password, StudentUser student) async {
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      student = student.copyWith(id: userCredential.user?.uid, createdTime: DateTime.now());
      await saveUser(student);

      return userCredential.user;
    } catch (e) {
      print('Error signing up as a student: $e');
      return null;
    }
  }

Future<void> saveUser(Users user) async {
  try {
    await FirebaseFirestore.instance.collection('users').doc(user.id).set(user.toJson());
  } catch (e) {
    print('Error saving user to Firestore: $e');
    // throw AuthErrorState('Failed to save user data. Please try again later.');
  }
}

}
