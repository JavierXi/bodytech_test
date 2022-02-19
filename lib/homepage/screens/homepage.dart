import 'package:bodytech/first_tab/screens/first_tab.dart';
import 'package:bodytech/second_tab/screens/second_tab.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentIndex = 0;

  @override
  void initState() {
    currentIndex = 0;
    super.initState();
  }

  final body = [
    const FirstTab(),
    const SecondTab(),
  ];

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
      ),
    );
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        body: body[currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.grey,
          elevation: 5,
          iconSize: 25,
          selectedItemColor: Colors.black,
          selectedFontSize: 17,
          selectedLabelStyle: const TextStyle(color: Colors.black),
          unselectedItemColor: Colors.white,
          unselectedFontSize: 14,
          unselectedLabelStyle: const TextStyle(color: Colors.white),
          showSelectedLabels: true,
          showUnselectedLabels: false,
          currentIndex: currentIndex,
          onTap: (index) => setState(() => currentIndex = index),
          items: const [
            BottomNavigationBarItem(
              backgroundColor: Colors.red,
              icon: Icon(Icons.add_a_photo_rounded),
              activeIcon: Icon(
                Icons.add_a_photo_rounded,
                size: 30,
              ),
              tooltip: 'First Tab',
              label: 'First Tab',
            ),
            BottomNavigationBarItem(
              backgroundColor: Colors.red,
              icon: Icon(Icons.view_list_rounded),
              activeIcon: Icon(
                Icons.view_list_rounded,
                size: 30,
              ),
              tooltip: 'Second Tab',
              label: 'Second Tab',
            ),
          ],
        ),
      ),
    );
  }
}
