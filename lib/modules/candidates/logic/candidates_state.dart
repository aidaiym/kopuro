
part of 'candidates_cubit.dart';

abstract class CandidatesEvent extends Equatable {
  const CandidatesEvent();

  @override
  List<Object> get props => [];
}

class LoadCandidates extends CandidatesEvent {}

abstract class CandidatesState extends Equatable {
  const CandidatesState();

  @override
  List<Object> get props => [];
}

class CandidatesInitial extends CandidatesState {}

class CandidatesLoaded extends CandidatesState {
  final List<StudentUser> candidates;

  const CandidatesLoaded({required this.candidates});

  @override
  List<Object> get props => [candidates];
}

class CandidatesError extends CandidatesState {
  final String message;

  const CandidatesError({required this.message});

  @override
  List<Object> get props => [message];
}
