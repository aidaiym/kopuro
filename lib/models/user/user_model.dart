import 'package:json_annotation/json_annotation.dart';
part 'user_model.g.dart';

@JsonSerializable()
class Users {
  const Users({
    required this.uid,
    required this.createdTime,
    required this.userType,
    required this.email,
    required this.username,
    required this.phoneNumber,
    required this.aboutUser,
    required this.jobTitle,
    required this.skills,
    this.userLocation,
    this.education,
    this.workExperience,
    this.language,
    this.linkedIn,
    this.github,
    this.photoUrl,
  });

  factory Users.fromJson(Map<String, dynamic> json) => _$UsersFromJson(json);
  Map<String, dynamic> toJson() => _$UsersToJson(this);

  final String uid;
  final DateTime createdTime;
  final String userType;
  final String email;
  final String username;
  final String phoneNumber;
  final String aboutUser;
  final String jobTitle;
  final String skills;
  final String? userLocation;
  final String? education;
  final String? workExperience;
  final String? language;
  final String? linkedIn;
  final String? github;
  final String? photoUrl;

  Users copyWith({
    String? username,
    String? email,
    String? photoUrl,
    String? uid,
    DateTime? createdTime,
    String? phoneNumber,
    String? password,
    String? userType,
    String? userLocation,
    String? aboutUser,
    String? jobTitle,
    String? skills,
    String? education,
    String? workExperience,
    String? language,
    String? linkedIn,
    String? github,
  }) {
    return Users(
      uid: uid ?? this.uid,
      createdTime: createdTime ?? this.createdTime,
      userType: userType ?? this.userType,
      email: email ?? this.email,
      username: username ?? this.username,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      aboutUser: aboutUser ?? this.aboutUser,
      jobTitle: jobTitle ?? this.jobTitle,
      skills: skills ?? this.skills,
      userLocation: userLocation ?? this.userLocation,
      education: education ?? this.education,
      workExperience: workExperience ?? this.workExperience,
      language: language ?? this.language,
      linkedIn: linkedIn ?? this.linkedIn,
      github: github ?? this.github,
      photoUrl: photoUrl ?? this.photoUrl,
    );
  }
}
