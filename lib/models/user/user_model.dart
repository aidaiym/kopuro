import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:kopuro/export_files.dart';

class User extends Equatable {
  const User({
    required this.id,
    required this.userType,
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
  final UserType userType;

  static const empty = User(id: '', userType: UserType.student);

  bool get isEmpty => this == User.empty;

  bool get isNotEmpty => this != User.empty;

  @override
  List<Object?> get props =>
      [email, id, username, createdTime, photoUrl, userLocation, userType];
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'createdTime': createdTime,
      'username': username,
      'email': email,
      'photoUrl': photoUrl,
      'userType': userType.toString(),
    };
  }
}

class StudentUser extends User {
  final String? phoneNumber;
  final String? aboutUser;
  final String? jobTitle;
  final String? skills;
  final String? education;
  final String? workExperience;
  final String? language;
  final String? linkedIn;
  final String? github;
  final List<String>? appliedVacancies;

  const StudentUser({
    String? id,
    super.createdTime,
    String? username,
    String? email,
    super.userType = UserType.student,
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
    this.appliedVacancies,
  }) : super(
          id: id ?? '',
          username: username ?? '',
          email: email ?? '',
        );
  Map<String, dynamic> toMapStudent() {
    return {
      ...toMap(),
      'phoneNumber': phoneNumber,
      'aboutUser': aboutUser,
      'jobTitle': jobTitle,
      'skills': skills,
      'education': education,
      'workExperience': workExperience,
      'language': language,
      'linkedIn': linkedIn,
      'github': github,
      'appliedVacancies': appliedVacancies,
    };
  }

  factory StudentUser.fromJson(Map<String, dynamic> json) {
      List<String>? appliedVacancies = [];
  if (json['appliedVacancies'] != null) {
    appliedVacancies = (json['appliedVacancies'] as List<dynamic>)
        .map((vacancyRef) => (vacancyRef as DocumentReference).path)
        .toList();
  }

    return StudentUser(
      id: json['id'] as String? ?? '',
      username: json['username'] as String? ?? '',
      email: json['email'] as String? ?? '',
      createdTime: (json['createdTime'] as Timestamp).toDate(),
      userType: UserType.student,
      phoneNumber: json['phoneNumber'] as String? ?? '',
      aboutUser: json['aboutUser'] as String? ?? '',
      jobTitle: json['jobTitle'] as String? ?? '',
      skills: json['skills'] as String? ?? '',
      education: json['education'] as String? ?? '',
      workExperience: json['workExperience'] as String? ?? '',
      userLocation: json['location'] as String? ?? '',
      language: json['language'] as String? ?? '',
      linkedIn: json['linkedIn'] as String? ?? '',
      github: json['github'] as String? ?? '',
      photoUrl: json['photoUrl'] as String? ??
          'https://firebasestorage.googleapis.com/v0/b/kopuro-5fe2a.appspot.com/o/images%2F6596121.png?alt=media&token=1f751e91-a606-4e7b-85fe-02b2faf423aa',
      appliedVacancies :appliedVacancies,
    );
  }
  @override
  List<Object?> get props => [
        ...super.props,
        phoneNumber,
        aboutUser,
        jobTitle,
        skills,
        education,
        workExperience,
        language,
        linkedIn,
        github,
        appliedVacancies,
      ];
}

class CompanyUser extends User {
  final String? linkedIn;
  final String? phoneNumber;
  final String? aboutCompany;
  final String? webLinkCompany;
  final List<String>? vacancies;

  const CompanyUser({
    String? id,
    String? username,
    String? email,
    super.userType = UserType.company,
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
      'linkedIn': linkedIn,
      'phoneNumber': phoneNumber,
      'aboutCompany': aboutCompany,
      'webLinkCompany': webLinkCompany,
      'vacancies': vacancies,
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
        userType: json['type'] as UserType,
        linkedIn: json['linkedIn'] as String? ?? '',
        phoneNumber: json['phoneNumber'] as String? ?? '',
        aboutCompany: json['aboutCompany'] as String? ?? '',
        webLinkCompany: json['webLinkCompany'] as String? ?? '',
        vacancies: (json['vacancies'] as List<dynamic>?)
            ?.map((vacancyJson) => vacancyJson as String)
            .toList(),
        photoUrl: json['photoUrl'] as String? ??
            'https://firebasestorage.googleapis.com/v0/b/kopuro-5fe2a.appspot.com/o/images%2Fapple_logo.jpeg?alt=media&token=bd03861d-565d-4dc4-8ca6-5686cb560c3b');
  }

  @override
  List<Object?> get props => [
        ...super.props,
        linkedIn,
        phoneNumber,
        aboutCompany,
        webLinkCompany,
        vacancies,
      ];
}
