import 'package:json_annotation/json_annotation.dart';
import 'package:kopuro/core/enums/user_type.dart';
part 'user_model.g.dart';



@JsonSerializable()
class Users {
  final String id;
  final DateTime createdTime;
  final String username;
  final String email;
  final UserType type;
  final String? phoneNumber;
  final String? aboutUser;
  final String? photoUrl;
  final String? userLocation;

  Users({
    required this.id,
    required this.createdTime,
    required this.username,
    required this.email,
    required this.type,
    this.phoneNumber,
    this.aboutUser,
    this.photoUrl,
    this.userLocation,
  });

  factory Users.fromJson(Map<String, dynamic> json) => _$UsersFromJson(json);
  Map<String, dynamic> toJson() => _$UsersToJson(this);

  Users copyWith({
    String? id,
    DateTime? createdTime,
    String? username,
    String? email,
    UserType? type,
    String? phoneNumber,
    String? aboutUser,
    String? photoUrl,
    String? userLocation,
  }) {
    return Users(
      id: id ?? this.id,
      createdTime: createdTime ?? this.createdTime,
      username: username ?? this.username,
      email: email ?? this.email,
      type: type ?? this.type,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      aboutUser: aboutUser ?? this.aboutUser,
      photoUrl: photoUrl ?? this.photoUrl,
      userLocation: userLocation ?? this.userLocation,
    );
  }
}


