
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  SignUpCubit() : super(const SignUpState());

  Future<void> signUp({
  required String email,
  required String password,
}) async {
  emit(state.copyWith(isSubmitting: true, errorMessage: ''));

  try {
    final userCredential = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );


    await userCredential.user?.sendEmailVerification();

    emit(state.copyWith(isSuccess: true, isSubmitting: false));
  } catch (e) {
    emit(state.copyWith(isSubmitting: false, errorMessage: e.toString()));
  }
}

}
