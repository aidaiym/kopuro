import 'package:cloud_firestore/cloud_firestore.dart';

class Vacancy {
  const Vacancy({
     this.id,
    required this.createdTime,
    required this.jobTitle,
    required this.companyName,
    required this.location,
    required this.jobType,
    required this.jobDescription,
    required this.contactInformation,
    required this.salary,
    this.appliedUsers,
  });

  factory Vacancy.fromJson(Map<String, dynamic> json) {
    return Vacancy(
        id: json['id'] as String,
        createdTime: (json['createdTime'] as Timestamp).toDate(),
        jobTitle: json['jobTitle'] as String,
        companyName: json['companyName'] as String,
        location: json['location'] as String,
        jobType: json['jobType'] as String,
        jobDescription: json['jobDescription'] as String,
        contactInformation: json['contactInformation'] as String,
        salary: json['salary'] as String,
        // appliedUsers: json['appliedUsers'] as List<String>?);
         appliedUsers: (json['appliedUsers'] as List<dynamic>?)
        ?.map((userId) => userId as String)
        .toList());
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'createdTime': createdTime,
      'jobTitle': jobTitle,
      'companyName': companyName,
      'location': location,
      'jobType': jobType,
      'jobDescription': jobDescription,
      'contactInformation': contactInformation,
      'salary': salary,
      'appliedUsers': appliedUsers,
    };
  }

  final String? id;
  final DateTime createdTime;
  final String jobTitle;
  final String companyName;
  final String location;
  final String jobType;
  final String jobDescription;
  final String contactInformation;
  final String salary;
  final List<String>? appliedUsers;

  Vacancy copyWith({
    String? id,
    DateTime? createdTime,
    String? jobTitle,
    String? companyName,
    String? location,
    String? jobType,
    String? jobDescription,
    String? contactInformation,
    String? salary,
    List<String>? appliedUsers,
  }) {
    return Vacancy(
      id: id ?? this.id,
      createdTime: createdTime ?? this.createdTime,
      jobTitle: jobTitle ?? this.jobTitle,
      companyName: companyName ?? this.companyName,
      location: location ?? this.location,
      jobType: jobType ?? this.jobType,
      jobDescription: jobDescription ?? this.jobDescription,
      contactInformation: contactInformation ?? this.contactInformation,
      salary: salary ?? this.salary,
      appliedUsers: appliedUsers ?? appliedUsers,
    );
  }
}
