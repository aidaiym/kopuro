import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kopuro/export_files.dart';

class EditVacancy extends StatelessWidget {
  const EditVacancy({
    super.key,
    required this.vacancy,
  });
  final Vacancy vacancy;
  @override
  Widget build(BuildContext context) {
    final jobTitleController = TextEditingController(text: vacancy.jobTitle);
    final jobDescriptionController = TextEditingController(text: vacancy.jobDescription);
    final jobTypeController = TextEditingController(text: vacancy.jobType);
    final jobLocationController = TextEditingController(text: vacancy.location);
    final jobSalaryController = TextEditingController(text: vacancy.salary);

    return Container(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            const Text(
              'Edit Vacancy',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16.0),
            TextFieldWidget(
              controller: jobTitleController,
              hintText: vacancy.jobTitle,
              validator: '',
              description: 'Job Title',
              label: 'Job Title',
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
                await FirebaseFirestore.instance
                    .collection('vacancies')
                    .doc(vacancy.id)
                    .update({
                  'jobTitle': jobTitleController.text,
                  'location': jobLocationController.text,
                  'jobType': jobTypeController.text,
                  'jobDescription': jobDescriptionController.text,
                  'salary': jobSalaryController.text,
                });

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
