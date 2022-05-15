import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:prayertime/functions/functions.dart';
import 'package:sensors_plus/sensors_plus.dart';

class QiblaPage extends StatefulWidget {
  const QiblaPage({
    Key? key,
    required this.latitude,
    required this.longitude,
  }) : super(key: key);
  final double? latitude;
  final double? longitude;

  @override
  State<QiblaPage> createState() => _QiblaPageState();
}

class _QiblaPageState extends State<QiblaPage> {
  final double _latitudeMakka = 21.4225;
  final double _longitudeMakka = 39.8262;

  double? distanceInMeters;
  double? bearingInAngle;

  double? northAngle;
  double? qiblaAngleToTop;
  double? qiblaAngleDispay;
  List<double> datalist = [0, 0, 0, 0, 0];
  double xx = 0, yy = 0, zz = 0;

  late StreamSubscription<MagnetometerEvent> magnetometer;

  @override
  void initState() {
    super.initState();

    distanceInMeters = Geolocator.distanceBetween(
        widget.latitude!, widget.longitude!, _latitudeMakka, _longitudeMakka);

    bearingInAngle = Geolocator.bearingBetween(
        widget.latitude!, widget.longitude!, _latitudeMakka, _longitudeMakka);

    magnetometer = magnetometerEvents.listen((MagnetometerEvent event) {
      setState(() {
        double x = event.x;
        double y = event.y;
        double z = event.z;
        double radius = Sqrt(x * x + y * y + z * z);
        xx = x / radius;
        yy = y / radius;
        zz = z / radius;

        datalist.insert(0, aTan2(x, y));
        datalist.removeLast();
        double average = Average(datalist);

        northAngle = average;
        qiblaAngleToTop = (northAngle! + bearingInAngle!) % 360;
        qiblaAngleDispay = 180 - (qiblaAngleToTop! - 180).abs();
      });
    }, cancelOnError: true);
  }

  @override
  void dispose() {
    super.dispose();
    magnetometer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    if (northAngle == null) return Container();
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            MediaQuery.of(context).platformBrightness == Brightness.dark
                ? Colors.grey.shade900
                : Colors.green.shade100,
            MediaQuery.of(context).platformBrightness == Brightness.dark
                ? Colors.grey.shade800
                : Colors.green.shade50,
          ],
          stops: const [0.5, 0.5],
          transform: GradientRotation(Radians(qiblaAngleToTop! - 90)),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          MediaQuery.of(context).platformBrightness == Brightness.dark
              ? Image.asset('assets/images/qibla_dark48.png')
              : Image.asset('assets/images/qibla48.png'),
          const SizedBox(height: 20),
          Text(
            ' ${(qiblaAngleDispay!).toStringAsFixed(0)}°',
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
                color: qiblaAngleDispay! < 1 ? Colors.green.shade500 : null),
          ),
          const SizedBox(height: 20),
          Icon(
            Icons.download_rounded,
            color: qiblaAngleDispay! < 1 ? Colors.green.shade500 : null,
          ),
          const SizedBox(height: 10),
          Container(
            // padding: const EdgeInsets.symmetric(horizontal: 5),
            height: 256,
            width: 256,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(200)),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 0,
                  blurRadius: 10,
                )
              ],
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Transform.rotate(
                  angle: Radians(northAngle),
                  child: MediaQuery.of(context).platformBrightness ==
                          Brightness.dark
                      ? Image.asset('assets/images/compass_dark.png')
                      : Image.asset('assets/images/compass.png'),
                ),
                Transform.rotate(
                  angle: Radians(qiblaAngleToTop),
                  child: Image.asset('assets/images/qibla_direction.png'),
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.all(20),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              color: Theme.of(context).backgroundColor,
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Flexible(
                        fit: FlexFit.tight,
                        child: Text(
                          'Distance :',
                          textAlign: TextAlign.end,
                          style: Theme.of(context).textTheme.headline6,
                        )),
                    Flexible(
                        fit: FlexFit.tight,
                        child: Text(
                          ' ${(distanceInMeters! / 1000).toStringAsFixed(0)} km',
                          style: Theme.of(context).textTheme.headline6,
                        )),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Flexible(
                        fit: FlexFit.tight,
                        child: Text(
                          'Angle :',
                          textAlign: TextAlign.end,
                          style: Theme.of(context).textTheme.headline6,
                        )),
                    Flexible(
                        fit: FlexFit.tight,
                        child: Text(
                          ' ${(bearingInAngle! % 360).toStringAsFixed(0)}°N',
                          style: Theme.of(context).textTheme.headline6,
                        )),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
