import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'profile_state.dart';



class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileState(userData: {}));

  Future<void> fetchUserData(String uid) async {
    try {
      Map<String, dynamic> data = await getUserData(uid);
      emit(ProfileState(userData: data));
    } catch (e) {
      log('Error fetching user data: $e');
    }
  }
}

Future<Map<String, dynamic>> getUserData(String uid) async {
  try {
    DocumentSnapshot userSnapshot =
        await FirebaseFirestore.instance.collection('users').doc(uid).get();

    if (userSnapshot.exists) {
      return userSnapshot.data() as Map<String, dynamic>;
    } else {
      return {}; // Return an empty map or handle accordingly
    }
  } catch (e) {
    log('Error fetching user data: $e');
    return {}; // Return an empty map or handle accordingly
  }
}