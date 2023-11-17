import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kopuro/modules/modules.dart';
import '../../../../../components/components.dart';
import '../../../../../constants/contants.dart';

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
                  validator: 'Сураныч, электрондук почтанызды жазыныз', description: 'Электрондук почта',
                ),
                TextFieldWidget(
                  controller: passwordController,
                  label: 'Паролунуз',
                  validator: 'Сураныч, паролунузду жазыныз', description: 'Пароль',
                ),
                MainButton(
                  text: 'Кирүү',
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
  context.read<SignInCubit>().signInWithEmailAndPassword(
                            emailController.text,
                            passwordController.text,
                          );
                          
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
                          MaterialPageRoute(builder: (context) => const ChooseAccountType()),
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
