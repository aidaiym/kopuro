import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:kopuro/export_files.dart';
import 'package:kopuro/l10n/l10.dart';

class VerifyEmailView extends StatelessWidget {
  const VerifyEmailView({super.key, required this.isStudent});
  final bool isStudent;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      backgroundColor: AppColors.backgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                AppLocalizations.of(context).verifyEmailLink,
                style: AppTextStyles.main18,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30),
              Text(
                AppLocalizations.of(context).verifyEmailLinkText,
                style: AppTextStyles.main14,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              MainButton(
                onPressed: () async {
                  firebase_auth.User? user = FirebaseAuth.instance.currentUser;
                  await user?.reload();
                  if (user?.emailVerified == true) {
                    if (isStudent) {
                      // ignore: use_build_context_synchronously
                      Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (context) => const ResumeBuilder()),
                      );
                      StudentUser student = StudentUser(
                        id: user?.uid ?? '',
                        email: user?.email ?? '',
                        createdTime: DateTime.now(),
                        userType: UserType.student,
                      );

                      Map<String, dynamic> studentMap = student.toMapStudent();
                      FirebaseFirestore.instance
                          .collection('users')
                          .doc(user?.uid)
                          .set(studentMap, SetOptions(merge: true));
                    } else {
                      // ignore: use_build_context_synchronously
                      Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (context) =>
                                const CompanyProfileBuilder()),
                      );
                      CompanyUser company = CompanyUser(
                        id: user?.uid ?? '',
                        email: user?.email ?? '',
                        createdTime: DateTime.now(),
                        userType: UserType.company,
                      );

                      Map<String, dynamic> companyMap = company.toMap();
                      FirebaseFirestore.instance
                          .collection('users')
                          .doc(user?.uid)
                          .set(companyMap, SetOptions(merge: true));
                    }
                  } else {
                    log('Email not verified. You can provide an option to resend verification.');
                    // ignore: use_build_context_synchronously
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                            'Email not verified. You can provide an option to resend verification.'),
                      ),
                    );
                  }
                },
                text: AppLocalizations.of(context).verify,
              )
            ],
          ),
        ),
      ),
    );
  }
}
