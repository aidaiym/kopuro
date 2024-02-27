part of 'profile_cubit.dart';
abstract class ProfileState {
  final Map<String, dynamic>? userData;
   final String? uploadedImageUrl;

  ProfileState({required this.userData, this.uploadedImageUrl});
}

class ProfileInitialState extends ProfileState {
  ProfileInitialState() : super(userData: null);
}

class ProfileLoadingState extends ProfileState {
  ProfileLoadingState() : super(userData: null);
}

class ProfileSuccessState extends ProfileState {
  ProfileSuccessState({required Map<String, dynamic> userData})
      : super(userData: userData);
}

class ProfileErrorState extends ProfileState {
  ProfileErrorState(this.message) : super(userData: null);
  final String message;
}

class ProfileImageUploadedState extends ProfileState {
  final String imageUrl;

  ProfileImageUploadedState({required this.imageUrl}) : super(userData: null);
}

class ProfileImageUploadingState extends ProfileState {
  ProfileImageUploadingState() : super(userData: null);
}