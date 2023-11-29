import 'package:flutter/widgets.dart';
import 'package:kopuro/core/app/bloc/app_bloc.dart';
import 'package:kopuro/core/app/home_page.dart';
import 'package:kopuro/core/login/view/login_page.dart';


List<Page<dynamic>> onGenerateAppViewPages(
  AppStatus state,
  List<Page<dynamic>> pages,
) {
  switch (state) {
    case AppStatus.authenticated:
      return [HomePage.page()];
    case AppStatus.unauthenticated:
      return [LoginPage.page()];
  }
}