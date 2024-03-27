import 'package:flutter/material.dart';
import 'package:kopuro/export_files.dart';
import 'package:kopuro/l10n/l10.dart';

class ChooseAccountType extends StatelessWidget {
  const ChooseAccountType({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                AppLocalizations.of(context).selectAccountType,
                style: AppTextStyles.main28,
                textAlign: TextAlign.center,
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 50.0, top: 20),
                child: Text(
                  AppLocalizations.of(context).areYouAnEmployerOrJobSeeker,
                  textAlign: TextAlign.center,
                  style: AppTextStyles.black14,
                ),
              ),
              MainButton(
                onPressed: () {
                  Navigator.of(context).push<void>(SignUpPage.route(true));
                },
                text: AppLocalizations.of(context).jobSeeker,
              ),
              MainButton(
                onPressed: () {
                  Navigator.of(context).push<void>(SignUpPage.route(false));
                },
                text: AppLocalizations.of(context).employer,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
