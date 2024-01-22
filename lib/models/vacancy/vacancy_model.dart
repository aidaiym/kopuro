import 'package:kopuro/models/user/user_model.dart';

class Vacancy {
  const Vacancy({
    required this.jobTitle,
    required this.companyName,
    required this.location,
    required this.jobType,
    required this.jobDescription,
    required this.contactInformation,
    required this.salary,
    this.appliedStudents,
  });

  factory Vacancy.fromJson(Map<String, dynamic> json) {
    return Vacancy(
      jobTitle: json['jobTitle'] as String,
      companyName: json['companyName'] as String,
      location: json['location'] as String,
      jobType: json['jobType'] as String,
      jobDescription: json['jobDescription'] as String,
      contactInformation: json['contactInformation'] as String,
      salary: json['salary'] as String,
      appliedStudents: (json['appliedUsers'] as List<dynamic>?)
          ?.map((userJson) =>
              StudentUser.fromJson(userJson as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'jobTitle': jobTitle,
      'companyName': companyName,
      'location': location,
      'jobType': jobType,
      'jobDescription': jobDescription,
      'contactInformation': contactInformation,
      'salary': salary,
      'appliedUsers':
          appliedStudents?.map((user) => user.toMapStudent()).toList(),
    };
  }

  final String jobTitle;
  final String companyName;
  final String location;
  final String jobType;
  final String jobDescription;
  final String contactInformation;
  final String salary;
  final List<StudentUser>? appliedStudents;

  Vacancy copyWith({
    String? jobTitle,
    String? companyName,
    String? location,
    String? jobType,
    String? jobDescription,
    String? contactInformation,
    String? salary,
    List<StudentUser>? appliedUsers,
  }) {
    return Vacancy(
      jobTitle: jobTitle ?? this.jobTitle,
      companyName: companyName ?? this.companyName,
      location: location ?? this.location,
      jobType: jobType ?? this.jobType,
      jobDescription: jobDescription ?? this.jobDescription,
      contactInformation: contactInformation ?? this.contactInformation,
      salary: salary ?? this.salary,
      appliedStudents: appliedUsers ?? this.appliedStudents,
    );
  }
}
