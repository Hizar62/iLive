import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:live/constants.dart';
import 'package:zego_uikit_prebuilt_live_streaming/zego_uikit_prebuilt_live_streaming.dart';

class LivePage extends StatefulWidget {
  final String liveID; // The Live Stream ID entered by the user
  final bool isHost; // Whether the user is the host or not

  const LivePage({super.key, required this.liveID, this.isHost = false});

  @override
  _LivePageState createState() => _LivePageState();
}

class _LivePageState extends State<LivePage> {
  String? userName;

  @override
  void initState() {
    super.initState();
    fetchUsername(); // Fetch username when the widget is initialized
  }

  Future<void> fetchUsername() async {
    String? fetchedUsername = await getUsername();
    setState(() {
      userName = fetchedUsername;
    });
  }

  Future<String?> getUsername() async {
    User? currentUser = FirebaseAuth.instance.currentUser;

    if (currentUser != null) {
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(currentUser.uid)
          .get();

      if (userDoc.exists) {
        return userDoc['username'];
      }
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Live Streaming'),
        foregroundColor: Colors.white,
        centerTitle: true,
        backgroundColor: Colors.redAccent,
      ),
      body: SafeArea(
        child: userName == null
            ? const Center(
                child:
                    CircularProgressIndicator()) // Show loading indicator until username is loaded
            : ZegoUIKitPrebuiltLiveStreaming(
                appID: Constants
                    .appID, // Replace with your actual appID from ZEGOCLOUD Admin Console
                appSign: Constants
                    .appSign, // Replace with your actual appSign from ZEGOCLOUD Admin Console
                userID: 'user_id_${Random().nextInt(100)}',
                userName: userName!, // Pass the fetched username
                liveID: widget
                    .liveID, // Pass the Live Stream ID entered in the dialog
                config: widget.isHost
                    ? ZegoUIKitPrebuiltLiveStreamingConfig.host()
                    : ZegoUIKitPrebuiltLiveStreamingConfig.audience(),
              ),
      ),
    );
  }
}
