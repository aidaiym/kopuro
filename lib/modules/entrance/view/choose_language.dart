import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kopuro/export_files.dart';
import 'package:kopuro/l10n/l10.dart';

class ChooseLanguage extends StatelessWidget {
  const ChooseLanguage({super.key});

  static Page<void> page() => const MaterialPage<void>(child: ChooseLanguage());

  @override
  Widget build(BuildContext context) {
    final appCubit = context.watch<LanguageCubit>();
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
          title: Text(
        AppLocalizations.of(context).chooseLanguage,
        style: AppTextStyles.black19,
      )),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.sizeOf(context).height * 0.7,
              child: ListView.builder(
                itemCount: AppConst.locales.length,
                itemBuilder: (BuildContext context, int index) {
                  final locale = AppConst.locales[index];
                  final langName = AppConst.getName(locale.toLanguageTag());
                  return Card(
                    color: AppColors.primaryColor,
                    child: ListTile(
                      title: Text(
                        langName,
                        locale: locale,
                        style: AppTextStyles.primary16,
                      ),
                      onTap: () => context
                          .read<LanguageCubit>()
                          .changeLang(locale.languageCode),
                      trailing: appCubit.state.currentLocale == locale
                          ? CircleAvatar(
                              radius: 15,
                              backgroundColor: colorScheme.background,
                              child:
                                  Icon(Icons.check, color: colorScheme.primary),
                            )
                          : null,
                    ),
                  );
                },
              ),
            ),
            MainButton(
                onPressed: () {
                  Navigator.push<void>(
                    context,
                    MaterialPageRoute<void>(
                      builder: (BuildContext context) => OnboardingView(),
                    ),
                  );
                },
                text: AppLocalizations.of(context).save)
          ],
        ),
      ),
    );
  }
}
