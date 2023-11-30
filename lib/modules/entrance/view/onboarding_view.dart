import 'package:flutter/material.dart';
import 'package:intro_slider/intro_slider.dart';
import 'package:kopuro/export_files.dart';

class OnboardingView extends StatelessWidget {
  const OnboardingView({Key? key}) : super(key: key);

  void onDonePress(BuildContext context) {
    Navigator.of(context).pushReplacement(MaterialPageRoute(
      builder: (context) => const LoginPage(),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Padding(
        padding: const EdgeInsets.only(bottom: 100.0, left: 20, right: 20),
        child: IntroSlider(
          indicatorConfig: const IndicatorConfig(
            colorIndicator: AppColors.inActive,
            colorActiveIndicator: AppColors.main,
          ),
          listContentConfig: [
            ContentConfig(
              heightImage: MediaQuery.of(context).size.height * 0.52,
              pathImage: "assets/images/onboarding1.png",
            ),
            ContentConfig(
              heightImage: MediaQuery.of(context).size.height * 0.52,
              pathImage: "assets/images/onboarding2.png",
            ),
          ],
          onDonePress: () => onDonePress(context),
          isShowPrevBtn: false,
          isShowSkipBtn: false,
          renderDoneBtn: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.main,
              textStyle: const TextStyle(color: Colors.white),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
            ),
            onPressed: () {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) => const LoginPage(),
              ));
            },
            child: const Text('Бүттү'),
          ),
          renderNextBtn: Container(
            padding: const EdgeInsets.all(8),
            decoration: const BoxDecoration(
              color: AppColors.main,
              borderRadius: BorderRadius.all(Radius.circular(20)),
            ),
            child: const Text(
              'Кийинки',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}
