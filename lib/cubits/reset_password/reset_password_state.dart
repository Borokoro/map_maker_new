part of 'reset_password_cubit.dart';

class ResetPasswordState extends Equatable {
  final bool isLoading;
  final String? sentToEmail;
  final String? emailError;
  final AuthFailureType? failure;

  const ResetPasswordState({
    this.isLoading = false,
    this.sentToEmail,
    this.emailError,
    this.failure,
  });

  ResetPasswordState copyWith({
    bool? isLoading,
    String? Function()? sentToEmail,
    String? Function()? emailError,
    AuthFailureType? Function()? failure,
  }) {
    return ResetPasswordState(
      isLoading: isLoading ?? this.isLoading,
      sentToEmail: sentToEmail != null ? sentToEmail() : this.sentToEmail,
      emailError: emailError != null ? emailError() : this.emailError,
      failure: failure != null ? failure() : this.failure,
    );
  }

  @override
  List<Object?> get props => [isLoading, sentToEmail, emailError, failure];
}
