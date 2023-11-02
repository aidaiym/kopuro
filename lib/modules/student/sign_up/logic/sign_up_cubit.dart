import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:kopuro/modules/modules.dart';
import 'package:kopuro/modules/student/sign_up/view/resume_builder.dart';

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

      // Wait for email verification
      await userCredential.user?.sendEmailVerification();

      emit(state.copyWith(
          isSubmitting: false, isSuccess: true, errorMessage: ''));
    } catch (e) {
      emit(state.copyWith(
          isSubmitting: false, errorMessage: e.toString(), isSuccess: false));
    }
  }

  Future<void> checkEmailVerification(BuildContext context) async {
    final user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      try {
        // Don't reload the user here
        if (user.emailVerified) {
          // Navigate to the resume screen
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const ResumeBuilder()),
          );
        } else {
          // Navigate to the login screen
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const SignUpStudentView()),
          );
        }
      } catch (e) {
        emit(state.copyWith(
            isSubmitting: false,
            isSuccess: false,
            errorMessage: 'Error: ${e.toString()}'));
      }
    } else {
      // Handle the case where the user is not authenticated.
      emit(state.copyWith(
          isSubmitting: false,
          isSuccess: false,
          errorMessage: 'User not authenticated.'));
    }
  }
}
