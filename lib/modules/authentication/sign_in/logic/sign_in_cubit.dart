import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignInCubit extends Cubit<User?> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  SignInCubit() : super(null);

  void signInWithEmailAndPassword(String email, String password) async {
    try {
      final userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      emit(userCredential.user);
    } catch (e) {
      emit(null);
    }
  }

  void signOut() async {
    await _auth.signOut();
    emit(null);
  }
}
