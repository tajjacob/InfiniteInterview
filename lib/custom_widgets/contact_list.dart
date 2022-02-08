import 'package:colour/colour.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:interview_infinite/custom_widgets/contact_card.dart';
import 'package:interview_infinite/models/fav_contact.dart';
import 'package:interview_infinite/models/fav_contact_box.dart';
import 'package:interview_infinite/models/reqres.dart';
import 'package:interview_infinite/pages/profile_edit_page.dart';
import 'package:interview_infinite/pages/profile_page.dart';
import 'package:interview_infinite/services/dio_client.dart';

class ContactList extends StatelessWidget {
  const ContactList({Key? key, this.dataList}) : super(key: key);
  final List<Data>? dataList;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: dataList!.length,
      itemBuilder: (context, index) {
        return Slidable(
          key: ValueKey(dataList![index].id),
          // The start action pane is the one at the left or the top side.
          startActionPane: ActionPane(
            // A motion is a widget used to control how the pane animates.
            motion: ScrollMotion(),

            // A pane can dismiss the Slidable.
            // dismissible: DismissiblePane(onDismissed: () {}),

            // All actions are defined in the children parameter.
            children: [
              // A SlidableAction can have an icon and/or a label.
              SlidableAction(
                onPressed: (BuildContext context) {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        content:
                            const Text("Add this contact to your favourite?"),
                        actions: [
                          TextButton(
                              onPressed: () {
                                final favContact = FavContact()
                                  ..firstName =
                                      dataList![index].firstName.toString()
                                  ..lastName =
                                      dataList![index].lastName.toString()
                                  ..email = dataList![index].email.toString()
                                  ..avatar = dataList![index].avatar.toString()
                                  ..id = dataList![index].id;
                                final box = FavBoxes.getFavBoxes();
                                box.add(favContact);

                                Navigator.of(context).pop();
                              },
                              child: Text('Yes',
                                  style: TextStyle(color: Colour('#32baa5')))),
                          TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text('No',
                                  style: TextStyle(color: Colors.red))),
                        ],
                      );
                    },
                  );
                },
                backgroundColor: Colour('#EBF8F6'),
                foregroundColor: Colors.black,
                icon: Icons.star,
                label: 'Favourite',
              ),
            ],
          ),

          // The end action pane is the one at the right or the bottom side.
          endActionPane: ActionPane(
            motion: ScrollMotion(),
            children: [
              SlidableAction(
                // An action can be bigger than the others.
                onPressed: (BuildContext context) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProfileEditPage(
                        avatar: dataList![index].avatar.toString(),
                        firstName: dataList![index].firstName.toString(),
                        lastName: dataList![index].lastName.toString(),
                        email: dataList![index].email.toString(),
                        id: dataList![index].id.toString(),
                      ),
                    ),
                  );
                },
                backgroundColor: Colour('#EBF8F6'),
                foregroundColor: Colors.yellow[600],
                icon: Icons.edit,
                label: 'Edit',
              ),
              SlidableAction(
                onPressed: (BuildContext context) {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        content: const Text(
                            "Are you sure you want to delete this contact?"),
                        actions: [
                          TextButton(
                              onPressed: () {
                                DioClient().deleteUser(
                                    id: dataList![index].id.toString());
                                Navigator.of(context).pop();
                              },
                              child: const Text('Yes',
                                  style: TextStyle(color: Colors.red))),
                          TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text('No',
                                  style: TextStyle(color: Colour('#32baa5')))),
                        ],
                      );
                    },
                  );
                },
                backgroundColor: Colour('#EBF8F6'),
                foregroundColor: Colors.red,
                icon: Icons.delete_forever_sharp,
                label: 'Delete',
              ),
            ],
          ),
          child: ContactCard(
            avatar: dataList![index].avatar.toString(),
            firstName: dataList![index].firstName.toString(),
            lastName: dataList![index].lastName.toString(),
            email: dataList![index].email.toString(),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ProfilePage(
                          firstName: dataList![index].firstName.toString(),
                          lastName: dataList![index].lastName.toString(),
                          email: dataList![index].email.toString(),
                          avatar: dataList![index].avatar.toString(),
                          id: dataList![index].id.toString(),
                        )),
              );
            },
          ),
        );
      },
    );
  }
}

void doNothing(BuildContext context) {}
