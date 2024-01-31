import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kopuro/app/bloc/app_bloc.dart';
import 'package:kopuro/export_files.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;

class CompanyProfileView extends StatelessWidget {
  const CompanyProfileView({super.key});

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
                          const EditProfilePage()),
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
            Text(
              '${state.userData!['username'] ?? ''} - ',
              style: AppTextStyles.black20,
            ),
            const SizedBox(height: 15),
            _buildSection('About company', state.userData!['aboutCompany']),
            _buildSection('Company Email', state.userData!['email']),
            _buildSection(
                'Company Contact Number', state.userData!['phoneNumber']),
            _buildSection(' webLinkCompany', state.userData!['webLinkCompany']),
            _buildSection('LinkedIn', state.userData!['linkedIn']),
            const SizedBox(height: 15),
            Text('Менин вакансияларым:', style: AppTextStyles.black19),
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
