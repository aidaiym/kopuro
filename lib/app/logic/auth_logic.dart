import 'package:firebase_auth/firebase_auth.dart';

class AuthBloc {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  User? get currentUser => _auth.currentUser;

}

final authBloc = AuthBloc();
