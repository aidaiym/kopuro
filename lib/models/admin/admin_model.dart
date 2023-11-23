import 'package:json_annotation/json_annotation.dart';
import 'package:kopuro/core/core.dart';
import 'package:kopuro/models/models.dart';

part 'admin_model.g.dart';

@JsonSerializable()
class AdminUser extends Users {
  AdminUser({
    required String id,
    required String username,
    required String email,
    required DateTime createdTime, 
  }) : super(
          id: id,
          username: username,
          email: email,
          type: UserType.admin,
          createdTime: createdTime,
        );

  factory AdminUser.fromJson(Map<String, dynamic> json) => _$AdminUserFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$AdminUserToJson(this);

  @override
  AdminUser copyWith({
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
    return AdminUser(
      id: id ?? this.id,
      username: username ?? this.username,
      email: email ?? this.email,
      createdTime: createdTime ?? this.createdTime,
    );
  }
}
