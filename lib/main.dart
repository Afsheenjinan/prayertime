import 'package:flutter/material.dart';

import 'screen/home_screen.dart';
// import 'screen/location_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: "Prayer Time",
      debugShowCheckedModeBanner: false,
      home: Homescreen(),
    );
  }
}
