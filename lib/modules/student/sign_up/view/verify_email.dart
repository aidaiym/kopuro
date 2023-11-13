import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kopuro/app/router/app_router.dart';
import 'package:kopuro/components/components.dart';
import 'package:kopuro/constants/contants.dart';

class VerifyEmailView extends StatelessWidget {
  const VerifyEmailView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Почтаңызды текшериңиз, сизге текшерүү үчүн ссылка жиберилди. Текшерүүдөн өткөн соң кийинки баскычын басыңыз! ',
                style: AppTextStyles.header4Black,
                textAlign: TextAlign.center,
              ),
            ),
            MainButton(
              onPressed: () async {
                final user = FirebaseAuth.instance.currentUser;
                if (user != null) {
                  await user.reload();
                  if (user.emailVerified) {
                    Navigator.pushNamed(context, AppRouter.resumeBuilder);
                  } else {
                    Navigator.pushNamed(context, AppRouter.signupStudent);
                  }
                } else {
                  print('No signed-in user');
                }
              },
              text: 'Кийинки',
            ),
          ],
        ),
      ),
    );
  }
}
