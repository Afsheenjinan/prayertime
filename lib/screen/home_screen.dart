import 'dart:async';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import '../functions/calculations.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:math' as math;

class Homescreen extends StatefulWidget {
  const Homescreen({
    Key? key,
  }) : super(key: key);

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  List<String> prayerList = [
    'Imsak',
    'Fajr',
    'Sunrise',
    'Luhar',
    'Asr',
    'Maghrib',
    'Isha'
  ];
  late Map<String, Data?> prayertimesdata;
  late double _width;
  late Timer _timer;
  late double _nowHourAngle;
  late DateTime _now;
  double _latitude = 25.2048;
  double _longitide = 55.2708;
  Position? _location;

  @override
  void initState() {
    super.initState();
    prayertimesdata = getdata();
    _now = DateTime.now();

    Geolocator.getCurrentPosition()
        .then((Position position) => _location = position);
    _nowHourAngle = (_now.hour + _now.minute / 60) / 24;
    _timer =
        Timer.periodic(const Duration(seconds: 1), (Timer timer) => _getTime());
  }

  @override
  void dispose() {
    super.dispose();
    _timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    // print(_determinePosition());

    _width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            Stack(
              children: [
                Container(
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
                        (prayertimesdata['Sunrise']!.time) - 0.01,
                        (prayertimesdata['Sunrise']!.time),
                        (prayertimesdata['Sunrise']!.time) + 0.01,
                        (prayertimesdata['Luhar']!.time),
                        (prayertimesdata['Sunset']!.time) - 0.01,
                        (prayertimesdata['Sunset']!.time),
                        (prayertimesdata['Sunset']!.time) + 0.01,
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
                  margin:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  padding: const EdgeInsets.all(8),
                ),
                Positioned(
                  top: (((_nowHourAngle - 0.5).abs()) * 1.5 + 0.25) *
                          (100 + 16) -
                      16,
                  left: _nowHourAngle * (_width - 40 + 16) - 16,
                  child: Sun(nowHourAngle: _nowHourAngle),
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
                itemCount: prayerList.length,
                itemBuilder: (BuildContext context, int index) {
                  return populateContainers(index);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  populateContainers(int index) {
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
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
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
            Icon(
              prayertimesdata[prayerList[index]]?.icon,
              semanticLabel: prayerList[index],
            ),
            const VerticalDivider(color: Colors.black),
            Text(
              prayertimesdata[prayerList[index]]!.hour12,
            ),
          ],
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
}

class Sun extends StatelessWidget {
  const Sun({
    Key? key,
    required double nowHourAngle,
  })  : _nowHourAngle = nowHourAngle,
        super(key: key);

  final double _nowHourAngle;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 16,
      width: 16,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(8)),
        color: _nowHourAngle > prayerTimes['Sunset']!.time ||
                _nowHourAngle < prayerTimes['Sunrise']!.time
            ? Colors.red.shade500
            : Colors.yellow.shade500,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 0,
            blurRadius: 2,
          )
        ],
      ),
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      padding: const EdgeInsets.all(8),
    );
  }
}

// Future<Position> _determinePosition() async {
//   bool serviceEnabled;
//   LocationPermission permission;

//   // Test if location services are enabled.
//   serviceEnabled = await Geolocator.isLocationServiceEnabled();
//   if (!serviceEnabled) {
//     return Future.error('Location services are disabled.');
//   }

//   permission = await Geolocator.checkPermission();
//   if (permission == LocationPermission.denied) {
//     permission = await Geolocator.requestPermission();
//     if (permission == LocationPermission.denied) {
//       return Future.error('Location permissions are denied');
//     }
//   }

//   if (permission == LocationPermission.deniedForever) {
//     return Future.error(
//         'Location permissions are permanently denied, we cannot request permissions.');
//   }
//   return await Geolocator.getCurrentPosition();
// }
