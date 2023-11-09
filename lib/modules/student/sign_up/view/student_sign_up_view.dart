import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kopuro/modules/student/sign_up/view/verify_email.dart';

import '../../../../components/components.dart';
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
        appBar: AppBar(),
        body: BlocConsumer<SignUpCubit, SignUpState>(
          listener: (context, state) {
            if (state.isSuccess) {}
          },
          builder: (context, state) {
            return SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(40.0),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextFieldWidget(
                        controller: emailController,
                        label: 'Email',
                        validator: 'Сураныч, Email жазыныз',
                        description: 'Email',
                      ),
                      TextFieldWidget(
                        controller: passwordController,
                        label: 'Паролунуз',
                        validator: 'Сураныч, паролунузду жазыныз',
                        description: 'Пароль',
                      ),
                      MainButton(
                          onPressed: () {
                            context.read<SignUpCubit>().signUp(
                                email: emailController.text,
                                password: passwordController.text);
                            Future.delayed(Duration.zero, () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const VerifyEmailView()),
                              );
                            });
                         
                          },
                          text: 'Катталуу'),
                      if (state.errorMessage.isNotEmpty)
                        Text(
                          'Error: ${state.errorMessage}',
                          style: const TextStyle(color: Colors.red),
                        ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
