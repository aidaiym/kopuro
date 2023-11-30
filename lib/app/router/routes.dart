import 'package:flutter/widgets.dart';
import 'package:kopuro/app/bloc/app_bloc.dart';

import 'package:kopuro/modules/student/main/home_page.dart';
import 'package:kopuro/modules/login/view/login_page.dart';


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