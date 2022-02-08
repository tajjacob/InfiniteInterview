//https://www.youtube.com/watch?v=w8cZKm9s228
import 'package:hive/hive.dart';

part 'fav_contact.g.dart';

@HiveType(typeId: 0)
class FavContact extends HiveObject {
  @HiveField(0)
  late final int id;
  @HiveField(1)
  late final String email;
  @HiveField(2)
  late final String firstName;
  @HiveField(3)
  late final String lastName;
  @HiveField(4)
  late final String avatar;
}
