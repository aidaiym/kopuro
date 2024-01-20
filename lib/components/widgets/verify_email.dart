import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:kopuro/export_files.dart';

class VerifyEmailView extends StatelessWidget {
  const VerifyEmailView({Key? key}) : super(key: key);

  static Route<void> route() {
    return MaterialPageRoute<void>(builder: (_) => const VerifyEmailView());
  }

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
                'Электрондук почтаңызды текшериңиз',
                style: AppTextStyles.sectionTitle,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30),
              Text(
                'Сиздин электрондук почтаңызга текшерүү шилтемеси  жөнөтүлдү. Сураныч, почтаңызды текшерип,  шилтемени басыңыз.',
                style: AppTextStyles.main14,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              MainButton(
                  onPressed: () async {
                    User? user = FirebaseAuth.instance.currentUser;
                    await user?.reload();
                    user = FirebaseAuth.instance.currentUser;

                    if (user?.emailVerified == true) {
                      // ignore: use_build_context_synchronously
                      Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (context) => const ResumeBuilder()),
                      );
                    } else {
                      FirebaseAuth.instance
                          .authStateChanges()
                          .listen((User? user) {
                        if (user?.emailVerified == true) {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (context) => const ResumeBuilder()),
                          );
                        } else {
                          log(
                              'Email not verified. You can provide an option to resend verification.');
                        }
                      });
                    }
                  },
                  text: 'Текшерүү')
            ],
          ),
        ),
      ),
    );
  }
}
