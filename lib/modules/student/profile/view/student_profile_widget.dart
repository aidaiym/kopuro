
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kopuro/app/bloc/app_bloc.dart';
import 'package:kopuro/export_files.dart';

class StudentProfileWidget extends StatelessWidget {
  const StudentProfileWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Профиль'),
        actions: <Widget>[
          IconButton(
            key: const Key('homePage_logout_iconButton'),
            icon: const Icon(Icons.exit_to_app),
            onPressed: () {
              context.read<AppBloc>().add(const AppLogoutRequested());
            },
          ),
        ],
      ),
        body: BlocBuilder<ProfileCubit, ProfileState>(
        builder: (context, state) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text('Name: ${state.userData['username']}'),
                Text('Email: ${state.userData['email']}'),
                // Add more fields as needed
              ],
            ),
          );
        },
      ),
    );
  }
}
