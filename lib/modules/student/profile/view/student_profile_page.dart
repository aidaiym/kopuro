import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kopuro/export_files.dart';


class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});
  static Route<void> route() {
    return MaterialPageRoute<void>(builder: (_) => const ProfilePage());
  }

  @override
  Widget build(BuildContext context) {
     return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: BlocProvider<ProfileCubit>(
          create: (_) => ProfileCubit(),
          child: const StudentProfileWidget(),
        ),
      ),
    );
  }
}