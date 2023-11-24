import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kopuro/export_files.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AuthCubit()),
      ],
      child: const KopuroApp(),
    );
  }
}

class KopuroApp extends StatelessWidget {
  const KopuroApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Users?>(
      future: context.read<AuthCubit>().getCurrentUser(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          Users? user = snapshot.data;
          return MaterialApp(
            title: 'KopuroApp',
            debugShowCheckedModeBanner: false,
            onGenerateRoute: (settings) {
              return AppRouter.onGenerateRoute(settings, user);
            },
          );
        } else {

          return const CircularProgressIndicator();
        }
      },
    );
  }
}

