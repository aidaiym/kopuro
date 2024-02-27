import 'dart:developer';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
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

  Future<void> uploadImage() async {
    try {
      emit(ProfileImageUploadingState());
      final picker = ImagePicker();
      final pickedFile = await picker.pickImage(source: ImageSource.gallery);

      if (pickedFile != null) {
        Reference storageReference = FirebaseStorage.instance
            .ref()
            .child('images/${DateTime.now().toString()}');
        UploadTask uploadTask = storageReference.putFile(File(pickedFile.path));
        await uploadTask.whenComplete(() => null);
        String downloadURL = await storageReference.getDownloadURL();
        emit(ProfileImageUploadedState(imageUrl: downloadURL));
      } else {
        emit(ProfileErrorState('No image selected.'));
      }
    } catch (e) {
      emit(ProfileErrorState('Error uploading image: $e'));
      log('Error uploading image: $e');
    }
  }
}
