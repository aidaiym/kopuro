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

  void filterVacancies(String query, String? selectedFilter) async {
    try {
      final String lowerCaseQuery = query.toLowerCase();

      final QuerySnapshot<Map<String, dynamic>> snapshot =
          await _firestore.collection('vacancies').get();

      final List<Vacancy> allVacancies =
          snapshot.docs.map((doc) => Vacancy.fromJson(doc.data())).toList();

      List<Vacancy> filteredVacancies = allVacancies.where((vacancy) {
        if (selectedFilter == 'Salary') {
          return vacancy.salary.toLowerCase().contains(lowerCaseQuery);
        } else if (selectedFilter == 'Full-time') {
          return vacancy.jobType.toLowerCase() == 'full-time';
        } else if (selectedFilter == 'Part-time') {
          return vacancy.jobType.toLowerCase() == 'part-time';
        } else if (selectedFilter == 'Remote') {
          return vacancy.location.toLowerCase() == 'remote';
        } else if (selectedFilter == 'Onsite') {
          return vacancy.location.toLowerCase() == 'onsite';
        } else {
          return vacancy.jobTitle.toLowerCase().contains(lowerCaseQuery);
        }
      }).toList();

      emit(VacancyLoaded(vacancies: filteredVacancies));
    } catch (e) {
      emit(const VacancyError(message: 'Failed to filter vacancies.'));
    }
  }
}
