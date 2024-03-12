part of 'app_bloc.dart';

enum AppStatus {
  authenticatedStudent,
  authenticatedCompany,
  authenticatedNotVerified,
  unauthenticated,
}

class AppState extends Equatable {
  const AppState._({
    required this.status,
    this.user = User.empty,
  });

  const AppState.authenticatedStudent(User user)
      : this._(status: AppStatus.authenticatedStudent, user: user);

  const AppState.authenticatedCompany(User user)
      : this._(status: AppStatus.authenticatedCompany, user: user);

  const AppState.authenticatedNotVerified(User user)
      : this._(status: AppStatus.authenticatedNotVerified, user: user);

  const AppState.unauthenticated() : this._(status: AppStatus.unauthenticated);

  final AppStatus status;
  final User user;

  @override
  List<Object?> get props => [status, user];
}
