import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kopuro/export_files.dart';

class SignUpStudentView extends StatelessWidget {
  const SignUpStudentView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();
    final TextEditingController usernameController = TextEditingController();
    final TextEditingController jobTitleController = TextEditingController();
    final TextEditingController skillsController = TextEditingController();

    return Scaffold(
      appBar: AppBar(),
      backgroundColor: AppColors.backgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(40.0),
          child: Form(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text('Student Sign Up', style: AppTextStyles.header1),
                const SizedBox(height: 30),
                TextFieldWidget(
                  controller: emailController,
                  label: 'Email',
                  validator: 'Please enter a valid email',
                  description: 'Enter your email',
                  obscureText: false,
                ),
                TextFieldWidget(
                  controller: passwordController,
                  label: 'Password',
                  validator: 'Password must be at least 6 characters',
                  description: 'Enter your password',
                  obscureText: true,
                ),
                MainButton(
                  text: 'Next',
                  onPressed: () async {
                    await context.read<AuthCubit>().signUp(
                          SignUpStudentEvent(
                            emailController.text,
                            passwordController.text,
                            StudentUser(
                              id: '',
                              createdTime: DateTime.now(),
                              username: usernameController.text,
                              email: emailController.text,
                              jobTitle: jobTitleController.text,
                              skills: skillsController.text,
                              type: UserType.student,
                            ),
                          ),
                        );

                    await _sendVerificationEmail();
                    Navigator.pushNamed(context, AppRouter.verifyEmail);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _sendVerificationEmail() async {
    try {
      await FirebaseAuth.instance.currentUser?.sendEmailVerification();
    } catch (e) {
      print('Error sending verification email: $e');
    }
  }
}
