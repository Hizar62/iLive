import 'package:flutter/material.dart';
import 'package:ilive/pages/dashboard.dart';
import 'package:ilive/pages/live.dart';
import 'package:ilive/pages/message.dart';
import 'package:ilive/pages/profile.dart';
import 'package:ilive/pages/search.dart';

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
    const Live()
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
        onPressed: () {},
        child: Icon(Icons.live_tv_rounded),
        backgroundColor: const Color.fromARGB(255, 218, 20, 20),
        foregroundColor: Colors.white,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
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
