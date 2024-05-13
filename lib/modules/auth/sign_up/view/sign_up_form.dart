import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:kopuro/export_files.dart';
import 'package:kopuro/l10n/l10.dart';

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
            Text(AppLocalizations.of(context).signUp,
                style: AppTextStyles.main28),
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
                    errorMaxLines: 3,
                    labelText: AppLocalizations.of(context).email,
                    errorText: state.email.displayError != null
                        ? AppLocalizations.of(context).emailErrorText
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
            const SizedBox(height: 30),
            BlocBuilder<SignUpCubit, SignUpState>(
              builder: (context, state) {
                return TextField(
                  key: const Key('signUpForm_passwordInput_textField'),
                  onChanged: (password) =>
                      context.read<SignUpCubit>().passwordChanged(password),
                  obscureText: state.isPasswordHidden,
                  decoration: InputDecoration(
                    errorMaxLines: 3,
                    labelText: AppLocalizations.of(context).password,
                    errorText: state.password.displayError != null
                        ? AppLocalizations.of(context).passwordErrorText
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
                        context
                            .read<SignUpCubit>()
                            .togglePasswordVisibility(true);
                      },
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 20),
            BlocBuilder<SignUpCubit, SignUpState>(
              builder: (context, state) {
                return TextField(
                  key: const Key('signUpForm_confirmedPasswordInput_textField'),
                  onChanged: (confirmPassword) => context
                      .read<SignUpCubit>()
                      .confirmedPasswordChanged(confirmPassword),
                  obscureText: state.isConfirmedPasswordHidden,
                  decoration: InputDecoration(
                    errorMaxLines: 3,
                    labelText: AppLocalizations.of(context).verifyPassword,
                    errorText: state.confirmedPassword.displayError != null
                        ? AppLocalizations.of(context).verifyPasswordErrorText
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
                      icon: Icon(state.isConfirmedPasswordHidden
                          ? Icons.visibility
                          : Icons.visibility_off),
                      onPressed: () {
                        context
                            .read<SignUpCubit>()
                            .togglePasswordVisibility(false);
                      },
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 16),
            BlocBuilder<SignUpCubit, SignUpState>(builder: (context, state) {
              return state.status.isInProgress
                  ? const CircularProgressIndicator()
                  : MainButton(
                      onPressed: () {
                        if (state.isValid) {
                          try {
                            context
                                .read<SignUpCubit>()
                                .signUpFormSubmitted(isStudent);
                            if (state.status.isSuccess) {
                              if (isStudent) {
                                Navigator.push<void>(
                                  context,
                                  MaterialPageRoute<void>(
                                    builder: (BuildContext context) =>
                                        const ResumeBuilder(),
                                  ),
                                );
                              } else {
                                Navigator.push<void>(
                                  context,
                                  MaterialPageRoute<void>(
                                    builder: (BuildContext context) =>
                                        const CompanyProfileBuilder(),
                                  ),
                                );
                              }
                            }
                          } catch (e) {
                            log(e.toString());
                          }
                        }
                      },
                      text: AppLocalizations.of(context).next,
                    );
            }),
          ],
        ),
      ),
    );
  }
}
