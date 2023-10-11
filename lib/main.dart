import 'package:festiva/presentation/homepage.dart';
import 'package:festiva/utility/constants.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const Festiva());
}

List<String> titles = <String>[
  'Cloud',
  'Beach',
  'Sunny',
];

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
      home: const HomePage(),
    );
  }
}
