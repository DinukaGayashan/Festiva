import 'package:festiva/presentation/homepage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

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
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          brightness: Brightness.dark,
        ),
        listTileTheme: ListTileThemeData(
          tileColor: Colors.blueGrey.shade600,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
        ),
      ),
      initialRoute: HomePage.id,
      routes: {
        HomePage.id: (context) => const HomePage(),
      },
      home: const HomePage(),
    );
  }
}
