import 'package:json_annotation/json_annotation.dart';
import 'package:kopuro/core/core.dart';
import 'package:kopuro/models/models.dart';

part 'company_model.g.dart';

@JsonSerializable()
class CompanyUser extends Users {
  final String? linkedIn;

  CompanyUser({
    required String id,
    required String username,
    required String email,
    required DateTime createdTime, 
    required this.linkedIn,
    String? phoneNumber,
    String? aboutUser,
    String? photoUrl,
    String? userLocation,
  }) : super(
          id: id,
          username: username,
          email: email,
          type: UserType.company,
          createdTime: createdTime, 
          phoneNumber: phoneNumber,
          aboutUser: aboutUser,
          photoUrl: photoUrl,
          userLocation: userLocation,
        );

  factory CompanyUser.fromJson(Map<String, dynamic> json) => _$CompanyUserFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$CompanyUserToJson(this);

  @override
  CompanyUser copyWith({
    String? id,
    DateTime? createdTime,
    String? username,
    String? email,
    UserType? type,
    String? phoneNumber,
    String? aboutUser,
    String? photoUrl,
    String? userLocation,
    String? linkedIn,
  }) {
    return CompanyUser(
      id: id ?? this.id,
      username: username ?? this.username,
      email: email ?? this.email,
      createdTime: createdTime ?? this.createdTime,
      linkedIn: linkedIn ?? this.linkedIn,
    );
  }
}
