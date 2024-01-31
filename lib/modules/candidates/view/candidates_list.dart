import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kopuro/export_files.dart';

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
                        decoration: const InputDecoration(
                          labelText: 'Издөө',
                          prefixIcon: Icon(Icons.search),
                          border: OutlineInputBorder(),
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
                          child: Card(
                            elevation: 3.0,
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(candidates.username,
                                      style: AppTextStyles.black16),
                                  const SizedBox(height: 8),
                                  Wrap(
                                    spacing: 20,
                                    children: [
                                      Chip(
                                        label: Text(candidates.email),
                                      ),
                                      Chip(
                                        label: Text(candidates.workExperience!),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 10),
                                  MainButton(
                                      onPressed: () {
                                        Navigator.push<void>(
                                          context,
                                          MaterialPageRoute<void>(
                                            builder: (BuildContext context) =>
                                                CandidatesDetailView(
                                                    candidate: candidates),
                                          ),
                                        );
                                      },
                                      text: 'Kөбүрөөк маалымат алуу')
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    )),
                  ],
                ),
              );
            } else if (state is CandidatesError) {
              return Center(
                child: Text('Error: ${state.message}'),
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
