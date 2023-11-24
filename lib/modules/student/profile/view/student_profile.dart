import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kopuro/export_files.dart';

class StudentProfileView extends StatelessWidget {
  const StudentProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
          if (state is AuthSignedInState) {
            return _buildProfile(state.user as Users);
          } else {
            return const Center(child: Text('Error loading profile.'));
          }
        },
      ),
    );
  }

  Widget _buildProfile(Users user) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Username: ${user.username}'),
          Text('Email: ${user.email}'),
        ],
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
