import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kopuro/modules/authentication/sign_in/logic/sign_in_cubit.dart';
import 'package:kopuro/modules/modules.dart';
import 'package:kopuro/modules/onboarding/view/onboarding_view.dart';


class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Builder(
        builder: (context) {
          final user = BlocProvider.of<SignInCubit>(context).state;

          if (user != null) {
            return const MainView();
          } else {
            return const OnboardingView();
          }
        },
      
    );
  }
}

