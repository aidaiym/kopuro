part of 'language_cubit.dart';

class LanguageState extends Equatable {
  const LanguageState(this.currentLocale);

  final Locale currentLocale;

  @override
  List<Object?> get props => [currentLocale];

  LanguageState copyWith({Locale? currentLocale}) {
    return LanguageState(
      currentLocale ?? this.currentLocale,
    );
  }
}
