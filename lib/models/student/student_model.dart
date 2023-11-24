import 'package:json_annotation/json_annotation.dart';
import 'package:kopuro/core/core.dart';
import 'package:kopuro/models/user/user_model.dart';

part 'student_model.g.dart';

@JsonSerializable()
class StudentUser extends Users {
  final String jobTitle;
  final String skills;
  final String? education;
  final String? workExperience;
  final String? language;
  final String? linkedIn;
  final String? github;
  @override
  final UserType type;

  StudentUser(
   {
    required String id,
     required this.type, 
    required String username,
    required String email,
    required this.jobTitle,
    required this.skills,
    this.education,
    this.workExperience,
    this.language,
    this.linkedIn,
    this.github,
    required DateTime createdTime,
    String? phoneNumber,
    String? aboutUser,
    String? photoUrl,
    String? userLocation,
  }) : super(
          id: id,
          username: username,
          email: email,
          type: type,
          createdTime: createdTime,
          phoneNumber: phoneNumber,
          aboutUser: aboutUser,
          photoUrl: photoUrl,
          userLocation: userLocation,
        );

  factory StudentUser.fromJson(Map<String, dynamic> json) => _$StudentUserFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$StudentUserToJson(this);

  @override
  StudentUser copyWith({
    String? id,
    DateTime? createdTime,
    String? username,
    String? email,
    UserType? type,
    String? phoneNumber,
    String? aboutUser,
    String? photoUrl,
    String? userLocation,
    String? jobTitle,
    String? skills,
    String? education,
    String? workExperience,
    String? language,
    String? linkedIn,
    String? github,
  }) {
    return StudentUser(
      type: type ?? this.type, // Pass the type parameter here
      id: id ?? this.id,
      username: username ?? this.username,
      email: email ?? this.email,
      createdTime: createdTime ?? this.createdTime,
      jobTitle: jobTitle ?? this.jobTitle,
      skills: skills ?? this.skills,
    );
  }
}
