import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kopuro/export_files.dart';

class StudentProfileView extends StatelessWidget {
  const StudentProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Student Profile'),
        actions: [
          IconButton(
            onPressed: () {
              _editProfile(context);
            },
            icon: const Icon(Icons.edit),
          ),
          IconButton(
            onPressed: () {
              _logout(context);
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: BlocBuilder<AuthCubit, AuthState>(
        builder: (context, state) {
          if (user != null) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Username: ${user.phoneNumber}'),
                  Text('Email: ${user.email}'),
                ],
              ),
            );
          } else {
            return const Center(child: Text('Error loading profile.'));
          }
        },
      ),
    );
  }

  void _editProfile(BuildContext context) {
    // Navigator.pushNamed(context, AppRouter.editProfile);
  }

  void _logout(BuildContext context) {
    context.read<AuthCubit>().logOut();
  }
}
