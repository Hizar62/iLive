import 'package:flutter/material.dart';
import 'package:zego_uikit_prebuilt_live_streaming/zego_uikit_prebuilt_live_streaming.dart';

void jumpToLivePage(BuildContext context, {required bool isHost}) {
  Navigator.push(context,
      MaterialPageRoute(builder: (context) => LivePage(isHost: isHost)));
}

class LivePage extends StatelessWidget {
  const LivePage({Key? key, this.isHost = false}) : super(key: key);
  final bool isHost;

  get userID => null;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ZegoUIKitPrebuiltLiveStreaming(
        appID: 1013754140, // use your appID
        appSign:
            'daf86d70032bda557bebfb4551f8e5d5a5657325870201132921bce60a07133f', // use your appSign
        userID: userID,
        userName: 'user_$userID',
        liveID: 'testLiveID',
        config: isHost
            ? ZegoUIKitPrebuiltLiveStreamingConfig.host()
            : ZegoUIKitPrebuiltLiveStreamingConfig.audience(),
      ),
    );
  }
}
