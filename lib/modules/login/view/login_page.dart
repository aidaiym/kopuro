
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kopuro/core/repos/authentication_repository/authentication_repository.dart';
import 'package:kopuro/modules/login/logic/login_cubit.dart';
import 'package:kopuro/modules/login/view/login_form.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});
 static Route<void> route() {
    return MaterialPageRoute<void>(builder: (_) => const LoginPage());
  }
  // static Page<void> page() => const MaterialPage<void>(child: LoginPage());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: BlocProvider(
          create: (_) => LoginCubit(context.read<AuthenticationRepository>()),
          child: const LoginForm(),
        ),
      ),
    );
  }
}