import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kopuro/export_files.dart';

class VacancyDetail extends StatelessWidget {
  const VacancyDetail({super.key, required this.vacancy});
  final Vacancy vacancy;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              vacancy.jobTitle,
              style: AppTextStyles.main14,
            ),
            Text(vacancy.companyName),
            Text('Salary: ${vacancy.salary}'),
            Text(vacancy.contactInformation),
            Text(vacancy.jobDescription),
            Text(vacancy.jobType),
            Text(vacancy.location),
            Text(vacancy.salary),
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
                                  builder: (context) => const StudentMainView(),
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
    );
  }
}
