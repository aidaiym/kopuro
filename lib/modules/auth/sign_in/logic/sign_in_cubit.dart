import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// ignore: library_prefixes
import 'package:kopuro/models/user/user_model.dart';

part 'sign_in_state.dart';

class SignInCubit extends Cubit<SignInState> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Users? get currentUser {
    if (_auth.currentUser == null) {
      return null;
    } else {
      return Users(
        uid: _auth.currentUser!.uid,
        createdTime: DateTime.now(),
        userType: 'defaultUserType',
        email: _auth.currentUser!.email!,
        username: '',
        phoneNumber: '',
        aboutUser: '',
        jobTitle: '',
        skills: '',
        userLocation: '',
        education: '',
        workExperience: '',
        language: '',
        linkedIn: '',
        github: '',
        photoUrl: '',
      );
    }
  }

  SignInCubit() : super(SignInInitial());

Future<void> signInWithEmailAndPassword(String email, String password) async {
  try {
    final userCredential = await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );

    DocumentSnapshot userSnapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(userCredential.user!.uid)
        .get();

    if (userSnapshot.exists && userSnapshot.data() != null) {
      Users signedInUser =
          Users.fromJson(userSnapshot.data()! as Map<String, dynamic>);
      emit(SignInSuccess(user: signedInUser));
    } else {
      emit(SignInFailure(error: 'User document does not exist or has no data'));
    }
  } catch (e) {
    emit(SignInFailure(error: e.toString()));
  }
}



  Future<void> signOut() async {
    await _auth.signOut();
    emit(SignInInitial());
  }
}
