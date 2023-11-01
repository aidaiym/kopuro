import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../components/components.dart';
import '../../../modules.dart';

class SignUpStudentView extends StatelessWidget {
  const SignUpStudentView({super.key});

  @override
  Widget build(BuildContext context) {
    final emailController = TextEditingController();
    final passwordController = TextEditingController();
    final nameController = TextEditingController();
    final dateOfBirthController = TextEditingController();
    final educationController = TextEditingController();
    final skillsController = TextEditingController();
    final linkedinController = TextEditingController();
    final githubController = TextEditingController();
    final aboutController = TextEditingController();

    return BlocProvider(
      create: (context) => SignUpCubit(),
      child: Scaffold(
        body: BlocConsumer<SignUpCubit, SignUpState>(
          listener: (context, state) {
            if (state.isSuccess) {}
          },
          builder: (context, state) {
            return SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(40.0),
                child: Column(
                  children: [
                    TextFieldWidget(
                      controller: nameController,
                      label: 'Паролунуз',
                      validator: 'Сураныч, паролунузду жазыныз',
                    ),
                    TextFieldWidget(
                      controller: dateOfBirthController,
                      label: 'Паролунуз',
                      validator: 'Сураныч, паролунузду жазыныз',
                    ),
                    TextFieldWidget(
                      controller: educationController,
                      label: 'Паролунуз',
                      validator: 'Сураныч, паролунузду жазыныз',
                    ),
                    TextFieldWidget(
                      controller: skillsController,
                      label: 'Паролунуз',
                      validator: 'Сураныч, паролунузду жазыныз',
                    ),
                    TextFieldWidget(
                      controller: aboutController,
                      label: 'Паролунуз',
                      validator: 'Сураныч, паролунузду жазыныз',
                    ),
                    TextFieldWidget(
                      controller: linkedinController,
                      label: 'Паролунуз',
                      validator: 'Сураныч, паролунузду жазыныз',
                    ),
                    TextFieldWidget(
                      controller: githubController,
                      label: 'Паролунуз',
                      validator: 'Сураныч, паролунузду жазыныз',
                    ),
                    TextFieldWidget(
                      controller: emailController,
                      label: 'Электрондук почтаныз',
                      validator: 'Сураныч, электрондук почтанызды жазыныз',
                    ),
                    TextFieldWidget(
                      controller: passwordController,
                      label: 'Паролунуз',
                      validator: 'Сураныч, паролунузду жазыныз',
                    ),
                    MainButton(
                        onPressed: () {
                          context.read<SignUpCubit>().signUp(
                                email: emailController.text,
                                password: passwordController.text,
                                name: nameController.text,
                                dateOfBirth: dateOfBirthController.text,
                                education: educationController.text,
                                skills: skillsController.text,
                                linkedin: linkedinController.text,
                                github: githubController.text,
                                about: aboutController.text,
                              );
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
            );
          },
        ),
      ),
    );
  }
}
