import 'package:flutter/material.dart';
import 'package:kopuro/export_files.dart';

class CandidatesDetailView extends StatelessWidget {
  const CandidatesDetailView({super.key, required this.candidate});
  final StudentUser candidate;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(candidate.username),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                sectionText('Компания', candidate.username),
                sectionText('Эмгек акы', candidate.email),
                sectionText('Байланыш маалыматы', candidate.aboutUser!),
                sectionText('Жумуш жөнүндө', candidate.education!),
                sectionText('Жумуштун түрү', candidate.github!),
                sectionText('Жайгашкан жери', candidate.linkedIn!),
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
