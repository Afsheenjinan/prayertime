import 'dart:async';
import 'package:geocoding/geocoding.dart' as geocoding;
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'dart:math' as math;
import '../data/data.dart';
import '../functions/functions.dart';

class FirstPage extends StatefulWidget {
  const FirstPage({Key? key}) : super(key: key);

  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  String defaultMethod = "Makkah";
  String school = "Shafi'i"; // Shafi'i, Maliki, Ja'fari, and Hanbali
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
  Map<String, Data> prayerTimes = {
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
  List<String> prayerList = [
    'Imsak',
    'Fajr',
    'Sunrise',
    'Luhar',
    'Asr',
    'Maghrib',
    'Isha',
    'Midnight'
  ];

  Map<String, Data>? prayertimesdata;
  String _address = '';

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
      _solarNoon = (720 - 4 * _longitude! - _equationOfTime + _timeZone * 60) /
          (24 * 60);

      getdata();
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
    if (prayerTimes[prayerName]?.hourAngle != null) {
      return prayerTimes[prayerName]?.hourAngle;
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
          int shadowFacor = school != "Hanbali" ? 1 : 2;
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

      // prayerTimes[prayerName]?.hourAngle = hourAngle;
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

    prayerTimes[prayerName]?.time = time;
    prayerTimes[prayerName]?.timeOfDay = timeOfDay;
    prayerTimes[prayerName]?.hour12 =
        '${timify(hh > 12 ? hh % 12 : hh)} : ${timify(mm)} ${timeOfDay.period.name}';
    prayerTimes[prayerName]?.hour24 = '${timify(hh)}:${timify(mm)}';
  }

  String timify(int value) => value.toString().padLeft(2, "0");

  getdata() {
    for (var item in prayerTimes.keys) {
      getPrayerTime(item);
    }
    // return prayerTimes;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.location_on_outlined,
              size: 15,
              semanticLabel: 'Location',
              color: _latitude == null ? Colors.white : Colors.green,
            ),
            const SizedBox(
              width: 10,
            ),
            Text(_address),
          ],
        ),
        Stack(
          children: [
            SolarBackground(prayerTimes: prayerTimes),
            Positioned(
              top: (((_nowHourAngle - 0.5).abs()) * 1.5 + 0.25) * (100 + 16) -
                  16,
              left: _nowHourAngle *
                      (MediaQuery.of(context).size.width - 40 + 16) -
                  16,
              child: Container(
                height: 16,
                width: 16,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(8)),
                  // color: _nowHourAngle > prayerTimes!['Sunset']?.time ||
                  //         _nowHourAngle < prayerTimes!['Sunrise']!.time
                  //     ? Colors.red.shade500
                  //     : Colors.yellow.shade500,
                  color: Colors.yellow,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 0,
                      blurRadius: 2,
                    )
                  ],
                ),
                margin:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                padding: const EdgeInsets.all(8),
              ),
            ),
          ],
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Row(
            children: [
              Text(DateFormat('yyyy-MM-dd').format(_now),
                  style: Theme.of(context).textTheme.headline6),
              const Flexible(
                fit: FlexFit.tight,
                child: Text(
                  '',
                ),
              ),
              Text(DateFormat('hh:mm:ss a').format(_now),
                  style: Theme.of(context).textTheme.headline6)
            ],
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Expanded(
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: prayerList.length,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(5)),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 0,
                      blurRadius: 10,
                    )
                  ],
                ),
                margin:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                padding: const EdgeInsets.all(8),
                child: IntrinsicHeight(
                  child: Row(
                    children: [
                      Icon(
                        Icons.access_time_rounded,
                        semanticLabel: prayerList[index],
                      ),
                      const VerticalDivider(color: Colors.black),
                      Flexible(
                        fit: FlexFit.tight,
                        child: Text(
                          prayerList[index],
                        ),
                      ),
                      prayerTimes[prayerList]?.icon != null
                          ? Icon(
                              prayerTimes[prayerList[index]]?.icon,
                              semanticLabel: prayerList[index],
                            )
                          : const Text(''),
                      const VerticalDivider(color: Colors.black),
                      Text(
                        prayerTimes[prayerList[index]]?.hour12 ??
                            '- - : - -  - -',
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            DropdownButton<String>(
              dropdownColor: Colors.green.shade50,
              isDense: true,
              iconSize: 0.0,
              value: defaultMethod,
              alignment: AlignmentDirectional.center,
              items: methods.keys.map<DropdownMenuItem<String>>(
                (String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(methods[value]['title'].toString()),
                  );
                },
              ).toList(),
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              underline: const SizedBox.shrink(),
              style: TextStyle(color: Colors.green.shade900, fontSize: 12),
              onChanged: (String? string) {
                setState(() {
                  defaultMethod = string!;
                  getdata();
                });
              },
            ),
            DropdownButton<String>(
              dropdownColor: Colors.green.shade50,
              isDense: true,
              iconSize: 0.0,
              value: school,
              alignment: AlignmentDirectional.center,
              items: ["Standard - Shafi'i | Maliki | Ja'fari", "Hanbali"]
                  .map<DropdownMenuItem<String>>(
                (String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                },
              ).toList(),
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              underline: const SizedBox.shrink(),
              style: TextStyle(color: Colors.green.shade900, fontSize: 12),
              onChanged: (String? string) {
                setState(() {
                  school = string!;
                  if (school == "Hanbali") getdata();
                });
              },
            ),
          ],
        ),
      ],
    );
  }
}

class SolarBackground extends StatelessWidget {
  const SolarBackground({
    Key? key,
    required this.prayerTimes,
  }) : super(key: key);

  final Map<String, Data>? prayerTimes;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(5)),
        color: Colors.white,
        gradient: SweepGradient(
          colors: [
            Colors.black,
            Colors.red,
            Colors.yellow.shade50.withOpacity(0.75),
            Colors.yellow.shade50,
            Colors.yellow.shade50.withOpacity(0.75),
            Colors.red,
            Colors.black,
          ],
          stops: [
            (prayerTimes?['Sunrise']?.time ?? 0.25) - 0.01,
            (prayerTimes?['Sunrise']?.time ?? 0.25),
            (prayerTimes?['Sunrise']?.time ?? 0.25) + 0.01,
            (prayerTimes?['Luhar']?.time ?? 0.5),
            (prayerTimes?['Sunset']?.time ?? 0.75) - 0.01,
            (prayerTimes?['Sunset']?.time ?? 0.75),
            (prayerTimes?['Sunset']?.time ?? 0.75) + 0.01,
          ],
          transform: const GradientRotation(math.pi / 2),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 0,
            blurRadius: 10,
          )
        ],
      ),
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      padding: const EdgeInsets.all(8),
    );
  }
}



  // populateContainers(int index) {
  //   return ;
  // }