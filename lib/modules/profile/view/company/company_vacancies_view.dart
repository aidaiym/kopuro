import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kopuro/export_files.dart';

class CompanyVacanciesView extends StatelessWidget {
  const CompanyVacanciesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right:16.0),
            child: CircleAvatar(
              child: IconButton(
                icon: const Icon(
                  Icons.person,
                  color: AppColors.main,
                ),
                onPressed: () {
                  Navigator.push<void>(
                    context,
                    MaterialPageRoute<void>(
                        builder: (BuildContext context) =>
                            const CompanyProfileView()),
                  );
                },
              ),
            ),
          ),
        ],
      ),
      body: BlocProvider(
        create: (context) => ProfileCubit()
          ..fetchUserData(FirebaseAuth.instance.currentUser!.uid),
        child: BlocBuilder<ProfileCubit, ProfileState>(
          builder: (context, state) {
            if (state is ProfileSuccessState) {
              return CompanyVacanciesSuccess(
                state: state,
              );
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
      ),
    );
  }
}

class CompanyVacanciesSuccess extends StatelessWidget {
  const CompanyVacanciesSuccess({super.key, required this.state});
  final ProfileState state;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  builder: (BuildContext context) {
                    return CreateVacancy(
                      companyName: state.userData!['username'],
                      contactNumber: state.userData!['phoneNumber'],
                    );
                  },
                );
              },
              child: Container(
                margin: const EdgeInsets.all(20),
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.main.withOpacity(0.1),
                        offset: const Offset(0, 2),
                      ),
                    ],
                    border: Border.all(color: AppColors.main, width: 2),
                    borderRadius: BorderRadius.circular(10)),
                child: Column(
                  children: [
                    Center(
                      child: Text(
                        ' Жаны вакансия кошуу +',
                        textAlign: TextAlign.center,
                        style: AppTextStyles.main19,
                      ),
                    ),
                    const SizedBox(height: 10),
                    SvgPicture.asset(
                      'assets/icons/new_vacancy.svg',
                      height: 100,
                    )
                  ],
                ),
              ),
            ),
            (state.userData!['vacancies'] != null &&
                    state.userData!['vacancies']!.isNotEmpty)
                ? Column(
                    children: [
                      const SizedBox(height: 20),
                      Text(
                        'Сиз кошкон вакансиялардын тизмеси:',
                        style: AppTextStyles.main18,
                      ),
                      const SizedBox(height: 20),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: state.userData!['vacancies']!.length,
                        itemBuilder: (BuildContext context, int index) {
                          var reference = state.userData!['vacancies']![index];

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
                              if (!snapshot.hasData || snapshot.data == null) {
                                return const Text('No Data');
                              }

                              var vacancyData =
                                  snapshot.data!.data() as Map<String, dynamic>;
                              Vacancy vacancies = Vacancy.fromJson(vacancyData);
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ListTile(
                                  leading: const SizedBox(
                                    width: 40,
                                    child: Icon(
                                      Icons.work_outline,
                                      color: AppColors.main,
                                    ),
                                  ),
                                  title: Text(
                                    vacancies.companyName,
                                    style: AppTextStyles.black19,
                                  ),
                                  subtitle: Text(vacancies.jobTitle),
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
                  )
                : Text(
                    'Азырынча сиздин комапниянын вакансиялары жок',
                    style: AppTextStyles.black19,
                  ),
          ],
        ),
      ),
    );
  }
}
