import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const Center(
          child: Text(
        'Profile Screen',
        style: TextStyle(fontSize: 40),
      )),
    );
  }
}
