import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kopuro/components/components.dart';
import 'package:kopuro/constants/contants.dart';
import '../../../modules.dart';
import 'resume_builder.dart';

class VerifyEmailView extends StatelessWidget {
  const VerifyEmailView({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    return Scaffold(
        body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              textAlign: TextAlign.center,
              'Почтаңызды текшериңиз, сизге текшерүү үчүн ссылка жиберилди. Текшерүүдөн өткөн соң кийинки баскычын басыңыз! ',
              style: AppTextStyles.header4Black,
            ),
          ),
          MainButton(
            onPressed: () async {
              user!.reload();
              if (user.emailVerified) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ResumeBuilder()),
                );
              } else {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const SignUpStudentView()),
                );
              }
            },
            text: 'Кийинки',
          ),
        ],
      ),
    ));
  }
}
