import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kopuro/export_files.dart';
import 'package:kopuro/models/user_model.dart';

class ResumeBuilder extends StatelessWidget {
  const ResumeBuilder({Key? key}) : super(key: key);
  static Route<void> route() {
    return MaterialPageRoute<void>(builder: (_) => const ResumeBuilder());
  }

  @override
  Widget build(BuildContext context) {
    final nameController = TextEditingController();
    final phoneNumberController = TextEditingController();
    final educationController = TextEditingController();
    final skillsController = TextEditingController();
    final linkedinController = TextEditingController();
    final githubController = TextEditingController();
    final aboutController = TextEditingController();
    final jobController = TextEditingController();
    final languageController = TextEditingController();
    final locationController = TextEditingController();
    void uploadResume(BuildContext context) async {
      try {
        var user = FirebaseAuth.instance.currentUser;
        StudentUser student = StudentUser(
          id: user?.uid ?? '',
          email: user?.email ?? '',
          username: nameController.text,
          createdTime: DateTime.now(),
          jobTitle: jobController.text,
          skills: skillsController.text,
          education: educationController.text,
          workExperience: '',
          linkedIn: linkedinController.text,
          github: githubController.text,
          phoneNumber: phoneNumberController.text,
          aboutUser: aboutController.text,
          photoUrl: '',
          userLocation: locationController.text,
        );

        Map<String, dynamic> studentMap = student.toMapStudent();
        await FirebaseFirestore.instance
            .collection('users')
            .doc(user?.uid)
            .set(studentMap, SetOptions(merge: true));

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) =>
                const StudentMainView(),
          ),
        );
      } catch (e) {
        log('Error uploading resume: $e');
      }
    }

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(40.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFieldWidget(
                  controller: nameController,
                  label: 'Аты-жөнү',
                  validator: 'Сураныч, Аты-жөнү жазыныз',
                  description: 'Аты-жөнү',
                  obscureText: false,
                ),
                TextFieldWidget(
                  controller: phoneNumberController,
                  label: 'Телефон номери',
                  validator: 'Сураныч, Телефон номери жазыныз',
                  description: 'Телефон номери',
                  obscureText: false,
                ),
                TextFieldWidget(
                  controller: locationController,
                  label: 'Жайгашкан жери',
                  validator: 'Сураныч, Жайгашкан жери жазыныз',
                  description: 'Жайгашкан жери',
                  obscureText: false,
                ),
                TextFieldWidget(
                  controller: aboutController,
                  label: 'мен тууралуу',
                  validator: 'Сураныч, мен тууралуу жазыныз',
                  description: 'мен тууралуу',
                  obscureText: false,
                ),
                TextFieldWidget(
                  obscureText: false,
                  controller: jobController,
                  label: 'Жумуштун аталышы',
                  validator: 'Сураныч, жумуштун жазыныз',
                  description: 'Жумуштун аталышы',
                ),
                Text(
                  'Профессионалдык Кыскача маалымат',
                  style: AppTextStyles.header2,
                ),
                TextFieldWidget(
                  obscureText: false,
                  controller: educationController,
                  label: 'билим',
                  validator: 'Сураныч, билим жазыныз',
                  description: 'билим',
                ),
                TextFieldWidget(
                  obscureText: false,
                  controller: skillsController,
                  label: 'көндүмдөр',
                  validator: 'Сураныч, көндүмдөр жазыныз',
                  description: 'көндүмдөр',
                ),
                TextFieldWidget(
                  controller: languageController,
                  label: 'тил',
                  validator: 'Сураныч, тил жазыныз',
                  description: 'тил',
                  obscureText: false,
                ),
                TextFieldWidget(
                  controller: linkedinController,
                  label: 'Linkedin',
                  validator: 'Сураныч, Linkedin жазыныз',
                  description: 'Linkedin',
                  obscureText: false,
                ),
                TextFieldWidget(
                  controller: githubController,
                  label: 'Github',
                  validator: 'Сураныч, Github жазыныз',
                  description: 'Github',
                  obscureText: false,
                ),
                MainButton(
                  onPressed: () async {
                    uploadResume(context);
                    // StudentMainView.page();
                  },
                  text: 'Катталуу',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
