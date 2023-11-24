// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:kopuro/app/router/app_router.dart';
// import 'package:kopuro/components/components.dart';
// import 'package:kopuro/constants/contants.dart';

// class VerifyEmailView extends StatelessWidget {
//   const VerifyEmailView({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Text(
//                 'Почтаңызды текшериңиз, сизге текшерүү үчүн ссылка жиберилди. Текшерүүдөн өткөн соң кийинки баскычын басыңыз! ',
//                 style: AppTextStyles.header4Black,
//                 textAlign: TextAlign.center,
//               ),
//             ),
//             MainButton(
//               onPressed: () async {
//                 final user = FirebaseAuth.instance.currentUser;
//                 if (user != null) {
//                   await user.reload();
//                   if (user.emailVerified) {
//                     Navigator.pushNamed(context, AppRouter.resumeBuilder);
//                   } else {
//                     Navigator.pushNamed(context, AppRouter.signupStudent);
//                   }
//                 } else {
//                   print('No signed-in user');
//                 }
//               },
//               text: 'Кийинки',
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:kopuro/export_files.dart'; // Adjust the import based on your project structure

class VerifyEmailView extends StatelessWidget {
  const VerifyEmailView({Key? key}) : super(key: key);

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
              Text('Verify Your Email', style: AppTextStyles.header1),
              const SizedBox(height: 30),
              Text(
                'A verification email has been sent to your email address. Please check your inbox and click on the verification link.',
                style: AppTextStyles.header1,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  User? user = FirebaseAuth.instance.currentUser;
                  await user?.reload();
                  user = FirebaseAuth.instance.currentUser;
                  if (user?.emailVerified == true) {
                 Navigator.pushNamed(context, AppRouter.resumeBuilder);
                  } else {
                     Navigator.pushNamed(context, AppRouter.signupStudent);
                    print('Email not verified. You can provide an option to resend verification.');
                  }
                },
                child: const Text('Check Verification Status'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
