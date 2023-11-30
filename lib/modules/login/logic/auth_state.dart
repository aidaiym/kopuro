part of 'auth_cubit.dart';

class AuthEvent<T extends Users> {}

class SignInEvent extends AuthEvent {
  final String email;
  final String password;

  SignInEvent(this.email, this.password);
}

class SignUpEvent<T extends Users> extends AuthEvent<T> {
  final String email;
  final String password;
  final T user;

  SignUpEvent(this.email, this.password, this.user);
}

class AuthState {}

class AuthInitialState extends AuthState {}

class AuthLoadingState extends AuthState {}

class AuthSignedInState extends AuthState {
  final User user;

  AuthSignedInState(this.user);
}

class AuthSignInSuccessState extends AuthState {
  final Users user; // Change the type to Users

  AuthSignInSuccessState(User firebaseUser)
      : user = Users(
          id: firebaseUser.uid,
          createdTime: DateTime.now(),
          username: '', 
          email: firebaseUser.email ?? '',
          type: UserType.student, 
        );
}

class AuthErrorState extends AuthState {
  final String errorMessage;

  AuthErrorState(this.errorMessage);
}
class AuthSignedOutState extends AuthState {


  AuthSignedOutState();
}

class SignUpStudentEvent extends AuthEvent<StudentUser> {
  final String email;
  final String password;
  final StudentUser user;

  SignUpStudentEvent(this.email, this.password, this.user);
}

class SignUpCompanyEvent extends AuthEvent<CompanyUser> {
  final String email;
  final String password;
  final CompanyUser user;

  SignUpCompanyEvent(this.email, this.password, this.user);
}
