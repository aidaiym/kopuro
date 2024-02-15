import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kopuro/app/bloc/app_bloc.dart';
import 'package:kopuro/export_files.dart';

class StudentProfileView extends StatelessWidget {
  const StudentProfileView({super.key});
  static Route<void> route() {
    return MaterialPageRoute<void>(builder: (_) => const StudentProfileView());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text('Өздүк баракча', style: AppTextStyles.black19),
          actions: <Widget>[
            IconButton(
              icon: const Icon(
                Icons.edit_outlined,
                color: AppColors.main,
              ),
              onPressed: () {
                Navigator.push<void>(
                  context,
                  MaterialPageRoute<void>(
                      builder: (BuildContext context) =>
                          const EditStudentProfilePage()),
                );
              },
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 12.0),
              child: VerticalDivider(),
            ),
            IconButton(
              key: const Key('homePage_logout_iconButton'),
              icon: const Icon(
                Icons.logout_outlined,
                color: AppColors.main,
              ),
              onPressed: () {
                context.read<AppBloc>().add(const AppLogoutRequested());
              },
            ),
          ],
        ),
        body: BlocProvider(
          create: (context) => ProfileCubit()
            ..fetchUserData(
                firebase_auth.FirebaseAuth.instance.currentUser!.uid),
          child: BlocBuilder<ProfileCubit, ProfileState>(
            builder: (context, state) {
              if (state is ProfileSuccessState) {
                return _buildContent(context, state);
              } else if (state is ProfileErrorState) {
                return Center(
                  child: Text('Error fetching user data: ${state.message}'),
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        ));
  }

  Widget _buildContent(BuildContext context, ProfileState state) {
    if (state is ProfileLoadingState) {
      return const Center(child: CircularProgressIndicator());
    } else if (state is ProfileSuccessState) {
      return _buildSuccessContent(context, state);
    } else if (state is ProfileErrorState) {
      return Center(
        child: Text('Error fetching user data: ${state.message}'),
      );
    } else {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
  }

  Widget _buildSuccessContent(BuildContext context, ProfileSuccessState state) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Row(
              children: [
                Text(
                 '${state.userData!['username'] ?? ''} - ',
                  style: AppTextStyles.black20,
                ),
                Flexible(
                  child: Text(state.userData!['jobTitle'] ?? '',
                      style: AppTextStyles.main18),
                ),
              ],
            ),
            const SizedBox(height: 15),
            _buildSection('Email', state.userData!['email']),
            _buildSection('Phone Number', state.userData!['phoneNumber']),
            _buildSection('About me', state.userData!['aboutUser']),
            _buildSection('Education', state.userData!['education']),
            _buildSection('Language', state.userData!['language']),
            _buildSection('Skills', state.userData!['skills']),
            _buildSection('Work Experience', state.userData!['workExperience']),
            _buildSection('LinkedIn', state.userData!['linkedIn']),
            _buildSection('Github', state.userData!['github']),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(String title, String? content) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text('$title: ', style: AppTextStyles.main18),
          Flexible(child: Text(content ?? '', style: AppTextStyles.black16)),
        ],
      ),
    );
  }
}
