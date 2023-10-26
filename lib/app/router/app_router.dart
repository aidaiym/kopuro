import 'package:flutter/cupertino.dart';
import 'package:kopuro/modules/modules.dart';
import 'package:kopuro/modules/onboarding/view/onboarding_view.dart';

import '../../models/models.dart';

class AppRouter {
  const AppRouter();

  static const String main = '/';
  static const String onboarding = '/onboarding';
  static const String signin = '/signin';
  static const String signup = '/signup';



  static Route<void> onGenerateRoute(RouteSettings settings, User? user) {
    return switch (settings.name) {
      main => CupertinoPageRoute(builder: (_) => user != null ? const MainView() : const SignInView()),
      signin => CupertinoPageRoute(builder: (_) => const SignInView()),
      onboarding => CupertinoPageRoute(builder: (_) => const OnboardingView()),

      _ => throw Exception('no builder specified for route named: [${settings.name}]'),
    };
  }
}