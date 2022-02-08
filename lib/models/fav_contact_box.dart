import 'package:hive/hive.dart';
import 'package:interview_infinite/models/fav_contact.dart';

class FavBoxes {
  static Box<FavContact> getFavBoxes() => Hive.box<FavContact>('favContacts');
}
