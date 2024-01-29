import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileInitialState());

  Future<void> fetchUserData(String uid) async {
    try {
      Map<String, dynamic> data = await getUserData(uid);
      emit(ProfileSuccessState(userData: data));
    } catch (e) {
      emit(ProfileErrorState('Error fetching user data: $e'));
      log('Error fetching user data: $e');
    }
  }

  Future<void> updateUserData(
      String uid, Map<String, dynamic> updatedData) async {
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .update(updatedData);
      Map<String, dynamic> updatedUserData = await getUserData(uid);
      emit(ProfileSuccessState(userData: updatedUserData));
    } catch (e) {
      // emit(HomeErrorState('Error updating user data: $e'));
      log('Error updating user data: $e');
    }
  }

  Future<Map<String, dynamic>> getUserData(String uid) async {
    try {
      DocumentSnapshot userSnapshot =
          await FirebaseFirestore.instance.collection('users').doc(uid).get();

      if (userSnapshot.exists) {
        return userSnapshot.data() as Map<String, dynamic>;
      } else {
        return {};
      }
    } catch (e) {
      log('Error fetching user data: $e');
      return {};
    }
  }
}
