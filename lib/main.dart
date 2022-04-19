import 'package:flutter/material.dart';
import 'screen/home_screen.dart';
import 'package:device_preview/device_preview.dart';
// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return const MaterialApp(
//       title: "Prayer Time",
//       debugShowCheckedModeBanner: false,
//       home: Homescreen(),
//     );
//   }
// }

const bool kReleaseMode = bool.fromEnvironment('dart.vm.product');

void main() => runApp(
      DevicePreview(
        enabled: !kReleaseMode,
        builder: (context) => const MyApp(), // Wrap your app
      ),
    );

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      useInheritedMediaQuery: true,
      locale: DevicePreview.locale(context),
      builder: DevicePreview.appBuilder,
      theme: ThemeData(
        fontFamily: 'Ubuntu',
        primaryColor: Colors.green.shade900,
        // textTheme: const TextTheme(
        //   bodyText2: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
        // ),
      ),
      darkTheme: ThemeData.dark(),
      home: const Homescreen(),
    );
  }
}
