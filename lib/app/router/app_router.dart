import 'package:flutter/widgets.dart';
import 'package:kopuro/app/bloc/app_bloc.dart';
import 'package:kopuro/export_files.dart';
import 'package:kopuro/modules/modules.dart';

List<Page<dynamic>> onGenerateAppViewPages(
  AppStatus state,
  List<Page<dynamic>> pages,
) {
  switch (state) {
    case AppStatus.authenticatedStudent:
      return [StudentMainView.page()];
    case AppStatus.unauthenticated:
      return [OnboardingView.page()];
    case AppStatus.authenticatedCompany:
      return [CompanyMainView.page()];
  }
}
