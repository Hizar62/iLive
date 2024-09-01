import 'package:flutter/material.dart';
import 'package:live/services/auth_service.dart';
import 'package:live/widgets/round_button.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    bool loading = false;

    return Scaffold(
      body: Center(
          child: RoundButton(
              loading: loading,
              title: 'Logout',
              onTap: () async {
                await AuthService().signout(context: context);
              })),
    );
  }
}
