import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kopuro/export_files.dart';

class OnboardingView extends StatelessWidget {
  OnboardingView({super.key});

  static Page<void> page() => MaterialPage<void>(child: OnboardingView());
  final PageController _pageController = PageController();

  final List<String> onboardingItems = [
    "assets/images/onboarding1.png",
    "assets/images/onboarding2.png",
  ];

  @override
  Widget build(BuildContext context) {
    Widget buildNextButton() {
      return ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.main,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
        ),
        onPressed: () {
          final currentPage = context.read<PageCubit>().state;
          final isLastPage = currentPage == onboardingItems.length - 1;
          if (isLastPage) {
            Navigator.of(context).push<void>(LoginPage.route());
          } else {
            context.read<PageCubit>().setPage(currentPage + 1);
            _pageController.nextPage(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
            );
          }
        },
        child: BlocBuilder<PageCubit, int>(
          builder: (context, currentPage) {
            final isLastPage = currentPage == onboardingItems.length - 1;
            return Text(
              isLastPage ? "Бүттү" : "Кийинки",
              style: AppTextStyles.white14,
            );
          },
        ),
      );
    }

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 100),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                itemCount: onboardingItems.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child:
                        OnboardingItemWidget(imagePath: onboardingItems[index]),
                  );
                },
                onPageChanged: (int page) {
                  context.read<PageCubit>().setPage(page);
                },
              ),
            ),
            buildDotIndicator(),
            Align(
              alignment: Alignment.centerRight,
              child: buildNextButton(),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildDotIndicator() {
    return BlocBuilder<PageCubit, int>(
      builder: (context, currentPage) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            onboardingItems.length,
            (index) => buildDot(index, currentPage == index),
          ),
        );
      },
    );
  }

  Widget buildDot(int index, bool isActive) {
    return Container(
      margin: const EdgeInsets.all(8),
      width: isActive ? 16.0 : 8.0,
      height: 8.0,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isActive ? AppColors.main : AppColors.inActive,
      ),
    );
  }
}
