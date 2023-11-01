import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../modules.dart';

class SignUpStudentView extends StatelessWidget {
  const SignUpStudentView({super.key});

  @override
  Widget build(BuildContext context) {
    final emailController = TextEditingController();
    final passwordController = TextEditingController();

    return BlocProvider(
        create: (context) => SignUpCubit(),
      child: Scaffold(
    
        body: BlocConsumer<SignUpCubit, SignUpState>(
          listener: (context, state) {
            if (state.isSuccess) {
    
            }
          },
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  TextFormField(
                    controller: emailController,
                    decoration: const InputDecoration(labelText: 'Email'),
                  ),
                  TextFormField(
                    controller: passwordController,
                    decoration: const InputDecoration(labelText: 'Password'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      context.read<SignUpCubit>().signUp(
                        email: emailController.text,
                        password: passwordController.text,
                      );
                    },
                    child: const Text('Sign Up'),
                  ),
                  if (state.errorMessage.isNotEmpty)
                    Text(
                      'Error: ${state.errorMessage}',
                      style: const TextStyle(color: Colors.red),
                    ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
