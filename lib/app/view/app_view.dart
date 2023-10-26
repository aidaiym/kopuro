import 'package:flutter/material.dart';
import 'package:kopuro/modules/onboarding/view/onboarding_view.dart';


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

class KopuroApp extends StatelessWidget {
  const KopuroApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  const MaterialApp(
      title: 'KopuroApp',
      debugShowCheckedModeBanner: false,
      home: OnboardingView(),
    );
  }
}