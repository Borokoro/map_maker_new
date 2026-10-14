import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:map_maker_new/view/pages/account/components/account_details.dart';
import 'package:map_maker_new/view/pages/auth/login/login_page_body.dart';
import 'package:map_maker_new/view/shared_components/widgets/guarded_tab.dart';
import 'package:map_maker_new/view/shared_components/widgets/universal_app_bar_widget.dart';

@RoutePage(name: "AccountRoute")
class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: UniversalAppBarWidget(),
      body: SafeArea(
        child: GuardedTab(
          childWhenUnauthenticated: const LoginPageBody(),
          childWhenAuthenticated: AccountDetails(),
        ),
      ),
    );
  }
}
