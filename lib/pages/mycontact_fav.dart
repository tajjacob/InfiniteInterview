import 'package:colour/colour.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:interview_infinite/custom_widgets/contact_card.dart';
import 'package:interview_infinite/custom_widgets/photo_widget.dart';
import 'package:interview_infinite/models/fav_contact.dart';
import 'package:interview_infinite/models/fav_contact_box.dart';

class MyContactFav extends StatefulWidget {
  const MyContactFav({Key? key}) : super(key: key);

  @override
  _MyContactFavState createState() => _MyContactFavState();
}

class _MyContactFavState extends State<MyContactFav> {
  @override
  void dispose() {
    // Hive.close();
    Hive.box('favContacts').close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Box<FavContact>>(
      valueListenable: FavBoxes.getFavBoxes().listenable(),
      builder: (context, box, _) {
        final favContacts = box.values.toList().cast<FavContact>();

        return buildContent(favContacts, box);
      },
    );
  }

  Widget buildContent(List<FavContact> favContacts, Box box) {
    if (favContacts.isEmpty) {
      return Column(
        children: const [
          PhotoWidget(),
          Text(
            'No Favourite Contact Yet',
          ),
        ],
      );
    } else {
      return ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: favContacts.length,
        itemBuilder: (BuildContext context, int index) {
          final favContact = favContacts[index];

          return buildFavContactList(context, favContact, box);
        },
      );
    }
  }

  Widget buildFavContactList(
    BuildContext context,
    FavContact favContact,
    Box box,
  ) {
    final String avatar = favContact.avatar;
    final String firstName = favContact.firstName;
    final String lastName = favContact.lastName;
    final String email = favContact.email;
    final int id = favContact.id;

    return ContactCard(
      avatar: avatar,
      firstName: firstName,
      lastName: lastName,
      email: email,
      onTap: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              content: const Text(
                  "Are you sure you want to delete this contact from favourite?"),
              actions: [
                TextButton(
                    onPressed: () async {
                      // final box = FavBoxes.getFavBoxes();
                      // await box.delete(favContact.id);
                      await favContact.delete();
                      // box.deleteAt(id);
                      // box.delete(favContact);
                      print('delete ${favContact.firstName.toString()}');
                      Navigator.of(context).pop();
                    },
                    child:
                        const Text('Yes', style: TextStyle(color: Colors.red))),
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child:
                        Text('No', style: TextStyle(color: Colour('#32baa5')))),
              ],
            );
          },
        );
      },
    );
  }
}
