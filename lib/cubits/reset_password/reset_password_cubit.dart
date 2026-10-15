import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:map_maker_new/constants/app_constants.dart';
import 'package:map_maker_new/services/auth_service.dart';
import 'package:map_maker_new/types/enum/auth_failure_type.dart';
import 'package:map_maker_new/utils/auth_failure_util.dart';

part 'reset_password_state.dart';

class ResetPasswordCubit extends Cubit<ResetPasswordState> {
  ResetPasswordCubit(this._authService) : super(const ResetPasswordState());
  final AuthService _authService;

  Future<void> requestPasswordReset(String email) async {
    if (state.isLoading) return;
    emit(state.copyWith(isLoading: true, emailError: () => null, failure: () => null));
    try {
      await _authService.requestPasswordReset(email);
      if (isClosed) return;
      emit(state.copyWith(isLoading: false, sentToEmail: () => email.trim()));
    } catch (e) {
      if (isClosed) return;
      final String? emailError = AuthFailureUtil.getFieldErrors(e)[AppConstants.emailField];
      emit(state.copyWith(
        isLoading: false,
        emailError: () => emailError,
        failure: () => emailError == null ? AuthFailureUtil.getFailureType(e) : null,
      ));
    }
  }

  void onEmailChanged() {
    if (state.emailError == null) return;
    emit(state.copyWith(emailError: () => null));
  }
}
