import 'package:colour/colour.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:interview_infinite/custom_widgets/mycontact_search.dart';
import 'package:interview_infinite/custom_widgets/mycontact_tab.dart';
import 'package:interview_infinite/pages/contact_create_page.dart';
import 'package:interview_infinite/pages/mycontact_fav.dart';
import 'package:interview_infinite/pages/mycontact_list.dart';
import 'package:interview_infinite/pages/search_page.dart';

class MyContactPage extends StatefulWidget {
  const MyContactPage({Key? key}) : super(key: key);

  @override
  State<MyContactPage> createState() => _MyContactPageState();
}

class _MyContactPageState extends State<MyContactPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'My Contacts',
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
            icon: const FaIcon(FontAwesomeIcons.syncAlt),
            color: Colors.white,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SearchPage()),
              );
            },
          )
        ],
      ),
      body: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: const <Widget>[
            MyContactSearch(),
            MyContactTab(
              tab1: MyContactList(),
              tab2: MyContactFav(),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colour('#32baa5'),
        foregroundColor: Colors.white,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const ContactCreatePage()),
          );
        },
        tooltip: 'Create New Contact',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
