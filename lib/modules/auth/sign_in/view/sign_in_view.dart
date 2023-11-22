import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kopuro/modules/modules.dart';
import '../../../../../components/components.dart';
import '../../../../../constants/contants.dart';
import '../../../../app/app.dart';

class SignInView extends StatelessWidget {
  const SignInView({super.key});

  @override
  Widget build(BuildContext context) {
    final emailController = TextEditingController();
    final passwordController = TextEditingController();
    GlobalKey<FormState> formKey = GlobalKey<FormState>();

    return Scaffold(
      appBar: AppBar(),
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
                ),
                TextFieldWidget(
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
                        // Call the sign-in method
                        await context
                            .read<SignInCubit>()
                            .signInWithEmailAndPassword(
                              emailController.text,
                              passwordController.text,
                            );

                        final state = context.read<SignInCubit>().state;
                        print(state);

                        if (state is SignInSuccess) {
                          Navigator.pushNamed(
                              context, AppRouter.studentMainView);
                        } else if (state is SignInFailure) {
                          print('Error signing in: ${state.error}');
                        }
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
                              builder: (context) => const ChooseAccountType()),
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
    );
  }
}
