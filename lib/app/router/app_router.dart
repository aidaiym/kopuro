import 'package:flutter/widgets.dart';
import 'package:kopuro/app/bloc/app_bloc.dart';
import 'package:kopuro/export_files.dart';


List<Page<dynamic>> onGenerateAppViewPages(
  AppStatus state,
  List<Page<dynamic>> pages,
) {
  switch (state) {
    case AppStatus.authenticated:
      return [StudentMainView.page()];
    case AppStatus.unauthenticated:
      return [OnboardingView.page()];
  }
}