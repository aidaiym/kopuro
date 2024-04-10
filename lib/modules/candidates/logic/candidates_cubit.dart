import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kopuro/export_files.dart';

part 'candidates_state.dart';

class CandidatesCubit extends Cubit<CandidatesState> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  CandidatesCubit() : super(CandidatesInitial());

  void loadCandidates() async {
    try {
      final QuerySnapshot<Map<String, dynamic>> snapshot = await _firestore
          .collection('users')
          .where('userType', isEqualTo: 'UserType.student')
          .get();

      final List<StudentUser> allCandidates =
          snapshot.docs.map((doc) => StudentUser.fromJson(doc.data())).toList();
      emit(CandidatesLoaded(candidates: allCandidates));
    } catch (e) {
      emit(CandidatesError(message: 'Failed to load candidates. $e'));
    }
  }

  void filterCandidates(String query) async {
    try {
      final String lowerCaseQuery = query.toLowerCase();

      final QuerySnapshot<Map<String, dynamic>> snapshot = await _firestore
          .collection('users')
          .where('type', isEqualTo: 'student')
          .get();

      final List<StudentUser> allCandidates =
          snapshot.docs.map((doc) => StudentUser.fromJson(doc.data())).toList();

      final List<StudentUser> filteredCandidates = allCandidates
          .where((candidate) =>
              candidate.username.toLowerCase().contains(lowerCaseQuery))
          .toList();

      emit(CandidatesLoaded(candidates: filteredCandidates));
    } catch (e) {
      emit(const CandidatesError(message: 'Failed to filter candidates.'));
    }
  }
}
