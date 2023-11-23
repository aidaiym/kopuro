import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kopuro/export_files.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => SignInCubit()),
      ],
      child: const KopuroApp(),
    );
  }
}

class KopuroApp extends StatelessWidget {
  const KopuroApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'KopuroApp',
      debugShowCheckedModeBanner: false,
      onGenerateRoute: (settings) {
        return AppRouter.onGenerateRoute(
            settings, context.read<SignInCubit>().currentUser);
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
      