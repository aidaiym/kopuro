import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kopuro/app/services/app_service.dart';
part 'language_state.dart';

class LanguageCubit extends Cubit<LanguageState> {
  LanguageCubit(this.localService) : super(const LanguageState(Locale('en')));

  final AppService localService;

  Future<void> changeLang(String langKey) async {
    final local = await localService.setLocale(langKey);
    emit(state.copyWith(currentLocale: local));
  }
}
