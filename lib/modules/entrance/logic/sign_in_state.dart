part of 'sign_in_cubit.dart';

 class SignInState extends Equatable {
  const SignInState();

  @override
  List<Object?> get props => [];
}

class SignInInitial extends SignInState {
  const SignInInitial();

  
  List<Object?> get streamProps => [];
  
  
  User? get state => throw UnimplementedError();
  
  Stream<User?> get stream => throw UnimplementedError();
}

class SignInSuccess extends SignInState {
  final User user;

  const SignInSuccess({required this.user});

  
  List<Object?> get streamProps => [user];
  
  
  User? get state => throw UnimplementedError();
  
  
  Stream<User?> get stream => throw UnimplementedError();
}

class SignInFailure extends SignInState {
  final String error;

  const SignInFailure({required this.error});

  
  List<Object?> get streamProps => [error];
  

  User? get state => throw UnimplementedError();
  

  Stream<User?> get stream => throw UnimplementedError();
}
