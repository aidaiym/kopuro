import 'package:flutter/cupertino.dart';
import 'package:kopuro/export_files.dart';
import 'package:kopuro/modules/student/sign_up/view/verify_email.dart';

class AppRouter {
  const AppRouter();

  static const String main = '/';
  static const String onboarding = '/onboarding';
  static const String signin = '/signin';
  static const String signupStudent = '/signupStudent';
  static const String resumeBuilder = '/resumeBuilder';
  static const String studentMainView = '/studentMainView';
  static const String verifyEmail = '/verifyEmail';

static Route<void> onGenerateRoute(RouteSettings settings, Users? user) {
  switch (settings.name) {
    case main:
      return CupertinoPageRoute(builder: (_) {
        if (user != null) {
          if (user.type == UserType.admin) {
            return const StudentMainView();
          } else if (user.type == UserType.company) {
            return const CompanyMainView();
          }
        }
        return const OnboardingView();
      });
    case signin:
      return CupertinoPageRoute(builder: (_) => const OnboardingView());
    case onboarding:
      return CupertinoPageRoute(builder: (_) => const OnboardingView());
    case verifyEmail:
      return CupertinoPageRoute(builder: (_) => const VerifyEmailView());
    case signupStudent:
      return CupertinoPageRoute(builder: (_) => const SignUpStudentView());
    case resumeBuilder:
      return CupertinoPageRoute(builder: (_) => const ResumeBuilder());
    case studentMainView:
      return CupertinoPageRoute(builder: (_) => const StudentMainView());
    default:
      throw Exception('No builder specified for route named: [${settings.name}]');
  }
}

}
