import 'package:interview_infinite/models/data.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_list.g.dart';

@JsonSerializable()
class UserList {
  @JsonKey(name: "page")
  int page;

  @JsonKey(name: "per_page")
  int perPage;

  @JsonKey(name: "total")
  int total;

  @JsonKey(name: "total_pages")
  int totalPages;

  @JsonKey(name: "data")
  List<Data> data;

  UserList({
    required this.page,
    required this.perPage,
    required this.total,
    required this.totalPages,
    required this.data,
  });

  factory UserList.fromJson(Map<String, dynamic> json) =>
      _$UserListFromJson(json);
  Map<String, dynamic> toJson() => _$UserListToJson(this);
}
