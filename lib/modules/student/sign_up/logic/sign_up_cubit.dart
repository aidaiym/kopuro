import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  SignUpCubit() : super(const SignUpState());

  Future<void> signUp({
    required String email,
    required String password,
    required String name,
    required String dateOfBirth,
    required String education,
    required String skills,
    String? linkedin,
    String? github,
    String? about,
  }) async {
    emit(state.copyWith(isSubmitting: true, errorMessage: ''));

    try {
      final authResult = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (authResult.user != null) {
        await _firestore.collection('users').doc(authResult.user!.uid).set({
          'name': name,
          'dateOfBirth': dateOfBirth,
          'education': education,
          'skills': skills,
          'linkedin': linkedin ?? '',
          'github': github ?? '',
          'about': about ?? '',
        });
      }

      emit(state.copyWith(isSuccess: true, isSubmitting: false));
    } catch (e) {
      emit(state.copyWith(isSubmitting: false, errorMessage: e.toString()));
    }
  }
}
