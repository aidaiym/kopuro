import 'dart:developer';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kopuro/export_files.dart';

class ResumeBuilder extends StatelessWidget {
  const ResumeBuilder({super.key});
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
    final workExperience = TextEditingController();

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
          photoUrl: '',
          userLocation: locationController.text,
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

    Future<void> uploadImage() async {
      final picker = ImagePicker();
      final pickedFile = await picker.pickImage(source: ImageSource.gallery);

      if (pickedFile != null) {
        Reference storageReference = FirebaseStorage.instance
            .ref()
            .child('images/${DateTime.now().toString()}');
        UploadTask uploadTask = storageReference.putFile(File(pickedFile.path));
        await uploadTask.whenComplete(() => log('Image uploaded'));
      } else {
        log('No image selected.');
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
                      child: Text('Өткөрүп жиберүү',
                          style: AppTextStyles.white14.copyWith(fontSize: 12)),
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                Align(
                  alignment: Alignment.center,
                  child: GestureDetector(
                    onTap: uploadImage,
                    child: Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Icon(Icons.add_a_photo),
                    ),
                  ),
                ),
                TextFieldWidget(
                  controller: nameController,
                  label: 'Аты-жөнү ',
                  validator: 'Сураныч, Аты-жөнү жазыныз',
                  description: 'Аты-жөнү *',
                  obscureText: false,
                ),
                TextFieldWidget(
                  controller: phoneNumberController,
                  label: 'Телефон номери',
                  validator: 'Сураныч, Телефон номери жазыныз',
                  description: 'Телефон номери *',
                  obscureText: false,
                ),
                TextFieldWidget(
                  obscureText: false,
                  controller: jobController,
                  label: 'Сиздин кесибиңиз',
                  validator: 'Сураныч, кесибиңизди жазыныз',
                  description: 'Сиздин кесибиңиз *',
                ),
                TextFieldWidget(
                  obscureText: false,
                  controller: workExperience,
                  label: 'Иш тажрыйбаңыз тууралуу',
                  validator: 'Сураныч, иш тажрыйбаңызды жазыныз',
                  description: 'Иш тажрыйбаңыз тууралуу *',
                ),
                TextFieldWidget(
                  obscureText: false,
                  controller: skillsController,
                  label: 'Көндүмдөрүңүз',
                  validator: 'Сураныч, көндүмдөр жазыныз',
                  description: 'Көндүмдөрүңүз *',
                ),
                TextFieldWidget(
                  controller: locationController,
                  label: 'Жайгашкан жери',
                  description: 'Жайгашкан жери',
                  obscureText: false,
                ),
                TextFieldWidget(
                  controller: aboutController,
                  label: 'Мен тууралуу',
                  description: 'Мен тууралуу',
                  obscureText: false,
                ),
                TextFieldWidget(
                  obscureText: false,
                  controller: educationController,
                  label: 'Билимиңиз тууралуу жазыңыз',
                  description: 'Билимиңиз тууралуу',
                ),
                TextFieldWidget(
                  controller: languageController,
                  label: 'Тил',
                  description: 'Тил',
                  obscureText: false,
                ),
                TextFieldWidget(
                  controller: linkedinController,
                  label: 'Linkedin',
                  description: 'Linkedin',
                  obscureText: false,
                ),
                TextFieldWidget(
                  controller: githubController,
                  label: 'Github',
                  description: 'Github',
                  obscureText: false,
                ),
                MainButton(
                  onPressed: () async {
                    if (validateFields()) {
                      uploadResume(context);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                              'Сураныч, бардык талап кылынган талааларды толтуруңуз.'),
                        ),
                      );
                    }
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
