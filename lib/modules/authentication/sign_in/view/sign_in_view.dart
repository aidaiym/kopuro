import 'package:flutter/material.dart';
import 'package:kopuro/modules/onboarding/view/onboarding_view.dart';

class SignInView extends StatelessWidget {
  const SignInView({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(leading: IconButton(icon: const Icon(Icons.back_hand), onPressed: () =>  Navigator.of(context).pushReplacement(MaterialPageRoute(
      builder: (context) =>  const OnboardingView(),
    ))),),
      body: const Center(child: Text('Login'),),
    );
  }
}