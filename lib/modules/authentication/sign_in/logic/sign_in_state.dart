part of 'sign_in_cubit.dart';

 class SignInState extends Equatable {
  const SignInState();

  @override
  List<Object?> get props => [];
}

class SignInInitial extends SignInState {
  const SignInInitial();

  @override
  List<Object?> get streamProps => [];
  
  @override
  User? get state => throw UnimplementedError();
  
  @override
  Stream<User?> get stream => throw UnimplementedError();
}

class SignInSuccess extends SignInState {
  final User user;

  const SignInSuccess({required this.user});

  @override
  List<Object?> get streamProps => [user];
  
  @override
  User? get state => throw UnimplementedError();
  
  @override
  Stream<User?> get stream => throw UnimplementedError();
}

class SignInFailure extends SignInState {
  final String error;

  const SignInFailure({required this.error});

  @override
  List<Object?> get streamProps => [error];
  
  @override
  // TODO: implement state
  User? get state => throw UnimplementedError();
  
  @override
  // TODO: implement stream
  Stream<User?> get stream => throw UnimplementedError();
}
