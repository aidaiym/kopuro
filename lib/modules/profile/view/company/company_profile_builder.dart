import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kopuro/export_files.dart';

class CompanyProfileBuilder extends StatelessWidget {
  const CompanyProfileBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    final nameOfCompanyController = TextEditingController();
    final aboutCompanyController = TextEditingController();
    final locationOfCompanyController = TextEditingController();
    final contactNumberController = TextEditingController();
    final webLinkController = TextEditingController();
    final linkedinController = TextEditingController();
    String? uploadedImageUrl;

    void uploadCompanyProfile(BuildContext context) async {
      try {
        var user = FirebaseAuth.instance.currentUser;
        CompanyUser companyUser = CompanyUser(
          username: nameOfCompanyController.text,
          webLinkCompany: webLinkController.text,
          linkedIn: linkedinController.text,
          phoneNumber: contactNumberController.text,
          aboutCompany: aboutCompanyController.text,
          photoUrl: uploadedImageUrl,
          userLocation: locationOfCompanyController.text,
        );

        Map<String, dynamic> companyMap = companyUser.toMapCompany();
        await FirebaseFirestore.instance
            .collection('users')
            .doc(user?.uid)
            .update(companyMap);

        Navigator.pushReplacement(
          // ignore: use_build_context_synchronously
          context,
          MaterialPageRoute(
            builder: (context) => const CompanyMainView(),
          ),
        );
      } catch (e) {
        log('Error uploading company profile: $e');
      }
    }

    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(40.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const CompanyMainView(),
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
                  controller: nameOfCompanyController,
                  label: 'Компаниянын аты',
                  validator: 'Сураныч, Компаниянын аталышын  жазыңыз',
                  description: 'Компаниянын аты',
                  obscureText: false,
                ),
                TextFieldWidget(
                  controller: aboutCompanyController,
                  label: 'Компания тууралуу',
                  validator: 'Сураныч, Компания жөнүндө жазыңыз',
                  description: 'Компания тууралуу',
                  obscureText: false,
                ),
                TextFieldWidget(
                  controller: locationOfCompanyController,
                  label: 'Компаниянын жайгашкан жери',
                  validator: 'Сураныч, Компаниянын жайгашкан жерин жазыңыз',
                  description: 'Компаниянын жайгашкан жери',
                  obscureText: false,
                ),
                TextFieldWidget(
                  controller: contactNumberController,
                  label: 'Компаниянын байланыш номери',
                  validator: 'Сураныч, Компаниянын байланыш номерин жазыңыз',
                  description: 'Компаниянын байланыш номери',
                  obscureText: false,
                ),
                TextFieldWidget(
                  controller: webLinkController,
                  label: 'Компаниянын web-site',
                  validator: 'Сураныч, Компаниянын web-site жазыныз',
                  description: 'Компаниянын web-site',
                  obscureText: false,
                ),
                TextFieldWidget(
                  controller: linkedinController,
                  label: 'Linkedin',
                  validator: 'Сураныч, Компаниянын  Linkedin жазыныз',
                  description: 'Linkedin',
                  obscureText: false,
                ),
                MainButton(
                  onPressed: () async {
                    uploadCompanyProfile(context);
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
