import 'package:flutter/material.dart';
import 'package:sensors_plus/sensors_plus.dart';

class Compass extends StatefulWidget {
  const Compass({Key? key}) : super(key: key);

  @override
  State<Compass> createState() => _CompassState();
}

class _CompassState extends State<Compass> {
  @override
  void initState() {
    super.initState();
    accelerometerEvents.listen((AccelerometerEvent event) {
      debugPrint('$event');
    });
// [AccelerometerEvent (x: 0.0, y: 9.8, z: 0.0)]

    userAccelerometerEvents.listen((UserAccelerometerEvent event) {
      debugPrint('$event');
    });
// [UserAccelerometerEvent (x: 0.0, y: 0.0, z: 0.0)]

    gyroscopeEvents.listen((GyroscopeEvent event) {
      debugPrint('$event');
    });
// [GyroscopeEvent (x: 0.0, y: 0.0, z: 0.0)]

    magnetometerEvents.listen((MagnetometerEvent event) {
      debugPrint('$event');
    });
// [MagnetometerEvent (x: -23.6, y: 6.2, z: -34.9)]
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
