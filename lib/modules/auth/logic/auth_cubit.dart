import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kopuro/export_files.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthService _authService = AuthService();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  AuthCubit() : super(AuthInitialState());

  Future<Users?> getCurrentUser() async {
    try {
      User? user = _auth.currentUser;
      if (user != null) {
        Users? userDetails = await getUserDetailsFromFirestore(user.uid);
        return userDetails;
      }
      return null;
    } catch (e) {
      print('Error getting current user: $e');
      return null;
    }
  }

  Future<Users?> getUserDetailsFromFirestore(String uid) async {
    try {
      DocumentSnapshot<Map<String, dynamic>> userDoc =
          await FirebaseFirestore.instance.collection('users').doc(uid).get();

      if (userDoc.exists) {
        return Users.fromJson(userDoc.data()!);
      } else {
        print('User details not found in Firestore for UID: $uid');
        return null;
      }
    } catch (e) {
      print('Error fetching user details from Firestore: $e');
      return null;
    }
  }

    Future<void> logOut() async {
    try {
      await _authService.signOut();
      emit(AuthSignedOutState());
    } catch (e) {
      emit(AuthErrorState('Failed to log out. Please try again later.'));
    }
  }
  Future<void> signIn(AuthEvent event) async {
    try {
      if (event is SignInEvent) {
        emit(AuthLoadingState());
        User? user = await _authService.signInWithEmailAndPassword(
          event.email,
          event.password,
        );
        if (user != null) {
          emit(AuthSignedInState(user));
          emit(AuthSignInSuccessState(user));
        } else {
          emit(AuthErrorState(
            'Failed to sign in. Please check your credentials.',
          ));
        }
      } else {
        emit(AuthErrorState('Invalid event type'));
      }
    } catch (e) {
      emit(AuthErrorState('Failed to sign in. Please try again later.'));
    }
  }

  Future<void> signUpAsStudent(
      String email, String password, StudentUser student) async {
    try {
      User? user = (await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      )) as User?;

      student = student.copyWith(
        id: user?.uid,
        createdTime: DateTime.now(),
        type: UserType.student,
      );
      await saveUser(student);

      emit(AuthSignedInState(user!));
    } catch (e) {
      emit(AuthErrorState('Failed to sign up as student. Please try again later.'));
    }
  }

  Future<void> signUpAsCompany(
      String email, String password, CompanyUser company) async {
    try {
      User? user = (await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      )) as User?;

      company = company.copyWith(
        id: user?.uid,
        createdTime: DateTime.now(),
        type: UserType.company,
      );
      await saveUser(company);

      emit(AuthSignedInState(user!));
    } catch (e) {
      emit(AuthErrorState('Failed to sign up as company. Please try again later.'));
    }
  }

  Future<void> saveUser(Users user) async {
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(user.id)
          .set(user.toJson());
    } catch (e) {
      print('Error saving user to Firestore: $e');
    }
  }

  Future<void> signUp(AuthEvent event) async {
    try {
      if (event is SignUpStudentEvent) {
        emit(AuthLoadingState());
        await signUpAsStudent(
          event.email,
          event.password,
          event.user,
        );
      } else if (event is SignUpCompanyEvent) {
        emit(AuthLoadingState());
        await signUpAsCompany(
          event.email,
          event.password,
          event.user,
        );
      } else {
        emit(AuthErrorState('Invalid event type'));
      }
    } catch (e) {
      emit(AuthErrorState('Failed to sign up. Please try again later.'));
    }
  }
}

