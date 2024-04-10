import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kopuro/export_files.dart';
import 'package:kopuro/l10n/l10.dart';

class VacancyDetail extends StatelessWidget {
  const VacancyDetail(
      {super.key, required this.vacancy, this.isCompany = false});
  final Vacancy vacancy;
  final bool isCompany;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              ClipOval(
                child: Image.network(
                  vacancy.companyPhoto ??
                      'https://firebasestorage.googleapis.com/v0/b/kopuro-5fe2a.appspot.com/o/images%2Fapple_logo.jpeg?alt=media&token=bd03861d-565d-4dc4-8ca6-5686cb560c3b',
                  width: 100,
                  height: 100,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                vacancy.jobTitle,
                style: AppTextStyles.black20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    vacancy.companyName,
                    style: AppTextStyles.primary13,
                  ),
                  Text(
                    ' • ',
                    style: AppTextStyles.black20,
                  ),
                  Text(
                    vacancy.jobType,
                    style: AppTextStyles.main14,
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: const Color(0xffEAECEE),
                        ),
                        padding: const EdgeInsets.all(15),
                        child: Image.asset(
                          'assets/icons/mon.png',
                          width: 30,
                        ),
                      ),
                      const SizedBox(height: 1),
                      Text(
                        AppLocalizations.of(context).jobSalary,
                        style: AppTextStyles.primary13,
                      ),
                      const SizedBox(height: 3),
                      Text(
                        '\$ ${vacancy.salary}',
                        style: AppTextStyles.primary13,
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: const Color(0xffEAECEE),
                        ),
                        padding: const EdgeInsets.all(15),
                        child: Image.asset(
                          'assets/icons/locat.png',
                          width: 30,
                          height: 30,
                        ),
                      ),
                      const SizedBox(
                        height: 1,
                      ),
                      Text(
                        AppLocalizations.of(context).location,
                        style: AppTextStyles.primary13,
                      ),
                      const SizedBox(height: 2),
                      Text(
                        vacancy.location,
                        style: AppTextStyles.primary13,
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: const Color(0xffEAECEE),
                        ),
                        padding: const EdgeInsets.all(15),
                        child: Image.asset(
                          'assets/icons/phone.png',
                          width: 30,
                          height: 30,
                        ),
                      ),
                      const SizedBox(
                        height: 1,
                      ),
                      Text(
                        AppLocalizations.of(context).phoneNumber,
                        style: AppTextStyles.primary13,
                      ),
                      const SizedBox(height: 2),
                      Text(
                        vacancy.contactInformation,
                        style: AppTextStyles.primary13,
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 30),
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  AppLocalizations.of(context).jobDescription,
                  style: AppTextStyles.black19,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                vacancy.jobDescription,
                style: AppTextStyles.black16,
              ),
              const SizedBox(height: 40),
              if (!isCompany)
                MainButton(
                  onPressed: () async {
                    try {
                      var user = FirebaseAuth.instance.currentUser;
                      FirebaseFirestore.instance
                          .collection('vacancies')
                          .doc(vacancy.id)
                          .update(({
                            'appliedUsers': FieldValue.arrayUnion([user!.uid])
                          }));

                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title:
                                Text(AppLocalizations.of(context).successTitle),
                            content: Text(
                                AppLocalizations.of(context).successContent),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const StudentMainView(),
                                    ),
                                  );
                                },
                                child: const Text('OK'),
                              ),
                            ],
                          );
                        },
                      );
                    } catch (e) {
                      log('Error applying to the vacancy: $e');
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text(AppLocalizations.of(context).error),
                            content: Text(
                              AppLocalizations.of(context)
                                  .errorApplyingToVacancy,
                            ),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Text('OK'),
                              ),
                            ],
                          );
                        },
                      );
                    }
                  },
                  text: AppLocalizations.of(context).applyToVacancy,
                ),
              if (isCompany)
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${AppLocalizations.of(context).candidates} :',
                        style: AppTextStyles.main18,
                      ),
                      if (vacancy.appliedUsers != null)
                        Expanded(
                          child: ListView.builder(
                            itemCount: vacancy.appliedUsers!.length,
                            itemBuilder: (context, index) {
                              final candidates = vacancy.appliedUsers![index];
                              return Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(10)),
                                    border: const Border(
                                      left: BorderSide(
                                        color: Color.fromARGB(255, 31, 12, 89),
                                        width: 10.0,
                                      ),
                                    ),
                                    color: index % 2 == 0
                                        ? const Color(0xffD6E0FF)
                                            .withOpacity(0.4)
                                        : const Color(0xffF1ECFF)
                                            .withOpacity(0.7),
                                  ),
                                  child: ListTile(
                                    onTap: () {
                                      Navigator.push<void>(
                                        context,
                                        MaterialPageRoute<void>(
                                          builder: (BuildContext context) =>
                                              CandidatesDetailView(
                                                  candidate: candidates),
                                        ),
                                      );
                                    },
                                    contentPadding: const EdgeInsets.all(10),
                                    leading: ClipOval(
                                      child: Image.network(
                                        candidates.photoUrl ??
                                            'https://firebasestorage.googleapis.com/v0/b/kopuro-5fe2a.appspot.com/o/images%2F6596121.png?alt=media&token=1f751e91-a606-4e7b-85fe-02b2faf423aa',
                                        width: 60,
                                        height: 60,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    title: Text(
                                      candidates.username,
                                      style: AppTextStyles.black19,
                                    ),
                                    subtitle: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          candidates.jobTitle!,
                                          style: AppTextStyles.black16,
                                        ),
                                        Row(
                                          children: [
                                            const Icon(Icons.code),
                                            const SizedBox(width: 4),
                                            Text(
                                              candidates.skills ?? 'Progamming',
                                              style: AppTextStyles.primary13,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    trailing: const Icon(Icons.navigate_next),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      Text(
                        AppLocalizations.of(context).candidatesEmpty,
                        style: AppTextStyles.black16,
                      ),
                    ],
                  ),
                )
            ],
          ),
        ),
      ),
    );
  }

  Container sectionText(String title, String content) {
    return Container(
      padding: const EdgeInsets.only(top: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('$title: ', style: AppTextStyles.main18),
          const SizedBox(width: 10),
          Flexible(child: Text(content, style: AppTextStyles.black16)),
        ],
      ),
    );
  }
}
