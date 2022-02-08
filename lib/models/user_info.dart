import 'package:json_annotation/json_annotation.dart';

part 'user_info.g.dart';

@JsonSerializable()
class UserInfo {
  String firstName;
  String lastName;
  String? id;
  String email;
  String? avatar;

  String? createdAt;
  String? updatedAt;

  UserInfo({
    required this.firstName,
    required this.lastName,
    required this.email,
    this.avatar,
    this.id,
    this.createdAt,
    this.updatedAt,
  });

  factory UserInfo.fromJson(Map<String, dynamic> json) =>
      _$UserInfoFromJson(json);
  Map<String, dynamic> toJson() => _$UserInfoToJson(this);
}
