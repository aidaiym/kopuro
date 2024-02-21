import 'package:flutter/material.dart';
import 'package:kopuro/export_files.dart';

class CandidatesDetailView extends StatelessWidget {
  const CandidatesDetailView({super.key, required this.candidate});
  final StudentUser candidate;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(candidate.jobTitle ?? ''),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                sectionText('Аты-жөнү', candidate.username),
                sectionText('Өзү жөнүндө', candidate.aboutUser!),
                sectionText('Билими', candidate.education!),
                sectionText('Иш тажрыйбасы', candidate.workExperience!),
                sectionText('Көндүмдөрү', candidate.skills!),
                sectionText('Жайгашкан жери', candidate.userLocation!),
                const SizedBox(height: 25),
                Text(
                  'Байланыш маалыматтары: ',
                  style: AppTextStyles.black19,
                ),
                sectionText('email', candidate.email),
                sectionText('Телефон номери', candidate.phoneNumber!),
                sectionText('Github', candidate.github!),
                sectionText('Linkedin', candidate.linkedIn!),
                const SizedBox(height: 40),
              ]),
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
