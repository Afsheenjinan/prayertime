import 'package:flutter/material.dart';
import 'screen/home_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  final _darkTheme = ThemeData(
    fontFamily: 'Ubuntu',
    brightness: Brightness.dark,
    primarySwatch: Colors.grey,
    primaryColorDark: Colors.green.shade50,
    primaryColorLight: Colors.grey.shade800,
    backgroundColor: Colors.grey.shade800,
    shadowColor: Colors.black.withOpacity(0.5),
    // scaffoldBackgroundColor: Colors.black,
    dividerTheme: const DividerThemeData(color: Colors.white, thickness: 1),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      selectedItemColor: Colors.green.shade300,
    ),
  );

  final _lightTheme = ThemeData(
    fontFamily: 'Ubuntu',
    brightness: Brightness.light,
    backgroundColor: Colors.white,
    primarySwatch: Colors.green,
    primaryColor: Colors.green,
    primaryColorDark: Colors.green.shade900,
    primaryColorLight: Colors.green.shade50,
    shadowColor: Colors.grey.withOpacity(0.5),
    dividerTheme: const DividerThemeData(color: Colors.black, thickness: 1),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      selectedItemColor: Colors.green.shade700,
    ),
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Prayer Time",
      useInheritedMediaQuery: true,
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system,
      theme: _lightTheme,
      darkTheme: _darkTheme,
      home: const Homescreen(),
    );
  }
}

// import 'package:device_preview/device_preview.dart';

// const bool kReleaseMode = bool.fromEnvironment('dart.vm.product');

// void main() => runApp(
//       DevicePreview(
//         enabled: !kReleaseMode,
//         builder: (context) => const MyApp(), // Wrap your app
//       ),
//     );

// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       useInheritedMediaQuery: true,
//       locale: DevicePreview.locale(context),
//       builder: DevicePreview.appBuilder,
//       themeMode: ThemeMode.system,
//       theme: _lightTheme,
//       darkTheme: _darkTheme,
//       home: const Homescreen(),
//     );
//   }
// }
