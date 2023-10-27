import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kopuro/modules/authentication/sign_in/logic/sign_in_cubit.dart';

import 'app/app.dart';


void main() async {
 WidgetsFlutterBinding.ensureInitialized();
   await Firebase.initializeApp();
 runApp(
    BlocProvider(
      create: (context) => SignInCubit(),
      child: const MyApp(),
    ),
  );
}
