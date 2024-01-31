import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kopuro/export_files.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key, required this.isStudent});
  final bool isStudent;

  static Route<void> route(bool isStudent) {
    return MaterialPageRoute<void>(
      builder: (_) => SignUpPage(isStudent: isStudent),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: BlocProvider<SignUpCubit>(
          create: (_) => SignUpCubit(context.read<AuthenticationRepository>()),
          child:  SignUpForm(isStudent: isStudent,),
        ),
      ),
    );
  }
}
