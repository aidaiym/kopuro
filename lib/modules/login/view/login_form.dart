import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:kopuro/export_files.dart';
import 'package:kopuro/modules/login/logic/login_cubit.dart';

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
                content: Text(state.errorMessage ?? 'Authentication Failure'),
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
              Text('Кош келиңиз!', style: AppTextStyles.header1),
              const SizedBox(
                height: 30,
              ),
              Text('Аккаунтунузга кириңиз', style: AppTextStyles.header2),
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
              BlocBuilder<LoginCubit, LoginState>(
                buildWhen: (previous, current) =>
                    previous.password != current.password,
                builder: (context, state) {
                  return TextField(
                    key: const Key('loginForm_passwordInput_textField'),
                    onChanged: (password) =>
                        context.read<LoginCubit>().passwordChanged(password),
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
                          text: 'Кирүү');
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
                // onPressed: () =>
                //     Navigator.of(context).push<void>(SignUpPage.route()),
                child: const Text(
                  'Катталуу',
                  style: TextStyle(color: AppColors.main),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
