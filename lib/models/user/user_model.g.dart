// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Users _$UsersFromJson(Map<String, dynamic> json) => Users(
      uid: json['uid'] as String,
      createdTime: DateTime.parse(json['createdTime'] as String),
      userType: json['userType'] as String,
      email: json['email'] as String,
      username: json['username'] as String,
      phoneNumber: json['phoneNumber'] as String,
      aboutUser: json['aboutUser'] as String,
      jobTitle: json['jobTitle'] as String,
      skills: json['skills'] as String,
      userLocation: json['userLocation'] as String?,
      education: json['education'] as String?,
      workExperience: json['workExperience'] as String?,
      language: json['language'] as String?,
      linkedIn: json['linkedIn'] as String?,
      github: json['github'] as String?,
      photoUrl: json['photoUrl'] as String?,
    );

Map<String, dynamic> _$UsersToJson(Users instance) => <String, dynamic>{
      'uid': instance.uid,
      'createdTime': instance.createdTime.toIso8601String(),
      'userType': instance.userType,
      'email': instance.email,
      'username': instance.username,
      'phoneNumber': instance.phoneNumber,
      'aboutUser': instance.aboutUser,
      'jobTitle': instance.jobTitle,
      'skills': instance.skills,
      'userLocation': instance.userLocation,
      'education': instance.education,
      'workExperience': instance.workExperience,
      'language': instance.language,
      'linkedIn': instance.linkedIn,
      'github': instance.github,
      'photoUrl': instance.photoUrl,
    };
