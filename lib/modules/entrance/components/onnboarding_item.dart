import 'package:flutter/material.dart';

class OnboardingItemWidget extends StatelessWidget {
  final String imagePath;

  const OnboardingItemWidget({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      imagePath,
    );
  }
}
