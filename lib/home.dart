import 'package:flutter/material.dart';
import 'package:ilive/pages/dashboard.dart';
// import 'package:ilive/pages/live.dart';
import 'package:ilive/pages/message.dart';
import 'package:ilive/pages/profile.dart';
import 'package:ilive/pages/search.dart';
import 'package:zego_uikit_prebuilt_live_streaming/zego_uikit_prebuilt_live_streaming.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int currentTab = 0;
  final List<Widget> screens = [
    const Dashboard(),
    const Search(),
    const Message(),
    const Profile(),
    // const LivePage()
  ];

  final PageStorageBucket bucket = PageStorageBucket();
  Widget currentScreen = Dashboard();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('iLive'),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 218, 20, 20),
        foregroundColor: Colors.white,
      ),
      body: PageStorage(bucket: bucket, child: currentScreen),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          jumpToLivePage(context, isHost: true);
        },
        backgroundColor: const Color.fromARGB(255, 218, 20, 20),
        foregroundColor: Colors.white,
        shape: const CircleBorder(),
        child: const Icon(Icons.live_tv_rounded),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 10,
        child: Container(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MaterialButton(
                    minWidth: 40,
                    onPressed: () {
                      setState(() {
                        currentScreen = Dashboard();
                        currentTab = 0;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.home,
                            size: 30.0,
                            color: currentTab == 0
                                ? const Color.fromARGB(255, 218, 20, 20)
                                : Colors.grey)
                      ],
                    ),
                  ),
                  const SizedBox(width: 20),
                  MaterialButton(
                    minWidth: 40,
                    onPressed: () {
                      setState(() {
                        currentScreen = Search();
                        currentTab = 1;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.search,
                            size: 30.0,
                            color: currentTab == 1
                                ? const Color.fromARGB(255, 218, 20, 20)
                                : Colors.grey)
                      ],
                    ),
                  ),
                ],
              ),
              // Right bottom button
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  MaterialButton(
                    minWidth: 40,
                    onPressed: () {
                      setState(() {
                        currentScreen = Message();
                        currentTab = 2;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.message,
                            size: 30.0,
                            color: currentTab == 2
                                ? const Color.fromARGB(255, 218, 20, 20)
                                : Colors.grey)
                      ],
                    ),
                  ),
                  const SizedBox(width: 20),
                  MaterialButton(
                    minWidth: 40,
                    onPressed: () {
                      setState(() {
                        currentScreen = Profile();
                        currentTab = 3;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.person,
                            size: 30.0,
                            color: currentTab == 3
                                ? const Color.fromARGB(255, 218, 20, 20)
                                : Colors.grey)
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

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
