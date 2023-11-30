import 'package:flutter/material.dart';
import 'package:kopuro/app/router/app_router.dart';
import 'package:kopuro/components/components.dart';
import 'package:kopuro/constants/app/app_text_styles.dart';
import 'package:kopuro/modules/student/sign_up/view/sign_up_page.dart';

class ChooseAccountType extends StatelessWidget {
  const ChooseAccountType({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Аккаунттун түрүн тандаңыз', style: AppTextStyles.header1),
              Padding(
                padding: const EdgeInsets.only(bottom: 50.0, top: 20),
                child: Text('Сиз компаниясызбы же студентсизби?',
                    style: AppTextStyles.header4Black),
              ),
              MainButton(
                onPressed: () {
                  Navigator.of(context).push<void>(StudentSignUpPage.route());
                  // Navigator.pushNamed(context, AppRouter.signupStudent);

                      
                },
                text: 'Студент',
              ),
              MainButton(
                onPressed: () {
                  Navigator.pushNamed(context, AppRouter.signupStudent);
                },
                text: 'Компания',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
