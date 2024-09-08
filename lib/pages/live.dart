import 'dart:math';

import 'package:flutter/material.dart';
import 'package:zego_uikit_prebuilt_live_streaming/zego_uikit_prebuilt_live_streaming.dart';

class LivePage extends StatelessWidget {
  final String liveID; // The Live Stream ID entered by the user
  final bool isHost; // Whether the user is the host or not

  const LivePage({Key? key, required this.liveID, this.isHost = false})
      : super(key: key);

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
        child: ZegoUIKitPrebuiltLiveStreaming(
          appID:
              7826576485, // Replace with your actual appID from ZEGOCLOUD Admin Console
          appSign:
              'kjdfjdfkn', // Replace with your actual appSign from ZEGOCLOUD Admin Console
          userID: 'user_id_' + Random().nextInt(100).toString(),
          userName: 'user_name_' + Random().nextInt(100).toString(),
          liveID: liveID, // Pass the Live Stream ID entered in the dialog
          config: isHost
              ? ZegoUIKitPrebuiltLiveStreamingConfig.host()
              : ZegoUIKitPrebuiltLiveStreamingConfig.audience(),
        ),
      ),
    );
  }
}
