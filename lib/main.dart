import 'package:flutter/material.dart';
import 'pages/home_page.dart';

void main() {
  runApp(const BlocNotesApp());
}

class BlocNotesApp extends StatelessWidget {
  const BlocNotesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Bloc-Notes',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
    );
  }
}