import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:kopuro/export_files.dart';

class SignUpForm extends StatelessWidget {
  const SignUpForm({super.key, required this.isStudent});
  final bool isStudent;
  @override
  Widget build(BuildContext context) {
    return BlocListener<SignUpCubit, SignUpState>(
      listener: (context, state) {
        if (state.status.isSuccess) {
          Navigator.of(context).pop();
        } else if (state.status.isFailure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(content: Text(state.errorMessage ?? 'Sign Up Failure')),
            );
        }
      },
      child: Align(
        alignment: const Alignment(0, -1 / 3),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Катталуу', style: AppTextStyles.main32),
            const SizedBox(
              height: 30,
            ),
            BlocBuilder<SignUpCubit, SignUpState>(
              buildWhen: (previous, current) => previous.email != current.email,
              builder: (context, state) {
                return TextField(
                  key: const Key('signUpForm_emailInput_textField'),
                  onChanged: (email) =>
                      context.read<SignUpCubit>().emailChanged(email),
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    labelText: 'Электрондук почтаныз',
                    errorText: state.email.displayError != null
                        ? 'Сураныч, электрондук туура почтанызды жазыныз'
                        : null,
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 12.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                      borderSide: const BorderSide(
                        width: 1,
                        color: AppColors.main,
                      ),
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 16),
            BlocBuilder<SignUpCubit, SignUpState>(
              buildWhen: (previous, current) =>
                  previous.password != current.password,
              builder: (context, state) {
                return TextField(
                  key: const Key('signUpForm_passwordInput_textField'),
                  onChanged: (password) =>
                      context.read<SignUpCubit>().passwordChanged(password),
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Паролунуз',
                    errorText: state.password.displayError != null
                        ? 'Сураныч, туура паролунузду жазыныз'
                        : null,
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 12.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                      borderSide: const BorderSide(
                        width: 1,
                        color: AppColors.main,
                      ),
                    ),
                      suffixIcon: IconButton(
                        icon: Icon(state.isPasswordHidden
                            ? Icons.visibility
                            : Icons.visibility_off),
                        onPressed: () {
                          context.read<SignUpCubit>().togglePasswordVisibility();
                        },
                      ),
                  ),
                );
              },
            ),
            const SizedBox(height: 16),
            BlocBuilder<SignUpCubit, SignUpState>(
              buildWhen: (previous, current) =>
                  previous.password != current.password ||
                  previous.confirmedPassword != current.confirmedPassword,
              builder: (context, state) {
                return TextField(
                  key: const Key('signUpForm_confirmedPasswordInput_textField'),
                  onChanged: (confirmPassword) => context
                      .read<SignUpCubit>()
                      .confirmedPasswordChanged(confirmPassword),
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Сырсөздү ыраста',
                    errorText: state.confirmedPassword.displayError != null
                        ? 'Cырсөздөр дал келбейт'
                        : null,
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 12.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                      borderSide: const BorderSide(
                        width: 1,
                        color: AppColors.main,
                      ),
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 16),
            BlocBuilder<SignUpCubit, SignUpState>(
              builder: (context, state) {
                return state.status.isInProgress
                    ? const CircularProgressIndicator()
                    : MainButton(
                        onPressed: () {
                          if (state.isValid) {
                            context.read<SignUpCubit>().signUpFormSubmitted();
                            Navigator.push<void>(
                              context,
                              MaterialPageRoute<void>(
                                builder: (BuildContext context) =>
                                    VerifyEmailView(isStudent: isStudent),
                              ),
                            );
                          }
                        },
                        text: 'Кийинки',
                      );
              },
            ),
          ],
        ),
      ),
    );
  }
}
