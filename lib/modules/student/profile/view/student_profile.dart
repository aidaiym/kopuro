import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kopuro/components/components.dart';
import 'package:kopuro/modules/modules.dart';

class StudentProfile extends StatelessWidget {
  const StudentProfile({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Center(child: Text('Student Profile')),
          MainButton(
              onPressed: () {
                FirebaseAuth.instance.signOut();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const SignInView()),
                );
              },
              text: 'чыгуу')
        ],
      ),
    );
  }
}
