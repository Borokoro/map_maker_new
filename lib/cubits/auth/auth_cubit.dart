import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:map_maker_new/services/auth_service.dart';
import 'package:map_maker_new/types/models/auth_user.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit(this._authService) : super(const AuthUnauthenticated());
  final AuthService _authService;

  Future<void> restoreSession() async {
    final bool hasSession = await _authService.restoreSession();
    if (hasSession) emit(const AuthAuthenticated());
  }

  void onLoggedIn(AuthUser user) {
    emit(AuthAuthenticated(user: user));
  }

  void onSessionExpired() {
    if (state is AuthUnauthenticated) return;
    emit(const AuthUnauthenticated());
  }

  Future<void> logout() async {
    emit(const AuthUnauthenticated());
    await _authService.logout();
  }
}
