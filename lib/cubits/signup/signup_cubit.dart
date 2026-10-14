import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:map_maker_new/cubits/auth/auth_cubit.dart';
import 'package:map_maker_new/services/auth_service.dart';
import 'package:map_maker_new/types/enum/auth_failure_type.dart';
import 'package:map_maker_new/types/enum/signup_field.dart';
import 'package:map_maker_new/types/models/auth_user.dart';
import 'package:map_maker_new/utils/auth_failure_util.dart';

part 'signup_state.dart';

class SignupCubit extends Cubit<SignupState> {
  SignupCubit(this._authService, this._authCubit) : super(const SignupState());
  final AuthService _authService;
  final AuthCubit _authCubit;

  Future<void> signup({
    required String username,
    required String email,
    required String password,
    String? firstName,
    String? lastName,
  }) async {
    if (state.isLoading) return;
    emit(state.copyWith(isLoading: true, fieldErrors: const {}, failure: () => null));
    try {
      await _authService.register(
        username: username,
        email: email,
        password: password,
        firstName: firstName,
        lastName: lastName,
      );
    } catch (e) {
      if (isClosed) return;
      final Map<SignupField, String> fieldErrors = _getSignupFieldErrors(e);
      emit(state.copyWith(
        isLoading: false,
        fieldErrors: fieldErrors,
        failure: () => fieldErrors.isEmpty ? AuthFailureUtil.getFailureType(e) : null,
      ));
      return;
    }
    await _loginAfterSignup(username: username, password: password);
    if (isClosed) return;
    emit(state.copyWith(isLoading: false, isRegistered: true));
  }

  void onFieldChanged(SignupField field) {
    if (!state.fieldErrors.containsKey(field)) return;
    emit(state.copyWith(fieldErrors: Map.of(state.fieldErrors)..remove(field)));
  }

  void onShowHidePasswordPressed() {
    emit(state.copyWith(isPasswordHidden: !state.isPasswordHidden));
  }

  Future<void> _loginAfterSignup({required String username, required String password}) async {
    try {
      final AuthUser user = await _authService.login(identifier: username, password: password);
      _authCubit.onLoggedIn(user);
    } catch (_) {
      return;
    }
  }

  Map<SignupField, String> _getSignupFieldErrors(Object exception) {
    final Map<String, String> fieldErrors = AuthFailureUtil.getFieldErrors(exception);
    return {
      for (final SignupField field in SignupField.values)
        if (fieldErrors[field.apiKey] != null) field: fieldErrors[field.apiKey]!,
    };
  }
}
