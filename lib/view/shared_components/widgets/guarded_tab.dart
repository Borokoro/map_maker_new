import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:map_maker_new/cubits/auth/auth_cubit.dart';
import 'package:map_maker_new/service_locator.dart';

class GuardedTab extends StatelessWidget {
  GuardedTab({
    super.key,
    required this.childWhenUnauthenticated,
    required this.childWhenAuthenticated,
  });

  final Widget childWhenUnauthenticated;
  final Widget childWhenAuthenticated;

  final AuthCubit _authCubit = serviceLocator.get<AuthCubit>();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      bloc: _authCubit,
      builder: _mapAuthStateToWidget,
    );
  }

  Widget _mapAuthStateToWidget(BuildContext context, AuthState authState) {
    if (authState is AuthAuthenticated) {
      return childWhenAuthenticated;
    }
    return childWhenUnauthenticated;
  }
}
