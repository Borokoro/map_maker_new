part of 'login_cubit.dart';

class LoginState extends Equatable {
  final bool isLoading;
  final bool isPasswordHidden;
  final AuthFailureType? failure;

  const LoginState({
    this.isLoading = false,
    this.isPasswordHidden = true,
    this.failure,
  });

  LoginState copyWith({
    bool? isLoading,
    bool? isPasswordHidden,
    AuthFailureType? Function()? failure,
  }) {
    return LoginState(
      isLoading: isLoading ?? this.isLoading,
      isPasswordHidden: isPasswordHidden ?? this.isPasswordHidden,
      failure: failure != null ? failure() : this.failure,
    );
  }

  @override
  List<Object?> get props => [isLoading, isPasswordHidden, failure];
}
