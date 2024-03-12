import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
            centerTitle: true,
            title: const Text(
              "iLive",
            ),
            backgroundColor: const Color.fromARGB(255, 218, 20, 20),
            foregroundColor: Colors.white),
      ),
    );
  }
}
