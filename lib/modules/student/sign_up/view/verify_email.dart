import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kopuro/modules/modules.dart';
import 'package:kopuro/modules/student/sign_up/view/resume_builder.dart';

class VerifyEmailView extends StatelessWidget {
  const VerifyEmailView({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      if (user.emailVerified) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const ResumeBuilder()),
        );
      } else {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const SignUpStudentView()),
        );
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Email Verification'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Please check your email for a verification link.',
              style: TextStyle(fontSize: 18),
            ),
            TextButton(
              onPressed: () async {
                // Refresh the user
                await user?.reload();
                if (user != null) {
                  if (user.emailVerified) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ResumeBuilder()),
                    );
                  }
                }
              },
              child: const Text('Refresh'),
            ),
          ],
        ),
      ),
    );
  }
}
