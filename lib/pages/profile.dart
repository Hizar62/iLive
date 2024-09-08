import 'package:flutter/material.dart';
import 'package:live/services/auth_service.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(255, 218, 20, 20),
                    foregroundColor: Colors.white,
                    // padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                    textStyle:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                onPressed: () async {
                  await AuthService().signout(context: context);
                },
                child: const Text(
                  'Logout',
                  style: TextStyle(),
                ))));
  }
}
