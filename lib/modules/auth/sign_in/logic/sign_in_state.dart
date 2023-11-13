part of 'sign_in_cubit.dart';

class SignInState {}

class SignInInitial extends SignInState {}

class SignInSuccess extends SignInState {
  final Users user;

  SignInSuccess({required this.user});
}

class SignInFailure extends SignInState {
  final String error;

  SignInFailure({required this.error});
}
