import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:geocoding/geocoding.dart' as geocoding;

class Homescreen extends StatefulWidget {
  const Homescreen({Key? key}) : super(key: key);

  @override
  _HomescreenState createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  String _latitude = '';
  String _longitude = '';
  String _address = '';

  Future<void> _updatePosition() async {
    LocationData locationData = await _determinePosition();
    List<geocoding.Placemark> placeMark =
        await geocoding.placemarkFromCoordinates(
            locationData.latitude ?? 0.0, locationData.longitude ?? 0.0);
    geocoding.Placemark place = placeMark[0];
    setState(() {
      _latitude = locationData.latitude.toString();
      _longitude = locationData.longitude.toString();
      _address = '${place.locality}, ${place.country}';
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Location"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Latitude : ' + _latitude),
            Text('Longitude : ' + _longitude),
            Text('Address : ' + _address),
            TextButton(
              child: const Text("Get location"),
              onPressed: () {
                _updatePosition();
              },
            ),
          ],
        ),
      ),
    );
  }
}
