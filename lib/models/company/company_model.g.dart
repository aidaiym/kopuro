// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'company_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CompanyUser _$CompanyUserFromJson(Map<String, dynamic> json) => CompanyUser(
      id: json['id'] as String,
      username: json['username'] as String,
      email: json['email'] as String,
      createdTime: DateTime.parse(json['createdTime'] as String),
      linkedIn: json['linkedIn'] as String?,
      phoneNumber: json['phoneNumber'] as String?,
      aboutUser: json['aboutUser'] as String?,
      photoUrl: json['photoUrl'] as String?,
      userLocation: json['userLocation'] as String?,
    );

Map<String, dynamic> _$CompanyUserToJson(CompanyUser instance) =>
    <String, dynamic>{
      'id': instance.id,
      'createdTime': instance.createdTime.toIso8601String(),
      'username': instance.username,
      'email': instance.email,
      'phoneNumber': instance.phoneNumber,
      'aboutUser': instance.aboutUser,
      'photoUrl': instance.photoUrl,
      'userLocation': instance.userLocation,
      'linkedIn': instance.linkedIn,
    };
