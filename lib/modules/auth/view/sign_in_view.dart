import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kopuro/export_files.dart';

class SignInView extends StatelessWidget {
  const SignInView({super.key});

  @override
  Widget build(BuildContext context) {
    final emailController = TextEditingController();
    final passwordController = TextEditingController();
    GlobalKey<FormState> formKey = GlobalKey<FormState>();

    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthSignInSuccessState) {
          Users? user = state.user;

          if (user != null) {
            if (user.type == UserType.student) {
              Navigator.pushNamed(context, AppRouter.studentMainView);
            } else if (user.type == UserType.company) {
              Navigator.pushNamed(context, AppRouter.studentMainView);
            } else if (user.type == UserType.admin) {
              Navigator.pushNamed(context, AppRouter.studentMainView);
            } else {
              print('Unknown user type: ${user.type}');
            }
          }
        }
      },
      child: Scaffold(
        backgroundColor: AppColors.backgroundColor,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(40.0),
            child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text('Кош келиңиз!', style: AppTextStyles.header1),
                  const SizedBox(
                    height: 30,
                  ),
                  Text('Аккаунтунузга кириңиз', style: AppTextStyles.header2),
                  const SizedBox(
                    height: 50,
                  ),
                  TextFieldWidget(
                    controller: emailController,
                    label: 'Электрондук почтаныз',
                    validator: 'Сураныч, электрондук почтанызды жазыныз',
                    description: 'Электрондук почта',
                    obscureText: false,
                  ),
                  TextFieldWidget(
                    obscureText: false,
                    controller: passwordController,
                    label: 'Паролунуз',
                    validator: 'Сураныч, паролунузду жазыныз',
                    description: 'Пароль',
                  ),
                  MainButton(
                    text: 'Кирүү',
                    onPressed: () async {
                      if (formKey.currentState!.validate()) {
                        try {
                          context.read<AuthCubit>().signIn(SignInEvent(
                              emailController.text, passwordController.text));
                        } catch (e) {
                          print('Unexpected error signing in: $e');
                        }
                      }
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Каттала элексизби?'),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const ChooseAccountType()),
                          );
                        },
                        child: const Text('Катталуу',
                            style: TextStyle(color: AppColors.main)),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
