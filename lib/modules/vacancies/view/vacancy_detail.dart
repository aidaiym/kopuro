import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kopuro/export_files.dart';

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
              sectionText('Компания', vacancy.companyName),
              sectionText('Эмгек акы', vacancy.salary),
              sectionText('Байланыш маалыматы', vacancy.contactInformation),
              sectionText('Жумуш жөнүндө', vacancy.jobDescription),
              sectionText('Жумуштун түрү', vacancy.jobType),
              sectionText('Жайгашкан жери', vacancy.location),
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
                            title: const Text('Азаматсыз!'),
                            content: const Text(
                                'Сиз вакансияга ийгиликтүү тапшырдыңыз!'),
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
                            title: const Text('Ката'),
                            content: const Text(
                                'Вакансияга тапшырып жатканда ката кетти.'),
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
                  text: 'Вакансияга тапшыруу',
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
