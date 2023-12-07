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
            icon: const Icon(Icons.settings),
            onPressed: () {},
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
          String? userId = firebase_auth.FirebaseAuth.instance.currentUser?.uid;
          if (userId != null) {
            context.read<ProfileCubit>().fetchUserData(userId);
            return _buildContent(context, state);
          } else {
            return const Center(
              child: Text('User not authenticated'),
            );
          }
        },
      ),
    );
  }

  Widget _buildContent(BuildContext context, ProfileState state) {
    if (state.userData.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    } else if (state.userData.containsKey('error')) {
      return Center(
        child: Text('Error fetching user data: ${state.userData['error']}'),
      );
    } else {
      return SingleChildScrollView(
  child: Padding(
    padding: const EdgeInsets.all(16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Center(
          child: CircleAvatar(
            radius: 60,
            backgroundImage: NetworkImage(state.userData['photoUrl'] ?? 'data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/2wCEAAkGBw8PDxUPDw8VFRUVFRUVDxUVFRUVFRUVFRUWFhUVFRUYHSggGBolHRUVITEhJSkrLi4uFx8zODMtNygtLisBCgoKDg0OGhAQFjclHSArNS0wLS0rNDMtLSstOCsrKzUrOC0tNystLS01LTgrLSstLTc0LSwrLS03LCsrKy0rLf/AABEIAOEA4QMBIgACEQEDEQH/xAAaAAEBAQEBAQEAAAAAAAAAAAAABQQBAwIG/8QAMhABAAEBBAcGBgIDAAAAAAAAAAECAwQFESExQVFxgcESIjJhkbFCUnKh0fAjM4Lh8f/EABkBAQEBAQEBAAAAAAAAAAAAAAACAQQDBf/EAB8RAQEAAwACAgMAAAAAAAAAAAABAgMRMTJBURITIv/aAAwDAQACEQMRAD8A/bgPR8kAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAHXAAAAAAAAAAAAAMh0BwAAAAAAAAAAfVnRNU5RGct1jhvzzyj8jZjb4TxaoulnHwxz0+71izpjVTHpDOvT9N+0AX5s6Z10x6Q8q7nZz8OXDQdLpv2ijfbYbOuic/KfyxVUzTOUxlPm153Gzy+QBgAAAAAAAAOAOgAAAAAAAPW72E2k5Rznc86YmZyjbohbu1jFFPZjnO+WVeGH5V2xsaaIypjjO2eL0BjpAAAAHlb2FNcZTynbD1As6hW9jVRVlPKd7zW73YRXTlt+GfNEnQ2ObPH8aANQAAAAAAAAAAAAAAAA24XZZ1TV8urjP7KoyYZTlZ575menRrTXTrnMQAWAAAAAAJOJWXZrzj4tPParMWK09yJ3T7/sERsncUsBTmAAAAAAMgAAAAAAAAAW7jH8dPDq9njcp/jp4PZLrx8QAGgAAAAADNiMfxTy94aWbEf6p5e8DMvWo4CnIAAAAAAAAAAAAAAAAsYbVnZx5TMffPq0p+E1+KnhMe09FBNdWF7jAAUAAAAAAMeKVdyI3z7RLYm4tX3op3Rn6/wDCI2XmLAApzAAAAAAAAAAAAAAAANFwtOzaR56PXV0WX55esLTtUxVvj77WV7ar8PsBj2AAAAAAES92narmfPKOWhWvVr2KJnlHGUNseO2/AA14gAAAAAAAAAAAAAAACjhVrronjHVOfVnXNNUVRsG45cvV8coriqImNU6YdS6wAAAAHza2kU0zVOwE7FLXOYojZpnjP792F2uqapmZ1zrcU5Mr29ABgAAAAABkGQAAAAAAAAAEgKOF2uuieMdVBHw/+2OefpKwmujVe4gA9AABOxS11URxnooo1+/sq5e0Eee28xZwFOcAAAAAAAAAAAAAAAAB2imZ0RGfDSDg12VwrnX3eOv0brvc6KNOud89IZ1eOu15Yddpp79WudUbobQY6MZycABoAAw4jdpq79P+UdW4GZY9nH54WLxcqK9Oqd8dYYbW4Wkau9w1+jeufLXYyjtVMxomMuOgahwAAAAADMAAAAkhWulyinTVGdX2gVjjcmCyuldWqMo3zoaqMM+ar0jrKgJ69pqxjPRcrOPhz46XvTERoiMuDoPSSTwAAAAAAAAAAAA5VTE6JjPi8LS42c7MuGhoBlkvlPrwz5avWOsMttdK6dcaN8aVoOourGvzwq3y5RVHapjKd2yf9pSnjljcQAScgzAAAa8Ns+1XnujPnsVmDCY0VT5xH76t6a6dc5iACwAAAAAAAAAAAAAAAAABIxGz7Np5Tp/Kun4tHhnjHsRGyfynAKczuQ5mAAAqYV4J+rpDax4V4J+rpDYmurD1gAKAAAAAAAAAAAAAAAAAAGHFvDTx6NzDi3hp4z7ETs9amAKcoABIAKmE+Cfq6Q2gmurD1gOgpwAAAAAAAAAAAAdAcAAAB1gxbw08egETs9amQ6CnK4AD/9k='),
          ),
        ),
        const SizedBox(height: 16),
        ListTile(
          title: Text(
            state.userData['username'],
            style: AppTextStyles.header3,
          ),
          subtitle: Text(
            state.userData['jobTitle'],
            style: AppTextStyles.header2,
          ),
        ),
        const SizedBox(height: 16),
        _buildSection('Email', state.userData['email']),
        _buildSection('Phone Number', state.userData['phoneNumber']),
        _buildSection('Education', state.userData['education']),
        _buildSection('Language', state.userData['language']),
        _buildSection('Skills', state.userData['skills']),
        _buildSection('Work Experience', state.userData['workExperience']),
        _buildSection('LinkedIn', state.userData['linkedIn']),
        _buildSection('Github', state.userData['github']),
      ],
    ),
  ),
);

Widget _buildSection(String title, String content) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(title, style: AppTextStyles.sectionTitle),
      Text(content, style: AppTextStyles.sectionContent),
      const SizedBox(height: 16),
    ],
  );
}
    }