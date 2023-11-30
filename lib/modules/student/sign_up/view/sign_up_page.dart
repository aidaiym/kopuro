
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kopuro/core/repos/authentication_repository/authentication_repository.dart';
import 'package:kopuro/modules/student/sign_up/cubit/sign_up_cubit.dart';
import 'package:kopuro/modules/student/sign_up/view/sign_up_form.dart';

class StudentSignUpPage extends StatelessWidget {
  const StudentSignUpPage({super.key});

  static Route<void> route() {
    return MaterialPageRoute<void>(builder: (_) => const StudentSignUpPage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: BlocProvider<SignUpCubit>(
          create: (_) => SignUpCubit(context.read<AuthenticationRepository>()),
          child: const StudentSignUpForm(),
        ),
      ),
    );
  }
}