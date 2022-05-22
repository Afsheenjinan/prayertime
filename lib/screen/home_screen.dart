import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'prayertimes_page.dart';
import 'qibla_page.dart';
import 'dua_page.dart';

class LocationData {
  final Placemark placemark;
  final Position position;
  LocationData({required this.position, required this.placemark});
}

class Homescreen extends StatefulWidget {
  const Homescreen({
    Key? key,
  }) : super(key: key);

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> with WidgetsBindingObserver {
  int _currentIndex = 0;
  late List<Widget> pages;
  final PageStorageBucket _pageStorageBucket = PageStorageBucket();

  SharedPreferences? sharedPreferences;

  PageController pageController = PageController();

  bool isLocationServiceEnabled = false;
  LocationPermission permissionStatus = LocationPermission.denied;

  Future<LocationData>? _future;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addObserver(this);
    _future = _updatePosition();
  }

  @override
  void dispose() {
    WidgetsBinding.instance?.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        setState(() {
          _future = _updatePosition();
        });
        break;
      case AppLifecycleState.inactive:
        break;
      case AppLifecycleState.paused:
        break;
      case AppLifecycleState.detached:
        break;
    }
  }

  Future<LocationData> _updatePosition() async {
    sharedPreferences = await SharedPreferences.getInstance();
    Position position = await _determinePosition();
    List<Placemark> placeMark = await placemarkFromCoordinates(position.latitude, position.longitude);
    Placemark place = placeMark[0];

    LocationData locationData = LocationData(position: position, placemark: place);
    setState(() {
      pages = [
        PrayerTimesPage(
          sharedPreferences: sharedPreferences,
          locationData: locationData,
        ),
        QiblaPage(locationData: locationData),
        DuaPage(
          key: const PageStorageKey('duaPageKey'),
          sharedPreferences: sharedPreferences,
        )
      ];
    });
    return locationData;
  }

  Future<Position> _determinePosition() async {
    isLocationServiceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!isLocationServiceEnabled) {
      return Future.error('Location services are disabled.\n\nNeed Location for calculations');
    }

    permissionStatus = await Geolocator.checkPermission();

    if (permissionStatus == LocationPermission.denied) {
      permissionStatus = await Geolocator.requestPermission();
      if (permissionStatus == LocationPermission.denied) {
        return Future.error('Location permissions are denied.\nCalculations are based on location.\nPlease allow access to Course Location');
      }
    }
    if (permissionStatus == LocationPermission.deniedForever) {
      return Future.error('Location permissions are permanently denied.\nCalculations are based on location.\nApp cannot be used');
    }
    return await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.low);
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
      child: FutureBuilder(
        future: _future,
        builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
          return snapshot.hasData
              ? Scaffold(
                  body: PageStorage(
                    bucket: _pageStorageBucket,
                    child: PageView(
                      children: pages,
                      controller: pageController,
                      onPageChanged: onPageChanged,
                    ),
                  ),
                  bottomNavigationBar: BottomNavigationBar(
                    items: const [
                      BottomNavigationBarItem(icon: Icon(Icons.access_alarm_rounded), label: 'PrayerTimes'),
                      BottomNavigationBarItem(icon: ImageIcon(AssetImage("assets/images/qibla_32.png")), label: 'Qibla'),
                      BottomNavigationBarItem(icon: ImageIcon(AssetImage("assets/images/dua_32.png")), label: 'Dua'),
                    ],
                    currentIndex: _currentIndex,
                    onTap: _onItemTapped,
                  ),
                )
              : Scaffold(
                  body: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Text(
                        'ٱلسَّلَامُ عَلَيْكُمْ \n وَرَحْمَةُ ٱللَّٰهِ \n وَبَرَكَاتُهُ',
                        textDirection: TextDirection.rtl,
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, fontFamily: 'ScheherazadeNew'),
                        textAlign: TextAlign.center,
                      ),
                      snapshot.hasError
                          ? Column(
                              children: [
                                Text(snapshot.error.toString()),
                                const SizedBox(height: 20),
                                !isLocationServiceEnabled
                                    ? ElevatedButton(
                                        onPressed: openLocationSettings,
                                        child: const Text('Open Location Settings'),
                                      )
                                    : (permissionStatus == LocationPermission.denied || permissionStatus == LocationPermission.deniedForever)
                                        ? ElevatedButton(
                                            // permission_handler
                                            onPressed: openApplicationSettings,
                                            child: const Text('Open App Settings'),
                                          )
                                        : const LinearProgressIndicator(),
                              ],
                            )
                          : snapshot.connectionState == ConnectionState.waiting
                              ? Column(
                                  children: const [
                                    Text('please Wait...\n'),
                                    LinearProgressIndicator(),
                                  ],
                                )
                              : const LinearProgressIndicator(),
                    ],
                  ),
                );
        },
      ),
    );
  }

  void openApplicationSettings() {
    Geolocator.openAppSettings();
  }

  void openLocationSettings() {
    Geolocator.openLocationSettings();
  }
}
