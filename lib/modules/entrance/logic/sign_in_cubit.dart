import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:kopuro/app/services/auth_service.dart';
part 'sign_in_state.dart';


class SignInCubit extends Cubit<SignInState> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  SignInCubit(this.service) : super(const SignInInitial());
 final AuthService service;
  Future<void> signInWithEmailAndPassword(String email, String password) async {
    try {
      final userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      emit(SignInSuccess(user: userCredential.user!));
    } catch (e) {
      emit(SignInFailure(error: e.toString()));
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
    emit(const SignInInitial());
  }
}
