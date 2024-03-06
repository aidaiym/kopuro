import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kopuro/app/bloc/app_bloc.dart';
import 'package:kopuro/export_files.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:kopuro/l10n/l10.dart';

class CompanyProfileView extends StatelessWidget {
  const CompanyProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).profile,
            style: AppTextStyles.black19),
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
                        const EditCompanyProfilePage()),
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
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    content: Text(
                      AppLocalizations.of(context).logout,
                      style: AppTextStyles.black19,
                      textAlign: TextAlign.center,
                    ),
                    actions: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text(AppLocalizations.of(context).no),
                          ),
                          TextButton(
                            onPressed: () {
                              context
                                  .read<AppBloc>()
                                  .add(const AppLogoutRequested());
                              Navigator.of(context).pop();
                            },
                            child: Text(
                              AppLocalizations.of(context).yes,
                              style: AppTextStyles.errorText,
                            ),
                          ),
                        ],
                      )
                    ],
                  );
                },
              );
            },
          ),
        ],
      ),
      body: BlocProvider(
        create: (context) => ProfileCubit()
          ..fetchUserData(firebase_auth.FirebaseAuth.instance.currentUser!.uid),
        child: BlocBuilder<ProfileCubit, ProfileState>(
          builder: (context, state) {
            if (state is ProfileSuccessState) {
              return _buildContent(context, state);
            } else if (state is ProfileErrorState) {
              return Center(
                child: Text(
                    '${AppLocalizations.of(context).errorFetchingUserData}: ${state.message}'),
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context, ProfileState state) {
    if (state is ProfileLoadingState) {
      return const Center(child: CircularProgressIndicator());
    } else if (state is ProfileSuccessState) {
      return _buildSuccessContent(context, state);
    } else if (state is ProfileErrorState) {
      return Center(
        child: Text(
            '${AppLocalizations.of(context).errorFetchingUserData}: ${state.message}'),
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
            _buildSection(
              AppLocalizations.of(context).aboutCompany,
              state.userData!['aboutCompany'],
            ),
            _buildSection(
              AppLocalizations.of(context).companyEmail,
              state.userData!['email'],
            ),
            _buildSection(
              AppLocalizations.of(context).companyContactNumber,
              state.userData!['phoneNumber'],
            ),
            _buildSection(
              AppLocalizations.of(context).companyLocation,
              state.userData!['location'],
            ),
            _buildSection(
              AppLocalizations.of(context).webLinkCompany,
              state.userData!['webLinkCompany'],
            ),
              _buildSection(
              AppLocalizations.of(context).linkedin,
              state.userData!['linkedIn'],
            ),
            const SizedBox(height: 15),
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
