import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:map_maker_new/cubits/auth/auth_cubit.dart';
import 'package:map_maker_new/services/auth_service.dart';
import 'package:map_maker_new/types/enum/auth_failure_type.dart';
import 'package:map_maker_new/types/models/auth_user.dart';
import 'package:map_maker_new/utils/auth_failure_util.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit(this._authService, this._authCubit) : super(const LoginState());
  final AuthService _authService;
  final AuthCubit _authCubit;

  Future<void> login({required String identifier, required String password}) async {
    if (state.isLoading) return;
    emit(state.copyWith(isLoading: true, failure: () => null));
    try {
      final AuthUser user = await _authService.login(identifier: identifier, password: password);
      _authCubit.onLoggedIn(user);
    } catch (e) {
      if (isClosed) return;
      emit(state.copyWith(isLoading: false, failure: () => _getLoginFailureType(e)));
    }
  }

  void onShowHidePasswordPressed() {
    emit(state.copyWith(isPasswordHidden: !state.isPasswordHidden));
  }

  AuthFailureType _getLoginFailureType(Object exception) {
    final AuthFailureType failureType = AuthFailureUtil.getFailureType(exception);
    if (failureType == AuthFailureType.invalidData) return AuthFailureType.invalidCredentials;
    return failureType;
  }
}
