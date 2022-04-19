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
  double? qiblaAngleToNorth;
  double? qiblaAngleToPhone;

  late StreamSubscription<MagnetometerEvent> magnetometer;

  @override
  void initState() {
    super.initState();

    distanceInMeters = Geolocator.distanceBetween(
        widget.latitude!, widget.longitude!, _latitudeMakka, _longitudeMakka);

    bearingInAngle = Geolocator.bearingBetween(widget.latitude!,
            widget.longitude!, _latitudeMakka, _longitudeMakka) %
        360;

    magnetometer = magnetometerEvents.listen((MagnetometerEvent event) {
      setState(() {
        double x = event.x;
        double y = event.y;
        double z = event.z;

        double radius = Sqrt(x * x + y * y + z * z);

        northAngle = aCos(y / radius);
        qiblaAngleToNorth = northAngle! + bearingInAngle!;
        qiblaAngleToPhone = (360 - qiblaAngleToNorth!).abs();
      });
    });
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
            Colors.green.shade100,
            Colors.green.shade50,
          ],
          stops: const [0.5, 0.5],
          transform: GradientRotation(Radians(qiblaAngleToNorth! - 90)),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('assets/images/qibla64.png'),
          const SizedBox(height: 20),
          Text(
            ' ${qiblaAngleToPhone?.toStringAsFixed(0)}°',
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
                color: qiblaAngleToPhone! < 1
                    ? Colors.green.shade700
                    : Colors.black),
          ),
          const SizedBox(height: 20),
          Icon(
            Icons.download_rounded,
            color:
                qiblaAngleToPhone! < 1 ? Colors.green.shade700 : Colors.black,
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            height: 256,
            width: 256,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(200)),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 0,
                  blurRadius: 20,
                )
              ],
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Transform.rotate(
                    angle: Radians(northAngle),
                    child: Image.asset(
                      'assets/images/compass.png',
                    )),
                Transform.rotate(
                    angle: Radians(qiblaAngleToNorth),
                    child: Image.asset('assets/images/qibla.png')),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.all(20),
            padding: const EdgeInsets.all(20),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              color: Colors.white,
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
                          ' ${(bearingInAngle!).toStringAsFixed(0)}°N',
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
