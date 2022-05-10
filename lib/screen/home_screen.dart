import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'prayertimes_page.dart';
import 'qibla_page.dart';
import 'dua_page.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({
    Key? key,
  }) : super(key: key);

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  int _currentIndex = 0;
  late List<Widget> pages;

  double? _latitude;
  double? _longitude;
  String _address = '';

  double distanceInMeters = 0.0;
  double bearingInAngle = 0.0;

  SharedPreferences? sharedPreferences;

  PageController pageController = PageController();

  @override
  void initState() {
    super.initState();

    _updatePosition();
  }

  Future<void> _updatePosition() async {
    // LocationData locationData = await _determinePosition();
    sharedPreferences = await SharedPreferences.getInstance();
    Position? lastKnownPosition = await Geolocator.getLastKnownPosition();
    Position locationData = await _determinePosition();

    List<Placemark> placeMark = await placemarkFromCoordinates(
        locationData.latitude, locationData.longitude);
    Placemark place = placeMark[0];

    setState(() {
      _address = '${place.locality}, ${place.country}';

      _latitude ??= lastKnownPosition?.latitude;
      _longitude ??= lastKnownPosition?.longitude;

      _latitude = locationData.latitude;
      _longitude = locationData.longitude;
      pages = [
        PrayerTimesPage(
          sharedPreferences: sharedPreferences,
          latitude: _latitude,
          longitude: _longitude,
          address: _address,
        ),
        QiblaPage(
          latitude: _latitude,
          longitude: _longitude,
        ),
        DuaPage(
          sharedPreferences: sharedPreferences,
        )
      ];
    });
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue accessing the position and request users of the  App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try requesting permissions again (this is also where Android's shouldShowRequestPermissionRationale returned true.
        // According to Android guidelines your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can continue accessing the position of the device.
    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.low);
  }

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
      pageController.animateToPage(
        index,
        duration: const Duration(milliseconds: 500),
        curve: Curves.ease,
      );
    });
  }

  void onPageChanged(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: (_latitude != null && sharedPreferences != null)
          ? Scaffold(
              body: PageView(
                children: pages,
                controller: pageController,
                onPageChanged: onPageChanged,
              ),
              bottomNavigationBar: BottomNavigationBar(
                items: const [
                  BottomNavigationBarItem(
                      icon: Icon(Icons.access_alarm_rounded),
                      label: 'PrayerTimes'),
                  BottomNavigationBarItem(
                      icon: ImageIcon(AssetImage("assets/images/qibla_32.png")),
                      label: 'Qibla'),
                  BottomNavigationBarItem(
                      icon: ImageIcon(AssetImage("assets/images/dua_32.png")),
                      label: 'Dua'),
                ],
                currentIndex: _currentIndex,
                onTap: _onItemTapped,
              ),
            )
          : Scaffold(
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('ٱلسَّلَامُ عَلَيْكُمْ',
                        style: Theme.of(context).textTheme.headline6),
                    Text('وَرَحْمَةُ ٱللَّٰهِ',
                        style: Theme.of(context).textTheme.headline6),
                    Text('وَبَرَكَاتُهُ',
                        style: Theme.of(context).textTheme.headline6),
                  ],
                ),
              ),
            ),
    );
  }
}
