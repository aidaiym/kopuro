import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kopuro/export_files.dart';

class VacanciesList extends StatelessWidget {
  const VacanciesList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => VacancyCubit()..loadVacancies(),
      child: Scaffold(
        body: BlocBuilder<VacancyCubit, VacancyState>(
          builder: (context, state) {
            if (state is VacancyLoaded) {
              return SafeArea(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        onChanged: (query) {
                          context.read<VacancyCubit>().filterVacancies(query);
                        },
                        decoration: const InputDecoration(
                          labelText: 'Search',
                          hintText: 'Enter search query',
                          prefixIcon: Icon(Icons.search),
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    Expanded(
                        child: ListView.builder(
                      itemCount: state.vacancies.length,
                      itemBuilder: (context, index) {
                        final vacancy = state.vacancies[index];

                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Card(
                            elevation: 3.0,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ListTile(
                                  leading: const CircleAvatar(),
                                  title: Text(vacancy.jobTitle),
                                  subtitle: Text(vacancy.companyName),
                                ),
                                const Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 16.0, vertical: 8.0),
                                  child: Wrap(
                                    spacing: 8.0,
                                    children: [
                                      Chip(label: Text('Full-Time')),
                                      Chip(label: Text('Remote')),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16.0),
                                  child: Text('Salary: ${vacancy.salary}'),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: ElevatedButton(
                                    onPressed: () {
                                      Navigator.push<void>(
                                        context,
                                        MaterialPageRoute<void>(
                                          builder: (BuildContext context) =>
                                              VacancyDetail(vacancy: vacancy),
                                        ),
                                      );
                                    },
                                    child: const Text('Kөбүрөөк маалымат алуу'),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    )),
                  ],
                ),
              );
            } else if (state is VacancyError) {
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
