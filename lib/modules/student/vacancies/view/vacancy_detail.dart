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
    // void applyVacancy(BuildContext context) async {
    //   try {
    //     var user = FirebaseAuth.instance.currentUser;

    //     final CollectionReference vacancies =
    //         FirebaseFirestore.instance.collection('vacancies');
    //     final updatedVacancy = vacancy.copyWith(
    //       appliedUsers: [...vacancy.appliedStudents ?? [], user],
    //     );

    //     final Map<String, dynamic> vacancyMap = updatedVacancy.toJson();
    //     final DocumentReference vacancyDocument = vacancies
    //         .doc('${vacancy}'); 
    //     await vacancyDocument.update(vacancyMap);

    //     showDialog(
    //       context: context,
    //       builder: (BuildContext context) {
    //         return AlertDialog(
    //           title: Text('Success'),
    //           content: Text('You have successfully applied to the vacancy!'),
    //           actions: <Widget>[
    //             TextButton(
    //               onPressed: () {
    //                 Navigator.of(context).pop(); 
    //                 Navigator.pushReplacement(
    //                   context,
    //                   MaterialPageRoute(
    //                     builder: (context) => const StudentMainView(),
    //                   ),
    //                 );
    //               },
    //               child: Text('OK'),
    //             ),
    //           ],
    //         );
    //       },
    //     );
    //   } catch (e) {
    //     log('Error applying to the vacancy: $e');
    //     showDialog(
    //       context: context,
    //       builder: (BuildContext context) {
    //         return AlertDialog(
    //           title: Text('Error'),
    //           content: Text('An error occurred while applying to the vacancy.'),
    //           actions: <Widget>[
    //             TextButton(
    //               onPressed: () {
    //                 Navigator.of(context).pop();
    //               },
    //               child: Text('OK'),
    //             ),
    //           ],
    //         );
    //       },
    //     );
    //   }
    // }

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
              onPressed: () async{
                // applyVacancy
                },
              text: 'Вакансияга тапшыруу',
            ),
          ],
        ),
      ),
    );
  }
}
