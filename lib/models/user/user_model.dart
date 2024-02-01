import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:kopuro/export_files.dart';

class User extends Equatable {
  const User({
    required this.id,
    this.email = '',
    this.username = '',
    this.createdTime,
    this.photoUrl,
    this.userLocation,
  });

  final String email;
  final String id;
  final String username;
  final DateTime? createdTime;
  final String? photoUrl;
  final String? userLocation;

  static const empty = User(id: '');

  bool get isEmpty => this == User.empty;

  bool get isNotEmpty => this != User.empty;

  @override
  List<Object?> get props =>
      [email, id, username, createdTime, photoUrl, userLocation];
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'createdTime': createdTime,
      'username': username,
      'email': email,
    };
  }
}

class AdminUser extends User {
  final UserType userType;

  const AdminUser({
    required super.id,
    required super.username,
    required super.email,
    required DateTime super.createdTime,
    required this.userType,
  });

  @override
  List<Object?> get props => [...super.props, userType];
}

class StudentUser extends User {
  final String? type;
  final String? phoneNumber;
  final String? aboutUser;
  final String? jobTitle;
  final String? skills;
  final String? education;
  final String? workExperience;
  final String? language;
  final String? linkedIn;
  final String? github;

  const StudentUser({
    String? id,
    super.createdTime,
    String? username,
    String? email,
    this.type,
    this.phoneNumber,
    this.aboutUser,
    super.photoUrl,
    super.userLocation,
    this.jobTitle,
    this.skills,
    this.education,
    this.workExperience,
    this.language,
    this.linkedIn,
    this.github,
  }) : super(id: id ?? '', username: username ?? '', email: email ?? '');
  Map<String, dynamic> toMapStudent() {
    return {
      ...toMap(),
      'type': 'student',
      'phoneNumber': phoneNumber,
      'aboutUser': aboutUser,
      'jobTitle': jobTitle,
      'skills': skills,
      'education': education,
      'workExperience': workExperience,
      'language': language,
      'linkedIn': linkedIn,
      'github': github,
    };
  }

  factory StudentUser.fromJson(Map<String, dynamic> json) {
    return StudentUser(
      id: json['id'] as String? ?? '',
      username: json['username'] as String? ?? '',
      email: json['email'] as String? ?? '',
      createdTime: (json['createdTime'] as Timestamp).toDate(),
      type: json['type'] as String,
      phoneNumber: json['phoneNumber'] as String? ?? '',
      aboutUser: json['aboutUser'] as String? ?? '',
      jobTitle: json['jobTitle'] as String? ?? '',
      skills: json['skills'] as String? ?? '',
      education: json['education'] as String? ?? '',
      workExperience: json['workExperience'] as String? ?? '',
      language: json['language'] as String? ?? '',
      linkedIn: json['linkedIn'] as String? ?? '',
      github: json['github'] as String? ?? '',
    );
  }
  @override
  List<Object?> get props => [
        ...super.props,
        type,
        phoneNumber,
        aboutUser,
        jobTitle,
        skills,
        education,
        workExperience,
        language,
        linkedIn,
        github,
      ];
}

class CompanyUser extends User {
  final UserType? type;
  final String? linkedIn;
  final String? phoneNumber;
  final String? aboutCompany;
  final String? webLinkCompany;
  final List<Vacancy>? vacancies;

  const CompanyUser({
    this.type,
    String? id,
    String? username,
    String? email,
    super.createdTime,
    this.webLinkCompany,
    this.vacancies,
    this.linkedIn,
    this.phoneNumber,
    this.aboutCompany,
    super.photoUrl,
    super.userLocation,
  }) : super(id: id ?? '', username: username ?? '', email: email ?? '');

  Map<String, dynamic> toMapCompany() {
    return {
      ...toMap(),
      'type': 'company',
      'linkedIn': linkedIn,
      'phoneNumber': phoneNumber,
      'aboutCompany': aboutCompany,
      'webLinkCompany': webLinkCompany,
      'vacancies': vacancies?.map((vacancy) => vacancy.toJson()).toList(),
    };
  }

  factory CompanyUser.fromJsonCompany(Map<String, dynamic> json) {
    return CompanyUser(
      id: json['id'] as String? ?? '',
      username: json['username'] as String? ?? '',
      email: json['email'] as String? ?? '',
      createdTime: json['createdTime'] != null
          ? DateTime.parse(json['createdTime'] as String)
          : null,
      type: json['type'],
      linkedIn: json['linkedIn'] as String? ?? '',
      phoneNumber: json['phoneNumber'] as String? ?? '',
      aboutCompany: json['aboutCompany'] as String? ?? '',
      webLinkCompany: json['webLinkCompany'] as String? ?? '',
      vacancies: (json['vacancies'] as List<dynamic>?)
          ?.map((vacancyJson) =>
              Vacancy.fromJson(vacancyJson as Map<String, dynamic>))
          .toList(),
    );
  }

  @override
  List<Object?> get props => [
        ...super.props,
        type,
        linkedIn,
        phoneNumber,
        aboutCompany,
        webLinkCompany,
        vacancies,
      ];
}
