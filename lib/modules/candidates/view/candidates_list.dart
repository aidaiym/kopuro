import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kopuro/export_files.dart';
import 'package:kopuro/l10n/l10.dart';

class CandidatesListView extends StatelessWidget {
  const CandidatesListView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CandidatesCubit()..loadCandidates(),
      child: Scaffold(
        body: BlocBuilder<CandidatesCubit, CandidatesState>(
          builder: (context, state) {
            if (state is CandidatesLoaded) {
              return SafeArea(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        onChanged: (query) {
                          context
                              .read<CandidatesCubit>()
                              .filterCandidates(query);
                        },
                        decoration: InputDecoration(
                          labelText: AppLocalizations.of(context).search,
                          prefixIcon: const Icon(Icons.search),
                          border: const OutlineInputBorder(),
                        ),
                      ),
                    ),
                    Expanded(
                        child: ListView.builder(
                      itemCount: state.candidates.length,
                      itemBuilder: (context, index) {
                        final candidates = state.candidates[index];

                        return Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Container(
                              decoration: BoxDecoration(
                                color: AppColors.main.withOpacity(0.05),
                                borderRadius: BorderRadius.circular(15),
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
                                leading: CircleAvatar(
                                  child: Image.asset(
                                    'assets/images/avatar.png',
                                    width: 20,
                                  ),
                                ),
                                title: Text(candidates.username,
                                    style: AppTextStyles.black20),
                                subtitle: Text(
                                  candidates.jobTitle!,
                                  style: AppTextStyles.main14,
                                ),
                                trailing: const Icon(Icons.navigate_next),
                              ),
                            ));
                      },
                    )),
                  ],
                ),
              );
            } else if (state is CandidatesError) {
              return Center(
                child: Text(AppLocalizations.of(context).error + state.message),
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
