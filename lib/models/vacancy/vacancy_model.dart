import 'package:json_annotation/json_annotation.dart';

part 'vacancy_model.g.dart';

@JsonSerializable()
class Vacancy {
  const Vacancy( {
    required this.jobTitle,
    required this.companyName,
    required this.location,
    required this.jobType,
    required this.jobDescription,
    required this.contactInformation,
    required this.salary,
  });

  factory Vacancy.fromJson(Map<String, dynamic> json) => _$VacancyFromJson(json);
  Map<String, dynamic> toJson() => _$VacancyToJson(this);

  final String jobTitle;
  final String companyName;
  final String location;
  final String jobType;
  final String jobDescription;
  final String contactInformation;
  final String salary;

  Vacancy copyWith({
    String? jobTitle,
    String? companyName,
    String? location,
    String? jobType,
    String? jobDescription,
    String? contactInformation,
    String? salary,
  }) {
    return Vacancy(
      jobTitle: jobTitle ?? this.jobTitle,
      companyName: companyName ?? this.companyName,
      location: location ?? this.location,
      jobType: jobType ?? this.jobType,
      jobDescription: jobDescription ?? this.jobDescription,
      contactInformation: contactInformation ?? this.contactInformation,
      salary: salary ?? this.salary,
    );
  }
}
