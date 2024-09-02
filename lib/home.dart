import 'package:flutter/material.dart';
import 'package:live/pages/dashboard.dart';
// import 'package:live/pages/message.dart';
import 'package:live/pages/messageScreen.dart';
import 'package:live/pages/profile.dart';
import 'package:live/pages/search.dart';
// import 'package:zego_uikit_prebuilt_live_streaming/zego_uikit_prebuilt_live_streaming.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int currentTab = 0;
  final liveIdController = TextEditingController();

  final List<Widget> screens = [
    const Dashboard(),
    const Search(),
    const MessageScreen(
      String: null,
    ),
    const Profile(),
    // const LivePage()
  ];

  final PageStorageBucket bucket = PageStorageBucket();
  Widget currentScreen = const Dashboard();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('iLive'),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 218, 20, 20),
        foregroundColor: Colors.white,
        automaticallyImplyLeading: false,
      ),
      body: PageStorage(bucket: bucket, child: currentScreen),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showDialogButton();
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
                        currentScreen = MessageScreen(
                          String: null,
                        );
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

  Future<void> _showDialogButton() async {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Enter LiveStream Id'),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: liveIdController,
                decoration: const InputDecoration(
                  hintText: 'LiveStream Id',
                  border: OutlineInputBorder(),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                // jumpToLivePage(context, liveIdController, isHost: true);
                Navigator.pop(context);
              },
              child: const Text('Start'),
            ),
          ],
        );
      },
    );
  }
}
