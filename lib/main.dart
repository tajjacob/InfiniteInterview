import 'package:colour/colour.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:interview_infinite/models/fav_contact.dart';
import 'package:interview_infinite/pages/mycontact_page.dart';
import 'package:material_color_generator/material_color_generator.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  Hive.registerAdapter(FavContactAdapter());
  await Hive.openBox<FavContact>('favContacts');
  // await Hive.openBox("favContacts");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Infinite Interview',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        brightness: Brightness.light,
        primarySwatch: generateMaterialColor(color: Colour('#32baa5')),
        // primaryColor: Colour('#32baa5'),
        textTheme: GoogleFonts.ralewayTextTheme(
          Theme.of(context)
              .textTheme, // If this is not set, then ThemeData.light().textTheme is used.
        ),
        fontFamily: 'Raleway',
      ),
      home: MyContactPage(),
    );
  }
}
