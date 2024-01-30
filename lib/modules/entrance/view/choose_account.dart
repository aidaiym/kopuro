import 'package:flutter/material.dart';
import 'package:kopuro/export_files.dart';

class ChooseAccountType extends StatelessWidget {
  const ChooseAccountType({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
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
                    style: AppTextStyles.black14),
              ),
              MainButton(
                onPressed: () {
                  Navigator.of(context).push<void>(SignUpPage.route(true));
                },
                text: 'Студент',
              ),
              MainButton(
                onPressed: () {
                  Navigator.of(context).push<void>(SignUpPage.route(false));
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
