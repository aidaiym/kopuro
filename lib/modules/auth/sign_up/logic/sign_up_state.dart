
part of 'sign_up_cubit.dart';
class SignUpState extends Equatable {
  final bool isSubmitting;
  final bool isSuccess;
  final String errorMessage;


  const SignUpState({
    this.isSubmitting = false,
    this.isSuccess = false,
    this.errorMessage = '',
  });

  @override
  List<Object?> get props => [isSubmitting, isSuccess, errorMessage];

  SignUpState copyWith({
    bool? isSubmitting,
    bool? isSuccess,
    String? errorMessage,
  }) {
    return SignUpState(
      isSubmitting: isSubmitting ?? this.isSubmitting,
      isSuccess: isSuccess ?? this.isSuccess,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}