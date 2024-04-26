import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kopuro/app/bloc/app_bloc.dart';
import 'package:kopuro/export_files.dart';
import 'package:kopuro/l10n/l10.dart';

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
          title: Text(
            AppLocalizations.of(context).userProfile,
            style: AppTextStyles.black19,
          ),
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
            ..fetchUserData(
                firebase_auth.FirebaseAuth.instance.currentUser!.uid),
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
        ));
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
            Row(
              children: [
                ClipOval(
                  child: Image.network(
                    '${state.userData!['photoUrl'] ?? 'https://firebasestorage.googleapis.com/v0/b/kopuro-5fe2a.appspot.com/o/images%2F6596121.png?alt=media&token=1f751e91-a606-4e7b-85fe-02b2faf423aa'}',
                    width: 150,
                    height: 150,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(width: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${state.userData!['username'] ?? ''}',
                      style: AppTextStyles.black22,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      state.userData!['jobTitle'] ?? '',
                      style: AppTextStyles.main18,
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        const Icon(Icons.location_on_outlined),
                        Text(
                          state.userData!['location'] ?? '',
                          style: AppTextStyles.black14,
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 30),
            Text(
              state.userData!['aboutUser'] ?? '',
              style: AppTextStyles.black16,
            ),
            const SizedBox(height: 30),
            Text(
              AppLocalizations.of(context).skillsLabel,
              style: AppTextStyles.main18,
            ),
            const SizedBox(height: 5),
            Row(
              children: [
                const Icon(Icons.code),
                const SizedBox(width: 10),
                Text(
                  state.userData!['skills'] ?? '',
                  style: AppTextStyles.black16,
                ),
                const SizedBox(width: 10),
              ],
            ),
            const SizedBox(height: 30),
            Text(
              AppLocalizations.of(context).languageLabel,
              style: AppTextStyles.main18,
            ),
            const SizedBox(height: 5),
            Row(
              children: [
                const Icon(Icons.language),
                const SizedBox(width: 10),
                Text(
                  state.userData!['language'] ?? '',
                  style: AppTextStyles.black16,
                ),
                const SizedBox(width: 10),
              ],
            ),
            const SizedBox(height: 30),
            Text(
              AppLocalizations.of(context).education,
              style: AppTextStyles.main18,
            ),
            const SizedBox(height: 5),
            Row(
              children: [
                const Icon(Icons.school),
                const SizedBox(width: 10),
                Flexible(
                  child: Text(
                    state.userData!['education'] ?? '',
                    style: AppTextStyles.black16,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),
            Text(
              AppLocalizations.of(context).workExperience,
              style: AppTextStyles.main18,
            ),
            const SizedBox(height: 5),
            Row(
              children: [
                const Icon(Icons.work_outline),
                const SizedBox(width: 10),
                Flexible(
                  child: Text(
                    state.userData!['workExperience'] ?? '',
                    style: AppTextStyles.black16,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),
            Text(
              AppLocalizations.of(context).contactInformation,
              style: AppTextStyles.main18,
            ),
            const SizedBox(height: 5),
            Row(
              children: [
                const Icon(Icons.email),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  state.userData!['email'] ?? '',
                  style: AppTextStyles.black16,
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                const Icon(Icons.phone),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  state.userData!['phoneNumber'] ?? '',
                  style: AppTextStyles.black16,
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                SvgPicture.asset(
                  'assets/icons/github.svg',
                  width: 25,
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  state.userData!['linkedIn'] ?? '',
                  style: AppTextStyles.black16,
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                SvgPicture.asset(
                  'assets/icons/linkedin.svg',
                  width: 25,
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  state.userData!['github'] ?? '',
                  style: AppTextStyles.black16,
                ),
              ],
            ),
            const SizedBox(height: 40),
            Text(
              AppLocalizations.of(context).appliedVacancies,
              style: AppTextStyles.main18,
            ),
            (state.userData!['appliedVacancies'] != null &&
                    state.userData!['appliedVacancies']!.isNotEmpty)
                ? Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 20),
                        Text(
                          '${AppLocalizations.of(context).yourVacancyList} : ',
                          style: AppTextStyles.main18,
                        ),
                        const SizedBox(height: 10),
                        ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount:
                              state.userData!['appliedVacancies']!.length,
                          itemBuilder: (BuildContext context, int index) {
                            var reference = FirebaseFirestore.instance.collection('users').doc(state.userData!['appliedVacancies']![index]);
                           
                            return FutureBuilder<DocumentSnapshot>(
                              future: reference.get(),
                              builder: (BuildContext context,
                                  AsyncSnapshot<DocumentSnapshot> snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return const Center(
                                      child: CircularProgressIndicator());
                                }
                                if (snapshot.hasError) {
                                  return Text('Error: ${snapshot.error}');
                                }
                                if (!snapshot.hasData ||
                                    snapshot.data == null) {
                                  return const Text('No Data');
                                }

                                var vacancyData = snapshot.data!.data()
                                    as Map<String, dynamic>;
                                Vacancy vacancies =
                                    Vacancy.fromJson(vacancyData);
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: ListTile(
                                    leading: CircleAvatar(
                                      backgroundImage: NetworkImage(
                                          state.userData!['photoUrl']),
                                    ),
                                    title: Text(
                                      vacancies.jobTitle,
                                      style: AppTextStyles.black19,
                                    ),
                                    subtitle: Text(
                                      '${AppLocalizations.of(context).candidates}  ${vacancies.appliedUsers == null ? 0 : vacancies.appliedUsers!.length}',
                                    ),
                                    trailing: const Icon(Icons.navigate_next),
                                    shape: RoundedRectangleBorder(
                                      side: const BorderSide(
                                          color: AppColors.inActive),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    onTap: () {
                                      Navigator.push<void>(
                                        context,
                                        MaterialPageRoute<void>(
                                          builder: (BuildContext context) =>
                                              VacancyDetail(
                                            isCompany: true,
                                            vacancy: vacancies,
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                );
                              },
                            );
                          },
                        ),
                      ],
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      AppLocalizations.of(context).noYourVacancy,
                      style: AppTextStyles.black19,
                      textAlign: TextAlign.center,
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
