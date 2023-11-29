import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kopuro/app/view/app_view.dart';
import 'package:kopuro/core/app/app.dart';
import 'package:kopuro/core/app/bloc_observer.dart';
import 'package:kopuro/core/authentication_repository/authentication_repository.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = const AppBlocObserver();

  await Firebase.initializeApp();
  final authenticationRepository = AuthenticationRepository();
  await authenticationRepository.user.first;
  // runApp(const MyApp());
  runApp(App(authenticationRepository: authenticationRepository));
}
