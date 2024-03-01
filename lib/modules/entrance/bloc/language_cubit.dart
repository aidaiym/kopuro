import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kopuro/app/services/app_service.dart';
import 'package:kopuro/export_files.dart';
part 'language_state.dart';

class LanguageCubit extends Cubit<LanguageState> {
  LanguageCubit() : super(LanguageState(Language.english));
  void selectLanguage(Language language) {
    AppService.saveLanguageCode(language.toString());
    emit(LanguageState(language));
  }
}
