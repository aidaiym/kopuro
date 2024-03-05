import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:kopuro/export_files.dart';

class OnboardingItemWidget extends StatelessWidget {
  final String text;

  const OnboardingItemWidget({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(30),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(60)),
        image: DecorationImage(
          image: AssetImage('assets/images/onboarding_background.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: Text(
        text,
        style: AppTextStyles.white30bold,
      ),
    );
  }
}
