import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kopuro/models/user/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  SignUpCubit() : super(const SignUpState());

  Future<void> signUp({required String email, required String password}) async {
    emit(state.copyWith(isSubmitting: true, errorMessage: ''));
    try {
      final userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      await userCredential.user?.sendEmailVerification();
      emit(state.copyWith(
          isSubmitting: false, isSuccess: true, errorMessage: ''));
    } catch (e) {
      emit(state.copyWith(
          isSubmitting: false, errorMessage: e.toString(), isSuccess: false));
    }
  }

  void createStudent(Users user) async {
    try {
      final firestore = FirebaseFirestore.instance;
      await firestore.collection('users').doc(user.uid).set({
        'uid': user.uid,
        'createdTime': user.createdTime,
        'userType': user.userType,
        'email': user.email,
        'username': user.username,
        'phoneNumber': user.phoneNumber,
        'aboutUser': user.aboutUser,
        'jobTitle': user.jobTitle,
        'skills': user.skills,
        'userLocation': user.userLocation,
        'education': user.education,
        'workExperience': user.workExperience,
        'language': user.language,
        'linkedIn': user.linkedIn,
        'github': user.github,
        'photoUrl': user.photoUrl,
      });

      emit(state.copyWith(
        isSubmitting: false,
        isSuccess: true,
        errorMessage: '',
      ));
    } catch (e) {
      emit(state.copyWith(
        isSubmitting: false,
        isSuccess: false,
        errorMessage: e.toString(),
      ));
    }
  }
}
