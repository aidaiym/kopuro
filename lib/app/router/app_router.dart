import 'package:flutter/widgets.dart';
import 'package:kopuro/app/bloc/app_bloc.dart';
import 'package:kopuro/export_files.dart';

List<Page<dynamic>> onGenerateAppViewPages(
  AppStatus state,
  List<Page<dynamic>> pages,
) {
  switch (state) {
    case AppStatus.authenticatedStudent:
      return [CompanyMainView.page()];
    case AppStatus.unauthenticated:
      return [OnboardingView.page()];
    case AppStatus.authenticatedCompany:
      return [CompanyMainView.page()];
    case AppStatus.authenticatedAdmin:
      return [AdminView.page()];
  }
}
