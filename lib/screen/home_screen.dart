import 'package:flutter/material.dart';
import 'first_page.dart';
// import 'qibla_page.dart';
import 'second_page.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({
    Key? key,
  }) : super(key: key);

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  int _currentIndex = 0;
  late List pages;

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    // pages = const [FirstPage(), Compass(), SecondPage()];
    pages = const [FirstPage(), SecondPage()];

    return SafeArea(
      child: Scaffold(
        body: pages[_currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          elevation: 20,
          items: [
            const BottomNavigationBarItem(
                icon: Icon(Icons.access_alarm_rounded), label: 'PrayerTimes'),
            // BottomNavigationBarItem(
            //     icon: Icon(Icons.arrow_circle_up_sharp), label: 'Qibla'
            //     ),
            BottomNavigationBarItem(
                // icon: Icon(Icons.dark_mode_outlined), label: 'Dua'),
                icon: Image.asset("assets/images/Dua_Icon_32.png"),
                activeIcon: Image.asset(
                  "assets/images/Dua_Icon_32.png",
                  color: Colors.green.shade900,
                ),
                label: 'Dua'),
          ],
          currentIndex: _currentIndex,
          onTap: _onItemTapped,
          selectedItemColor: Colors.green.shade900,
        ),
      ),
    );
  }
}
