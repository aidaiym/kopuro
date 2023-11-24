// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'student_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StudentUser _$StudentUserFromJson(Map<String, dynamic> json) => StudentUser(
      id: json['id'] as String,
      type: $enumDecode(_$UserTypeEnumMap, json['type']),
      username: json['username'] as String,
      email: json['email'] as String,
      jobTitle: json['jobTitle'] as String,
      skills: json['skills'] as String,
      education: json['education'] as String?,
      workExperience: json['workExperience'] as String?,
      language: json['language'] as String?,
      linkedIn: json['linkedIn'] as String?,
      github: json['github'] as String?,
      createdTime: DateTime.parse(json['createdTime'] as String),
      phoneNumber: json['phoneNumber'] as String?,
      aboutUser: json['aboutUser'] as String?,
      photoUrl: json['photoUrl'] as String?,
      userLocation: json['userLocation'] as String?,
    );

Map<String, dynamic> _$StudentUserToJson(StudentUser instance) =>
    <String, dynamic>{
      'id': instance.id,
      'createdTime': instance.createdTime.toIso8601String(),
      'username': instance.username,
      'email': instance.email,
      'phoneNumber': instance.phoneNumber,
      'aboutUser': instance.aboutUser,
      'photoUrl': instance.photoUrl,
      'userLocation': instance.userLocation,
      'jobTitle': instance.jobTitle,
      'skills': instance.skills,
      'education': instance.education,
      'workExperience': instance.workExperience,
      'language': instance.language,
      'linkedIn': instance.linkedIn,
      'github': instance.github,
      'type': _$UserTypeEnumMap[instance.type]!,
    };

const _$UserTypeEnumMap = {
  UserType.admin: 'admin',
  UserType.student: 'student',
  UserType.company: 'company',
};
