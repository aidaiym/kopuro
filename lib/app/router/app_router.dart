import 'package:flutter/cupertino.dart';
import 'package:kopuro/models/user/user_model.dart';
import 'package:kopuro/modules/modules.dart';

class AppRouter {
  const AppRouter();

  static const String main = '/';
  static const String onboarding = '/onboarding';
  static const String signin = '/signin';
  static const String signupStudent = '/signupStudent';
  static const String resumeBuilder = '/resumeBuilder';
  static const String studentMainView = '/studentMainView';

  static Route<void> onGenerateRoute(RouteSettings settings, Users? user) {
    switch (settings.name) {
      case main:
        return CupertinoPageRoute(builder: (_) {
          if (user != null) {
            if (user.userType == 'Student') {
              return const StudentMainView();
            } else if (user.userType == 'Company') {
              return const CompanyMainView();
            }
          }
          return const SignInView();
        });
      case signin:
        return CupertinoPageRoute(builder: (_) => const SignInView());
      case onboarding:
        return CupertinoPageRoute(builder: (_) => const OnboardingView());
      case signupStudent:
        return CupertinoPageRoute(builder: (_) => const SignUpStudentView());
      case resumeBuilder:
        return CupertinoPageRoute(builder: (_) => const ResumeBuilder());
      case studentMainView:
        return CupertinoPageRoute(builder: (_) => const StudentMainView());
      default:
        throw Exception(
            'No builder specified for route named: [${settings.name}]');
    }
  }
}
