import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kopuro/export_files.dart';

part 'vacancy_state.dart';

class VacancyCubit extends Cubit<VacancyState> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  VacancyCubit() : super(VacancyInitial());

  void loadVacancies() async {
    try {
      final QuerySnapshot<Map<String, dynamic>> snapshot =
          await _firestore.collection('vacancies').get();
      final List<Vacancy> allVacancies =
          snapshot.docs.map((doc) => Vacancy.fromJson(doc.data())).toList();
      emit(VacancyLoaded(vacancies: allVacancies));
    } catch (e) {
      emit(VacancyError(message: 'Failed to load vacancies. $e'));
    }
  }

  void searchVacancies(String query) async {
    try {
      final String lowerCaseQuery = query.toLowerCase();

      final QuerySnapshot<Map<String, dynamic>> snapshot =
          await _firestore.collection('vacancies').get();

      final List<Vacancy> allVacancies =
          snapshot.docs.map((doc) => Vacancy.fromJson(doc.data())).toList();

      List<Vacancy> searchedVacancies = allVacancies.where((vacancy) {
        return vacancy.jobTitle.toLowerCase().contains(lowerCaseQuery);
      }).toList();
      emit(VacancyLoaded(vacancies: searchedVacancies));
    } catch (e) {
      emit(const VacancyError(message: 'Failed to filter vacancies.'));
    }
  }
void filterVacancy(
  String? salaryFrom,
  String? salaryTo,
  bool isFullTime,
  bool isRemote,
) async {
  try {
    Query<Map<String, dynamic>> filteredQuery =
        _firestore.collection('vacancies');

    if (salaryFrom != null && salaryFrom.isNotEmpty) {
      filteredQuery = filteredQuery.where('salary',
          isGreaterThanOrEqualTo: int.parse(salaryFrom));
    }
    if (salaryTo != null && salaryTo.isNotEmpty) {
      filteredQuery = filteredQuery.where('salary',
          isLessThanOrEqualTo: int.parse(salaryTo));
    }

    if (isFullTime) {
      filteredQuery = filteredQuery.where('jobType', isEqualTo: 'Full-Time');
    } else {
      filteredQuery = filteredQuery.where('jobType', isEqualTo: 'Part-time');
    }

    if (isRemote) {
      filteredQuery = filteredQuery.where('location', isEqualTo: 'Remote');
    } else {
      filteredQuery = filteredQuery.where('location', isEqualTo: 'Onsite');
    }

    final QuerySnapshot<Map<String, dynamic>> snapshot =
        await filteredQuery.get();

    final List<Vacancy> filteredVacancies = snapshot.docs
        .map((doc) => Vacancy.fromJson(doc.data()))
        .toList();

    emit(VacancyLoaded(vacancies: filteredVacancies));
  } catch (e) {
    emit(const VacancyError(message: 'Failed to filter vacancies.'));
  }
}
}