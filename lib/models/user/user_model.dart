import 'package:json_annotation/json_annotation.dart';
part 'user_model.g.dart';
@JsonSerializable()
class User {
  const User({
    required this.accessToken,
    required this.username,
    required this.email,
    required this.photoUrl,
    required this.uid,
    required this.createdTime,
    required this.phoneNumber,
    required this.password,
    required this.userType,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);

  final String accessToken;
  final String username;
  final String email;
  final String photoUrl;
  final String uid;
  final DateTime createdTime;
  final String phoneNumber;
  final String password;
  final String userType;

  User copyWith({
    String? accessToken,
    String? username,
    String? email,
    String? photoUrl,
    String? uid,
    DateTime? createdTime,
    String? phoneNumber,
    String? password,
    String? userType,
  }) {
    return User(
      accessToken: accessToken ?? this.accessToken,
      username: username ?? this.username,
      email: email ?? this.email,
      photoUrl: photoUrl ?? this.photoUrl,
      uid: uid ?? this.uid,
      createdTime: createdTime ?? this.createdTime,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      password: password ?? this.password,
      userType: userType ?? this.userType,
    );
  }
}

