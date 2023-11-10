
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kopuro/app/app.dart';
import 'package:kopuro/modules/entrance/logic/sign_in_cubit.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appUser = context.read<SignInCubit>().state.user;
    return MaterialApp(
      onGenerateRoute: (settings) {
        return AppRouter.onGenerateRoute(settings, appUser);
      },
    );
  }
}








  //  Builder(
    //     builder: (context) {
    //       final user = BlocProvider.of<SignInCubit>(context).state;
    //       if (user != null) {
    //         return const OnboardingView();
    //       } else {
    //         return const OnboardingView();
    //       }
    //     },
      