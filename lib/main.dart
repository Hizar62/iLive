import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
// import 'package:ilive/home.dart';hhh
import 'package:ilive/regsiter.dart';

void main() {
  runApp(const MyApp());
  Firebase.initializeApp();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'iLive',
      theme: ThemeData(primarySwatch: Colors.red),
      debugShowCheckedModeBanner: false,
      home: const Register(),
    );
  }
}
