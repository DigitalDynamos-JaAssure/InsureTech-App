import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:insuretech_ja_assure/constants.dart';
import 'package:insuretech_ja_assure/screens/home_screen.dart';
import 'package:insuretech_ja_assure/screens/loading_screen.dart';
import 'package:insuretech_ja_assure/screens/verification_screen.dart';
import 'package:insuretech_ja_assure/screens/welcome_screen.dart';

void main() async {
  await Hive.initFlutter();
  await Hive.openBox("myBox");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'InsureTech',
      theme: ThemeData(
        useMaterial3: true,
        textTheme: GoogleFonts.nunitoTextTheme(),
        primarySwatch: kPrimaryMaterialColor,
      ),
      routes: {
        '/homePage': (buildContext) => HomeScreen(),
      },
      home: HomeScreen(),
    );
  }
}
