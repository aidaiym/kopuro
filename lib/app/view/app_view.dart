import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kopuro/app/app.dart';
import 'package:kopuro/modules/modules.dart';


class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
       onGenerateRoute: (settings) => AppRouter.onGenerateRoute(
        settings,
        context.read<SignInCubit>().state.user,
      ),
  
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
      