import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kopuro/components/components.dart';
import 'package:kopuro/modules/modules.dart';

class StudentProfile extends StatelessWidget {
  const StudentProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Student Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.settings),
                ),
                ElevatedButton(
                    onPressed: () {},
                    child: const Row(
                      children: [
                        Icon(Icons.history),
                        Text('Applied Companies'),
                      ],
                    )),
              ],
            ),
            const Divider(),
            const CircleAvatar(
              radius: 50.0,
              backgroundImage: NetworkImage('photoUrl'),
            ),
            const SizedBox(height: 16.0),
            const UserInfoItem(label: 'Email', value: 'user@example.com'),
            const UserInfoItem(label: 'Username', value: 'John Doe'),
            const UserInfoItem(label: 'Phone Number', value: '+123456789'),
            const UserInfoItem(
                label: 'About Me', value: 'I am a passionate student.'),
            const UserInfoItem(label: 'Job Title', value: 'Software Developer'),
            const UserInfoItem(
                label: 'Skills', value: 'Flutter, Dart, Firebase'),
            const UserInfoItem(label: 'Location', value: 'City, Country'),
            const SizedBox(height: 16.0),
            const SizedBox(height: 16.0),
            MainButton(
              onPressed: () {
                FirebaseAuth.instance.signOut();
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SignInView()),
                );
              },
              text: 'Logout',
            ),
          ],
        ),
      ),
    );
  }
}

class UserInfoItem extends StatelessWidget {
  final String label;
  final String value;

  const UserInfoItem({Key? key, required this.label, required this.value})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
          Text(value),
        ],
      ),
    );
  }
}
