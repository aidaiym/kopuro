import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kopuro/app/bloc/app_bloc.dart';
import 'package:kopuro/export_files.dart';

class StudentProfileView extends StatelessWidget {
  const StudentProfileView({Key? key}) : super(key: key);
  static Route<void> route() {
    return MaterialPageRoute<void>(builder: (_) => const StudentProfileView());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text('Профиль'),
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () {
                Navigator.push<void>(
                  context,
                  MaterialPageRoute<void>(
                      builder: (BuildContext context) =>
                           const EditProfilePage()),
                );
              },
            ),
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
            String? userId =
                firebase_auth.FirebaseAuth.instance.currentUser?.uid;
            if (userId != null) {
              context.read<ProfileCubit>().fetchUserData(userId);
              return _buildContent(context, state);
            }

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
          children: <Widget>[
            Center(
              child: CircleAvatar(
                radius: 60,
                backgroundImage: state.userData!['photoUrl'] != null
                    ? NetworkImage(state.userData!['photoUrl'])
                    : const AssetImage('assets/images/avatar.png')
                        as ImageProvider,
              ),
            ),
            const SizedBox(height: 16),
            ListTile(
              title: Text(
                state.userData!['username'] ?? '',
                style: AppTextStyles.header3,
              ),
              subtitle: Text(
                state.userData!['jobTitle'] ?? '',
                style: AppTextStyles.header2,
              ),
            ),
            const SizedBox(height: 16),
            _buildSection('Email', state.userData!['email']),
            _buildSection('Phone Number', state.userData!['phoneNumber']),
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

  Widget _buildSection(String? title, String? content) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title ?? '', style: AppTextStyles.sectionTitle),
        Text(content ?? '', style: AppTextStyles.sectionContent),
        const SizedBox(height: 16),
      ],
    );
  }
}
