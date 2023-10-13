import 'package:festiva/presentation/add_event.dart';
import 'package:festiva/presentation/homepage.dart';
import 'package:festiva/utility/constants.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const Festiva());
}

class Festiva extends StatelessWidget {
  const Festiva({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Festiva',
      theme: ThemeData(
        useMaterial3: true,
        primaryColor: kBaseColor1,
        scaffoldBackgroundColor: kBackgroundColor,
        brightness: Brightness.dark,
        fontFamily: 'NotoSans',
      ),
      initialRoute: HomePage.id,
      routes: {
        HomePage.id: (context) => const HomePage(),
        AddEvent.id: (context) => const AddEvent(),
      },
      home: const HomePage(),
    );
  }
}
