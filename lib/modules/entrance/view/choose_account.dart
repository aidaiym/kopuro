import 'package:flutter/material.dart';
import 'package:kopuro/components/components.dart';
import 'package:kopuro/constants/app/app_text_styles.dart';

import '../../modules.dart';

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
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SignUpStudentView()),
                  );
                },
                text: 'Студент',
              ),
              MainButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SignUpStudentView()),
                  );
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
