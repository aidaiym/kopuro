import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kopuro/export_files.dart';
import 'package:kopuro/l10n/l10.dart';

class VacanciesList extends StatefulWidget {
  const VacanciesList({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _VacanciesListState createState() => _VacanciesListState();
}

class _VacanciesListState extends State<VacanciesList> {
  String? selectedFilter;
  String? selectedFilter1;

  String query = '';
  int? salaryFrom;
  int? salaryTo;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => VacancyCubit()..loadVacancies(),
      child: Scaffold(
        body: BlocBuilder<VacancyCubit, VacancyState>(
          builder: (context, state) {
            if (state is VacancyLoaded) {
              return _buildLoadedState(context, state);
            } else if (state is VacancyError) {
              return _buildErrorState(context, state);
            } else {
              return _buildLoadingState(context);
            }
          },
        ),
      ),
    );
  }

  Widget _buildLoadedState(BuildContext context, VacancyLoaded state) {
    return SafeArea(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    onChanged: (value) {
                      setState(() {
                        query = value;
                      });
                      context
                          .read<VacancyCubit>()
                          .filterVacancies(query, selectedFilter);
                    },
                    decoration: InputDecoration(
                      labelText: AppLocalizations.of(context).search,
                      prefixIcon: const Icon(Icons.search),
                      border: const OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                IconButton(
                  icon: const Icon(Icons.filter_list_outlined),
                  onPressed: () {
                    _showFilterDialog(context);
                  },
                ),
              ],
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
                          Text(vacancy.jobTitle, style: AppTextStyles.black16),
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
                            '${AppLocalizations.of(context).jobSalary}: ${vacancy.salary}',
                            style: AppTextStyles.black16,
                          ),
                          const SizedBox(height: 10),
                          MainButton(
                            onPressed: () {
                              Navigator.push<void>(
                                context,
                                MaterialPageRoute<void>(
                                  builder: (BuildContext context) =>
                                      VacancyDetail(
                                    vacancy: vacancy,
                                  ),
                                ),
                              );
                            },
                            text: AppLocalizations.of(context).moreInfo,
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorState(BuildContext context, VacancyError state) {
    return Center(
      child: Text(
        '${AppLocalizations.of(context).error}: ${state.message}',
      ),
    );
  }

  Widget _buildLoadingState(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  void _showFilterDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return AlertDialog(
              content: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      DropdownButton<String>(
                        value: selectedFilter1,
                        onChanged: (String? newValue) {
                          setState(() {
                            selectedFilter1 = newValue;
                          });
                        },
                        items: <String>[
                          'Full-time',
                          'Part-time',
                        ].map<DropdownMenuItem<String>>(
                          (String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          },
                        ).toList(),
                      ),
                      DropdownButton<String>(
                        value: selectedFilter,
                        onChanged: (String? newValue) {
                          setState(() {
                            selectedFilter = newValue;
                          });
                        },
                        items: <String>[
                          'Remote',
                          'Onsite',
                        ].map<DropdownMenuItem<String>>(
                          (String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          },
                        ).toList(),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Text(
                    AppLocalizations.of(context).jobSalary,
                    style: AppTextStyles.black19,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.3,
                        child: TextField(
                          onChanged: (value) {
                            salaryFrom = int.tryParse(value);
                          },
                          decoration: InputDecoration(
                            labelText: AppLocalizations.of(context).from,
                          ),
                          keyboardType: TextInputType.number,
                        ),
                      ),
                      const SizedBox(width: 10),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.3,
                        child: TextField(
                          onChanged: (value) {
                            salaryTo = int.tryParse(value);
                          },
                          decoration: InputDecoration(
                            labelText: AppLocalizations.of(context).to,
                          ),
                          keyboardType: TextInputType.number,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    context
                        .read<VacancyCubit>()
                        .filterVacancies(query, selectedFilter1);
                  },
                  child:  Text(AppLocalizations.of(context).apply),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
