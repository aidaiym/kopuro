import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kopuro/export_files.dart';
import 'package:kopuro/l10n/l10.dart';

class VacancyDetail extends StatelessWidget {
  const VacancyDetail(
      {super.key, required this.vacancy, this.isCompany = false});
  final Vacancy vacancy;
  final bool isCompany;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(vacancy.jobTitle),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              sectionText(
                  AppLocalizations.of(context).employer, vacancy.companyName),
              sectionText(
                  AppLocalizations.of(context).jobSalary, vacancy.salary),
              sectionText(AppLocalizations.of(context).contactInformation,
                  vacancy.contactInformation),
              sectionText(AppLocalizations.of(context).jobDescription,
                  vacancy.jobDescription),
              sectionText(
                  AppLocalizations.of(context).jobType, vacancy.jobType),
              sectionText(
                  AppLocalizations.of(context).jobLocation, vacancy.location),
              const SizedBox(height: 40),
              if (!isCompany)
                MainButton(
                  onPressed: () async {
                    try {
                      var user = FirebaseAuth.instance.currentUser;
                      FirebaseFirestore.instance
                          .collection('vacancies')
                          .doc(vacancy.id)
                          .update(({
                            'appliedUsers': FieldValue.arrayUnion([user!.uid])
                          }));

                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title:
                                Text(AppLocalizations.of(context).successTitle),
                            content: Text(
                                AppLocalizations.of(context).successContent),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const StudentMainView(),
                                    ),
                                  );
                                },
                                child: const Text('OK'),
                              ),
                            ],
                          );
                        },
                      );
                    } catch (e) {
                      log('Error applying to the vacancy: $e');
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text(AppLocalizations.of(context).error),
                            content: Text(
                              AppLocalizations.of(context)
                                  .errorApplyingToVacancy,
                            ),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Text('OK'),
                              ),
                            ],
                          );
                        },
                      );
                    }
                  },
                  text: AppLocalizations.of(context).applyToVacancy,
                ),
            ],
          ),
        ),
      ),
    );
  }

  Container sectionText(String title, String content) {
    return Container(
      padding: const EdgeInsets.only(top: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('$title: ', style: AppTextStyles.main18),
          const SizedBox(width: 10),
          Flexible(child: Text(content, style: AppTextStyles.black16)),
        ],
      ),
    );
  }
}
