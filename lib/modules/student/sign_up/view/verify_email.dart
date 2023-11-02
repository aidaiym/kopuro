import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../modules.dart';
import 'resume_builder.dart';

class VerifyEmailView extends StatelessWidget {
  const VerifyEmailView({Key? key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignUpCubit(),
      child: BlocBuilder<SignUpCubit, SignUpState>(
        builder: (context, state) {
          final signUpCubit = context.read<SignUpCubit>();

          if (state.isSuccess) {
            return ResumeBuilder();
          }

          if (state.errorMessage.isNotEmpty) {
            return Scaffold(
              appBar: AppBar(
                title: const Text('Email Verification Error'),
              ),
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Error: ${state.errorMessage}',
                      style: TextStyle(color: Colors.red, fontSize: 18),
                    ),
                    TextButton(
                      onPressed: () {
                        signUpCubit.checkEmailVerification(context);
                      },
                      child: const Text('Refresh'),
                    ),
                  ],
                ),
              ),
            );
          }

          // Initial state, loading, or any other state
          signUpCubit.checkEmailVerification(context); // Trigger email verification check
          return Scaffold(
            appBar: AppBar(
              title: const Text('Email Verification'),
            ),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Please check your email for a verification link.',
                    style: TextStyle(fontSize: 18),
                  ),
                  TextButton(
                    onPressed: () {
                      signUpCubit.checkEmailVerification(context); // Refresh the email verification status
                    },
                    child: const Text('Refresh'),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
