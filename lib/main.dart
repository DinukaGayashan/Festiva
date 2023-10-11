import 'package:festiva/presentation/homepage.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const Festiva());
}

class Festiva extends StatelessWidget {
  const Festiva({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

