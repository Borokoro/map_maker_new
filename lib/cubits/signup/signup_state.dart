part of 'signup_cubit.dart';

class SignupState extends Equatable {
  final bool isLoading;
  final bool isPasswordHidden;
  final bool isRegistered;
  final Map<SignupField, String> fieldErrors;
  final AuthFailureType? failure;

  const SignupState({
    this.isLoading = false,
    this.isPasswordHidden = true,
    this.isRegistered = false,
    this.fieldErrors = const {},
    this.failure,
  });

  SignupState copyWith({
    bool? isLoading,
    bool? isPasswordHidden,
    bool? isRegistered,
    Map<SignupField, String>? fieldErrors,
    AuthFailureType? Function()? failure,
  }) {
    return SignupState(
      isLoading: isLoading ?? this.isLoading,
      isPasswordHidden: isPasswordHidden ?? this.isPasswordHidden,
      isRegistered: isRegistered ?? this.isRegistered,
      fieldErrors: fieldErrors ?? this.fieldErrors,
      failure: failure != null ? failure() : this.failure,
    );
  }

  @override
  List<Object?> get props => [isLoading, isPasswordHidden, isRegistered, fieldErrors, failure];
}
