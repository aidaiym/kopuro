import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kopuro/export_files.dart';
import 'package:kopuro/l10n/l10.dart';

class ResumeBuilder extends StatelessWidget {
  const ResumeBuilder({super.key});

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
    final workExperience = TextEditingController();

    String? uploadedImageUrl;

    bool validateFields() {
      return nameController.text.isNotEmpty &&
          phoneNumberController.text.isNotEmpty &&
          jobController.text.isNotEmpty &&
          workExperience.text.isNotEmpty &&
          skillsController.text.isNotEmpty;
    }

    void uploadResume(BuildContext context) async {
      try {
        var user = FirebaseAuth.instance.currentUser;
        StudentUser student = StudentUser(
          id: user!.uid,
          email: user.email,
          createdTime: DateTime.now(),
          username: nameController.text,
          jobTitle: jobController.text,
          skills: skillsController.text,
          education: educationController.text,
          workExperience: workExperience.text,
          linkedIn: linkedinController.text,
          github: githubController.text,
          phoneNumber: phoneNumberController.text,
          aboutUser: aboutController.text,
          photoUrl: uploadedImageUrl,
          userLocation: locationController.text,
          language: languageController.text,
        );
        Map<String, dynamic> studentMap = student.toMapStudent();
        await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .update(studentMap);

        Navigator.pushReplacement(
          // ignore: use_build_context_synchronously
          context,
          MaterialPageRoute(
            builder: (context) => const StudentMainView(),
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
                Align(
                  alignment: Alignment.topRight,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const StudentMainView(),
                        ),
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 20),
                      decoration: BoxDecoration(
                        color: AppColors.main.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: Text(AppLocalizations.of(context).skip,
                          style: AppTextStyles.white14.copyWith(fontSize: 12)),
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                BlocBuilder<ProfileCubit, ProfileState>(
                  builder: (context, state) {
                    uploadedImageUrl = state.uploadedImageUrl;
                    return UploadImageWidget(
                      onTap: () => context.read<ProfileCubit>().uploadImage(),
                      state: state,
                    );
                  },
                ),
                TextFieldWidget(
                  controller: nameController,
                  label: AppLocalizations.of(context).fullName,
                  validator: AppLocalizations.of(context).nameErrorText,
                  description: '${AppLocalizations.of(context).fullName} *',
                  obscureText: false,
                ),
                TextFieldWidget(
                  controller: phoneNumberController,
                  label: AppLocalizations.of(context).phoneNumber,
                  validator: AppLocalizations.of(context).numberErrorText,
                  description: '${AppLocalizations.of(context).phoneNumber} *',
                  obscureText: false,
                ),
                TextFieldWidget(
                  obscureText: false,
                  controller: jobController,
                  label: AppLocalizations.of(context).jobTitle,
                  validator: AppLocalizations.of(context).jobValidator,
                  description: '${AppLocalizations.of(context).jobTitle} *',
                ),
                TextFieldWidget(
                  obscureText: false,
                  controller: workExperience,
                  label: AppLocalizations.of(context).workExperienceLabel,
                  validator:
                      AppLocalizations.of(context).workExperienceValidator,
                  description:
                      '${AppLocalizations.of(context).workExperienceLabel} *',
                ),
                TextFieldWidget(
                  obscureText: false,
                  controller: skillsController,
                  label: AppLocalizations.of(context).skillsLabel,
                  validator: AppLocalizations.of(context).skillsValidator,
                  description: '${AppLocalizations.of(context).skillsLabel} *',
                ),
                TextFieldWidget(
                  controller: locationController,
                  label: AppLocalizations.of(context).locationLabel,
                  description: AppLocalizations.of(context).locationLabel,
                  obscureText: false,
                ),
                TextFieldWidget(
                  controller: aboutController,
                  label: AppLocalizations.of(context).aboutLabel,
                  description: AppLocalizations.of(context).aboutLabel,
                  obscureText: false,
                ),
                TextFieldWidget(
                  obscureText: false,
                  controller: educationController,
                  label: AppLocalizations.of(context).educationLabel,
                  description: AppLocalizations.of(context).educationLabel,
                ),
                TextFieldWidget(
                  controller: languageController,
                  label: AppLocalizations.of(context).languageLabel,
                  description: AppLocalizations.of(context).languageLabel,
                  obscureText: false,
                ),
                TextFieldWidget(
                  controller: linkedinController,
                  label: AppLocalizations.of(context).linkedinLabel,
                  description: AppLocalizations.of(context).linkedinLabel,
                  obscureText: false,
                ),
                TextFieldWidget(
                  controller: githubController,
                  label: AppLocalizations.of(context).githubLabel,
                  description: AppLocalizations.of(context).githubLabel,
                  obscureText: false,
                ),
                MainButton(
                  onPressed: () async {
                    if (validateFields()) {
                      uploadResume(context);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                            content: Text(
                          AppLocalizations.of(context).submitErrorMessage,
                        )),
                      );
                    }
                  },
                  text: AppLocalizations.of(context).submitButton,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
