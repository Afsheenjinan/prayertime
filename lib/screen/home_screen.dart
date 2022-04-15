import 'package:geocoding/geocoding.dart' as geocoding;
import 'package:location/location.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import '../data/data.dart';
import '../functions/functions.dart';
import 'first_page.dart';
import 'second_page.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({
    Key? key,
  }) : super(key: key);

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  DateTime today = DateTime.now();
  List<String> prayerList = [
    'Imsak',
    'Fajr',
    'Luhar',
    'Asr',
    'Maghrib',
    'Isha',
  ];
  // String defaultMethod = "MWL";
  String defaultMethod = "Makkah";
  String school = "Shafi"; // Shafi'i, Maliki, Ja'fari, and Hanbali
  late Timer _timer;
  late DateTime _now = DateTime.now();
  late double _nowHourAngle;
  double horizontalParrallax = 34 / 60 + 16 / 60; // 0.833°
  double? _latitude;
  double? _longitude;
  // double _latitudeMakka = 21.4225;
  // double _longitudeMakka = 39.8262;
  late Map<String, double> _solarData;
  late double _sunDeclination;
  late double _equationOfTime;
  late double _timeZone;
  late double _solarNoon;
  Map<String, Data>? prayerTimes = {
    "Imsak": Data(icon: Icons.nightlight_round),
    'Fajr': Data(icon: Icons.wb_twighlight),
    "Sunrise": Data(icon: Icons.wb_twilight_rounded),
    "Noon": Data(icon: Icons.sunny),
    "Luhar": Data(icon: Icons.sunny),
    "Asr": Data(icon: Icons.wb_sunny_rounded),
    "Sunset": Data(icon: Icons.wb_twilight_rounded),
    "Maghrib": Data(icon: Icons.wb_twighlight),
    "Isha": Data(icon: Icons.mode_night_rounded),
    "Midnight": Data(icon: Icons.night_shelter_rounded)
  };
  Map<String, Data>? prayertimesdata;
  String _address = '';

  int _currentIndex = 0;
  late List pages;

  @override
  void initState() {
    super.initState();

    _nowHourAngle = (_now.hour + _now.minute / 60) / 24;
    _timeZone = _now.timeZoneOffset.inMinutes / 60;
    _solarData = getEquationOfTime(JulianCentury(Julian(_now, hour: 12)));
    _equationOfTime = _solarData['Equation of Time']!;
    _sunDeclination = _solarData['Sun Declination']!;

    _timer =
        Timer.periodic(const Duration(seconds: 1), (Timer timer) => _getTime());

    _updatePosition();
  }

  Future<void> _updatePosition() async {
    LocationData locationData = await _determinePosition();
    List<geocoding.Placemark> placeMark =
        await geocoding.placemarkFromCoordinates(
            locationData.latitude!, locationData.longitude!);
    geocoding.Placemark place = placeMark[0];

    setState(() {
      _address = '${place.locality}, ${place.country}';
      _latitude = locationData.latitude;
      _longitude = locationData.longitude;
      // _timeZone = 5.5;
      _solarNoon = (720 - 4 * _longitude! - _equationOfTime + _timeZone * 60) /
          (24 * 60);

      prayertimesdata = getdata();
    });
  }

  Future<LocationData> _determinePosition() async {
    Location location = Location();

    bool _serviceEnabled;
    PermissionStatus _permissionGranted;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return Future.error('Location services are disabled.');
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        Future.error(
            'Location permissions are permanently denied, we cannot request permissions.');
      }
    }

    return await location.getLocation();
  }

  @override
  void dispose() {
    super.dispose();
    _timer.cancel();
  }

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    pages = [
      FirstPage(
          prayertimesdata: prayertimesdata,
          nowHourAngle: _nowHourAngle,
          now: _now,
          prayerList: prayerList,
          address: _address),
      SecondPage()
    ];
    return SafeArea(
      child: Scaffold(
        body: pages[_currentIndex],
        // body: pages[_currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          elevation: 20,
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.access_alarm_rounded), label: 'PrayerTimes'
                // title: new Text('Home'),
                ),
            BottomNavigationBarItem(
                icon: Icon(Icons.dark_mode_outlined), label: 'Dua'
                // title: new Text('Messages'),
                ),
          ],
          // elevation: 100,
          currentIndex:
              _currentIndex, // this will be set when a new tab is tapped
          onTap: _onItemTapped,
          selectedItemColor: Colors.black,
          selectedIconTheme: IconThemeData(size: 25),
          // showSelectedLabels: false,
        ),
      ),
    );
  }

  void _getTime() {
    setState(() {
      _now = DateTime.now();
      _nowHourAngle = (_now.hour + _now.minute / 60) / 24;
    });
  }

  double calculateTime(double angle) {
    return aCos(Sin(angle) / (Cos(_latitude) * Cos(_sunDeclination)) -
            Tan(_latitude) * Tan(_sunDeclination)) *
        (4 / (24 * 60));
  }

  double? calculateHourAngle(String prayerName) {
    double hourAngle;
    int direction;
    if (prayerTimes![prayerName]?.hourAngle != null) {
      return prayerTimes![prayerName]?.hourAngle;
    } else {
      direction = ["Fajr", "Sunrise"].contains(prayerName) ? -1 : 1;
      switch (prayerName) {
        case 'Imsak':
          hourAngle =
              calculateHourAngle("Fajr")! - 10.0 / (60 * 24); // 10 mins less
          break;
        case 'Fajr':
          hourAngle = direction *
              calculateTime(-methods[defaultMethod]["angle"]["Fajr"]);
          break;
        case 'Noon':
          hourAngle = 0;
          break;
        case 'Luhar':
          hourAngle = 0;
          break;
        case 'Asr':
          int shadowFacor = school != "Hambali" ? 1 : 2;
          hourAngle = direction *
              calculateTime(
                  aTan(1 / (shadowFacor + Tan(_latitude! - _sunDeclination))));
          break;
        case 'Maghrib':
          hourAngle = (defaultMethod == "Tehran"
              ? calculateTime(-4.5)
              : defaultMethod == "Jafari"
                  ? calculateTime(-4)
                  : calculateHourAngle("Sunset"))!;
          break;
        case 'Isha':
          hourAngle = defaultMethod != "Makkah"
              ? calculateTime(-methods[defaultMethod]["angle"]["Isha"])
              : calculateHourAngle("Maghrib")! + 1.5 / 24;
          break;
        case 'Midnight':
          String morning =
              ["Tehran", "Jafari"].contains(defaultMethod) ? "Fajr" : "Sunrise";
          hourAngle = (1 +
                  calculateHourAngle(morning)! +
                  calculateHourAngle("Sunset")!) /
              2;
          break;
        default:
          hourAngle = direction * calculateTime(-horizontalParrallax);
          break;
      }

      prayerTimes![prayerName]?.hourAngle = hourAngle;
      return hourAngle;
    }
  }

  getPrayerTime(String prayerName) {
    double time = _solarNoon + calculateHourAngle(prayerName)!;
    time = time % 1; // if time is greater than 1 day, reset time to 0

    int hh = (time * 24).floor();
    int mm = ((time * 24 * 60) % 60).floor();
    int ss = ((time * 24 * 60 * 60) % 60).floor();
    if (ss >= 30) mm = mm + 1;

    TimeOfDay timeOfDay = TimeOfDay(hour: hh, minute: mm);

    prayerTimes![prayerName]?.time = time;
    prayerTimes![prayerName]?.timeOfDay = timeOfDay;
    prayerTimes![prayerName]?.hour12 =
        '${timify(hh > 12 ? hh % 12 : hh)} : ${timify(mm)} ${timeOfDay.period.name}';
    prayerTimes?[prayerName]?.hour24 = '${timify(hh)}:${timify(mm)}';
  }

  String timify(int value) => value.toString().padLeft(2, "0");

  getdata() {
    for (var item in prayerTimes!.keys) {
      getPrayerTime(item);
    }
    return prayerTimes;
  }
}
