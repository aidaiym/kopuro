import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kopuro/export_files.dart';

class CreateVacancy extends StatelessWidget {
  const CreateVacancy({
    super.key,
    required this.companyName,
    required this.contactNumber,
  });
  final String companyName;
  final String contactNumber;


  @override
  Widget build(BuildContext context) {
    final jobTitleController = TextEditingController();
    final jobDescriptionController = TextEditingController();
    final jobTypeController = TextEditingController();
    final jobLocationController = TextEditingController();
    final jobSalaryController = TextEditingController();

    return Container(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            const Text(
              'Create Vacancy',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16.0),
            TextFieldWidget(
              controller: jobTitleController,
              label: 'Job Title',
              validator: '',
              description: 'Job Title',
              obscureText: false,
            ),
            TextFieldWidget(
              controller: jobDescriptionController,
              label: 'Job Description',
              validator: '',
              description: 'Job Description',
              obscureText: false,
            ),
            TextFieldWidget(
              controller: jobTypeController,
              label: 'Job Type',
              validator: '',
              description: 'Job Type',
              obscureText: false,
            ),
            TextFieldWidget(
              controller: jobLocationController,
              label: 'Job Location',
              validator: '',
              description: 'Job Location',
              obscureText: false,
            ),
            TextFieldWidget(
              controller: jobSalaryController,
              label: 'Job Salary',
              validator: '',
              description: 'Job Salary',
              obscureText: false,
            ),
            const SizedBox(height: 16.0),
            MainButton(
              onPressed: () async {
                Vacancy vacancy = Vacancy(
                  id: '',
                  createdTime: DateTime.now(),
                  jobTitle: jobTitleController.text,
                  companyName: companyName,
                  location: jobLocationController.text,
                  jobType: jobTypeController.text,
                  jobDescription: jobDescriptionController.text,
                  contactInformation: contactNumber,
                  salary: jobSalaryController.text,
                  appliedUsers: [],
                );

                CollectionReference vacancies =
                    FirebaseFirestore.instance.collection('vacancies');
                DocumentReference documentReference =
                    await vacancies.add(vacancy.toJson());

                String documentId = documentReference.id;
                vacancy = vacancy.copyWith(id: documentId);

                await documentReference.update(vacancy.toJson());
               

                var user = FirebaseAuth.instance.currentUser;
                 if (user != null) {
                  DocumentReference userRef =
                      FirebaseFirestore.instance.collection('users').doc(user.uid);
                  userRef.update({
                    'vacancies': FieldValue.arrayUnion([documentReference]),
                  });
                }

                // ignore: use_build_context_synchronously
                Navigator.pop(context);
              },
              text: 'Save',
            ),
          ],
        ),
      ),
    );
  }
}
