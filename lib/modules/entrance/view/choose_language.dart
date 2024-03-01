import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kopuro/export_files.dart';
import 'package:kopuro/l10n/l10.dart';
class ChooseLanguage extends StatelessWidget {
  const ChooseLanguage({super.key});

  static Page<void> page() => const MaterialPage<void>(child: ChooseLanguage());

  @override
  Widget build(BuildContext context) {
    final selectedLanguage = context.select((LanguageCubit cubit) => cubit.state.selectedLanguage);

    return Scaffold(
      appBar: AppBar(title: Text(AppLocalizations.of(context).selectPreferredLanguage)),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(AppLocalizations.of(context).chooseLanguage),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(
                  selectedLanguage == Language.english ? Colors.green : Colors.blue,
                ),
              ),
              onPressed: () {
                BlocProvider.of<LanguageCubit>(context).selectLanguage(Language.english);
              },
              child: Text(AppLocalizations.of(context).english),
            ),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(
                  selectedLanguage == Language.russian ? Colors.green : Colors.blue,
                ),
              ),
              onPressed: () {

                BlocProvider.of<LanguageCubit>(context).selectLanguage(Language.russian);
              },
              child: Text(AppLocalizations.of(context).russian),
            ),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(
                  selectedLanguage == Language.kyrgyz ? Colors.green : Colors.blue,
                ),
              ),
              onPressed: () {
                BlocProvider.of<LanguageCubit>(context).selectLanguage(Language.kyrgyz);
              },
              child: Text(AppLocalizations.of(context).kyrgyz),
            ),
            MainButton(
              onPressed: () {
                Navigator.push<void>(
                  context,
                  MaterialPageRoute<void>(builder: (BuildContext context) => OnboardingView()),
                );
              },
              text: AppLocalizations.of(context).save,
            ),
          ],
        ),
      ),
    );
  }
}
