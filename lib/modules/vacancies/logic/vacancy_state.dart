part of 'vacancy_cubit.dart';

abstract class VacancyEvent extends Equatable {
  const VacancyEvent();

  @override
  List<Object> get props => [];
}

class LoadVacancies extends VacancyEvent {}

abstract class VacancyState extends Equatable {
  const VacancyState();

  @override
  List<Object> get props => [];
}

class VacancyInitial extends VacancyState {}

class VacancyLoaded extends VacancyState {
  final List<Vacancy> vacancies;

  const VacancyLoaded({required this.vacancies});

  @override
  List<Object> get props => [vacancies];
}

class VacancyError extends VacancyState {
  final String message;

  const VacancyError({required this.message});

  @override
  List<Object> get props => [message];
}
