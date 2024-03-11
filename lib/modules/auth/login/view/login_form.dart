import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:kopuro/export_files.dart';
import 'package:kopuro/l10n/l10.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state.status.isFailure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Text(
                    state.errorMessage ?? AppLocalizations.of(context).error),
              ),
            );
        }
      },
      child: Align(
        alignment: const Alignment(0, -1 / 3),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('${AppLocalizations.of(context).welcome} !',
                  style: AppTextStyles.main28),
              const SizedBox(
                height: 30,
              ),
              Text(AppLocalizations.of(context).loginText,
                  style: AppTextStyles.black24),
              const SizedBox(
                height: 50,
              ),
              BlocBuilder<LoginCubit, LoginState>(
                buildWhen: (previous, current) =>
                    previous.email != current.email,
                builder: (context, state) {
                  return TextField(
                    key: const Key('loginForm_emailInput_textField'),
                    onChanged: (email) =>
                        context.read<LoginCubit>().emailChanged(email),
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
              BlocBuilder<LoginCubit, LoginState>(
                builder: (context, state) {
                  return TextField(
                    key: const Key('loginForm_passwordInput_textField'),
                    onChanged: (password) =>
                        context.read<LoginCubit>().passwordChanged(password),
                    obscureText: state.isPasswordHidden,
                    decoration: InputDecoration(
                      labelText: AppLocalizations.of(context).password,
                      errorMaxLines: 3,

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
                          context.read<LoginCubit>().togglePasswordVisibility();
                        },
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 8),
              BlocBuilder<LoginCubit, LoginState>(
                builder: (context, state) {
                  return state.status.isInProgress
                      ? const CircularProgressIndicator()
                      : MainButton(
                          onPressed: state.isValid
                              ? () => context
                                  .read<LoginCubit>()
                                  .logInWithCredentials()
                              : null,
                          text: AppLocalizations.of(context).signIn);
                },
              ),
              const SizedBox(height: 4),
              TextButton(
                key: const Key('loginForm_createAccount_flatButton'),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ChooseAccountType()),
                  );
                },
                child: Text(
                  AppLocalizations.of(context).signUp,
                  style: const TextStyle(color: AppColors.main),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
