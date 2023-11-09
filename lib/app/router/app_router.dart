import 'package:flutter/cupertino.dart';
import 'package:kopuro/modules/company/main/view/main_view.dart';
import 'package:kopuro/modules/modules.dart';

import '../../models/models.dart';

class AppRouter {
  const AppRouter();

  static const String main = '/';
  static const String onboarding = '/onboarding';
  static const String signin = '/signin';
  static const String signup = '/signup';

  static Route<void> onGenerateRoute(RouteSettings settings, User? user) {
    switch (settings.name) {
      case main:
        return CupertinoPageRoute(builder: (_) {
          if (user!.userType == 'Student') {
            return const StudentMainView();
          } else if (user.userType == 'Company') {
            return const CompanyMainView();
          } else {
            return const SignInView();
          }
        });
      case signin:
        return CupertinoPageRoute(builder: (_) => const SignInView());
      case onboarding:
        return CupertinoPageRoute(builder: (_) => const OnboardingView());
      case signup:
        return CupertinoPageRoute(builder: (_) => const SignUpStudentView());
      default:
        throw Exception(
            'No builder specified for route named: [${settings.name}]');
    }
  }
}
