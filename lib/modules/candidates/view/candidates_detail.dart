import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kopuro/export_files.dart';
import 'package:kopuro/l10n/l10.dart';

class CandidatesDetailView extends StatelessWidget {
  const CandidatesDetailView({super.key, required this.candidate});
  final StudentUser candidate;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    ClipOval(
                      child: Image.network(
                        candidate.photoUrl ??
                            'https://firebasestorage.googleapis.com/v0/b/kopuro-5fe2a.appspot.com/o/images%2F6596121.png?alt=media&token=1f751e91-a606-4e7b-85fe-02b2faf423aa',
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
                          candidate.username,
                          style: AppTextStyles.black19,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          candidate.jobTitle ?? '',
                          style: AppTextStyles.main18,
                        ),
                        const SizedBox(height: 20),
                        Row(
                          children: [
                            const Icon(Icons.location_on_outlined),
                            Text(
                              candidate.userLocation ?? '',
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
                  candidate.aboutUser ?? '',
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
                      candidate.skills ?? '',
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
                      candidate.language ?? '',
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
                        candidate.education ?? '',
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
                        candidate.workExperience ?? '',
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
                      candidate.email,
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
                      candidate.phoneNumber ?? '',
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
                      candidate.linkedIn ?? '',
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
                      candidate.github ?? '',
                      style: AppTextStyles.black16,
                    ),
                  ],
                ),
                const SizedBox(height: 40),
              ]),
        ),
      ),
    );
  }
}
