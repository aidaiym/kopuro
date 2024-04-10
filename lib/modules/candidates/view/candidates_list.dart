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
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(10)),
                                border: const Border(
                                  left: BorderSide(
                                    color: Color.fromARGB(255, 31, 12, 89),
                                    width: 10.0,
                                  ),
                                ),
                                color: index % 2 == 0
                                    ? const Color(0xffD6E0FF).withOpacity(0.4)
                                    : const Color(0xffF1ECFF).withOpacity(0.7),
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
