// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      accessToken: json['accessToken'] as String,
      username: json['username'] as String,
      email: json['email'] as String,
      photoUrl: json['photoUrl'] as String,
      uid: json['uid'] as String,
      createdTime: DateTime.parse(json['createdTime'] as String),
      phoneNumber: json['phoneNumber'] as String,
      password: json['password'] as String,
      userType: json['userType'] as String,
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'accessToken': instance.accessToken,
      'username': instance.username,
      'email': instance.email,
      'photoUrl': instance.photoUrl,
      'uid': instance.uid,
      'createdTime': instance.createdTime.toIso8601String(),
      'phoneNumber': instance.phoneNumber,
      'password': instance.password,
      'userType': instance.userType,
    };
