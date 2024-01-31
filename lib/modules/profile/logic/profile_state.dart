part of 'profile_cubit.dart';
abstract class ProfileState {
  final Map<String, dynamic>? userData;

  ProfileState({required this.userData});
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
