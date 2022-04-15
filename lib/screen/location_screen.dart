// import 'package:flutter/material.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:geocoding/geocoding.dart';

// class Homescreen extends StatefulWidget {
//   const Homescreen({Key? key}) : super(key: key);

//   @override
//   _HomescreenState createState() => _HomescreenState();
// }

// class _HomescreenState extends State<Homescreen> {
//   var _currentPosition;
//   String _latitude = '';
//   String _longitude = '';
//   String _address = '';

//   Future<void> _updatePosition() async {
//     Position pos = await _determinePosition();
//     var lastpos = await Geolocator.getLastKnownPosition();
//     print(pos);
//     print(lastpos);
//     List pm = await placemarkFromCoordinates(pos.latitude, pos.longitude);
//     print(pm.length);

//     setState(() {
//       _latitude = lastpos!.latitude.toString();
//       _longitude = lastpos.longitude.toString();
//       _address = pm[0].toString();
//     });
//   }

//   Future<Position> _determinePosition() async {
//     bool serviceEnabled;
//     LocationPermission permission;

//     // Test if location services are enabled.
//     serviceEnabled = await Geolocator.isLocationServiceEnabled();
//     if (!serviceEnabled) {
//       return Future.error('Location services are disabled.');
//     }

//     permission = await Geolocator.checkPermission();
//     if (permission == LocationPermission.denied) {
//       permission = await Geolocator.requestPermission();
//       if (permission == LocationPermission.denied) {
//         return Future.error('Location permissions are denied');
//       }
//     }

//     if (permission == LocationPermission.deniedForever) {
//       return Future.error(
//           'Location permissions are permanently denied, we cannot request permissions.');
//     }
//     return await Geolocator.getCurrentPosition();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Location"),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             Text('Latitude : ' + _latitude),
//             Text('Longitude : ' + _longitude),
//             Text('Address : ' + _address),
//             TextButton(
//               child: const Text("Get location"),
//               onPressed: () {
//                 _updatePosition();
//                 print(_latitude);
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   // _getCurrentLocation() {
//   //   Geolocator.getCurrentPosition(
//   //           desiredAccuracy: LocationAccuracy.best,
//   //           forceAndroidLocationManager: true)
//   //       .then((Position position) {
//   //     setState(() {
//   //       _currentPosition = position;
//   //     });
//   //   }).catchError((e) {
//   //     print(e);
//   //   });
//   // }
// }
