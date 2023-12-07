part of 'profile_cubit.dart';
abstract class ProfileState {
  final Map<String, dynamic>? userData;

  ProfileState({required this.userData});
}

class HomeInitialState extends ProfileState {
  HomeInitialState() : super(userData: null);
}

class HomeLoadingState extends ProfileState {
  HomeLoadingState() : super(userData: null);
}

class HomeSuccessState extends ProfileState {
  HomeSuccessState({required Map<String, dynamic> userData})
      : super(userData: userData);
}

class HomeErrorState extends ProfileState {
  HomeErrorState(this.message) : super(userData: null);
  final String message;
}
