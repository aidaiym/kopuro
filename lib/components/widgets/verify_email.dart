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
          padding: const EdgeInsets.all(40.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('Электрондук почтаңызды текшериңиз',
                  style: AppTextStyles.header1),
              const SizedBox(height: 30),
              Text(
                'Сиздин электрондук почтаңызга текшерүү шилтемеси  жөнөтүлдү. Сураныч, почтаңызды текшерип, текшерүү шилтемесин басыңыз.',
                style: AppTextStyles.header1,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  User? user = FirebaseAuth.instance.currentUser;
                  await user?.reload();
                  user = FirebaseAuth.instance.currentUser;
                  if (user?.emailVerified == true) {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                          builder: (context) => const ResumeBuilder()),
                    );
                    //  Navigator.pushNamed(context, AppRouter.resumeBuilder);
                  }
                  // else {
                  //     Navigator.of(context).push(
                  //             MaterialPageRoute(
                  //                 builder: (context) => const StudentSignUpPage()),
                  //           );
                  //   //  Navigator.pushNamed(context, AppRouter.signupStudent);
                  //   print('Email not verified. You can provide an option to resend verification.');
                  // }
                },
                child: const Text('Текшерүү'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
