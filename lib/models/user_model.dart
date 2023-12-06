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
    required String id,
    required String username,
    required String email,
    required DateTime createdTime,
    required this.userType,
  }) : super(
            id: id, username: username, email: email, createdTime: createdTime);

  @override
  List<Object?> get props => [...super.props, userType];
}

class StudentUser extends User {
  final UserType? type;
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
    DateTime? createdTime,
    String? username,
    String? email,
    this.type,
    this.phoneNumber,
    this.aboutUser,
    String? photoUrl,
    String? userLocation,
    this.jobTitle,
    this.skills,
    this.education,
    this.workExperience,
    this.language,
    this.linkedIn,
    this.github,
  }) : super(
            id: id ?? '',
            username: username ?? '',
            email: email ?? '',
            createdTime: createdTime,
            photoUrl: photoUrl,
            userLocation: userLocation);
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
  final String linkedIn;
  final String? phoneNumber;
  final String? aboutUser;

  const CompanyUser({
    this.type,
    required String id,
    required String username,
    required String email,
    required DateTime createdTime,
    required this.linkedIn,
    this.phoneNumber,
    this.aboutUser,
    String? photoUrl,
    String? userLocation,
  }) : super(
            id: id,
            username: username,
            email: email,
            createdTime: createdTime,
            photoUrl: photoUrl,
            userLocation: userLocation);

  @override
  List<Object?> get props =>
      [...super.props, type, linkedIn, phoneNumber, aboutUser];
}
