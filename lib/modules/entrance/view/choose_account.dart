import 'package:flutter/material.dart';
import 'package:kopuro/components/components.dart';

import '../../modules.dart';

class ChooseAccountType extends StatelessWidget {
  const ChooseAccountType({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        const Text('data'),
        const Text('data'),
        MainButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const SignUpStudentView()),
              );
            },
            text: ''),
        MainButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const SignUpStudentView()),
              );
            },
            text: 'text'),
      ]),
    );
  }
}
