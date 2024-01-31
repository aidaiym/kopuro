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
                          labelText: 'Издөө',
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
                          padding: const EdgeInsets.all(10.0),
                          child: Card(
                            elevation: 3.0,
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(vacancy.jobTitle,
                                      style: AppTextStyles.black16),
                                  const SizedBox(height: 8),
                                  Text(
                                    vacancy.companyName,
                                    style: AppTextStyles.black14,
                                  ),
                                  const SizedBox(height: 8),
                                  Wrap(
                                    spacing: 20,
                                    children: [
                                      Chip(
                                        label: Text(vacancy.jobType),
                                      ),
                                      Chip(
                                        label: Text(vacancy.location),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    'Salary: ${vacancy.salary}',
                                    style: AppTextStyles.black16,
                                  ),
                                  const SizedBox(height: 10),
                                  MainButton(
                                      onPressed: () {
                                        Navigator.push<void>(
                                          context,
                                          MaterialPageRoute<void>(
                                            builder: (BuildContext context) =>
                                                VacancyDetail(vacancy: vacancy),
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
