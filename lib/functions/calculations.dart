// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:prayertime/functions/functions.dart';
import '../data/data.dart';

// import 'dart:math' as math;
// TimeOfDay now = TimeOfDay.now();
DateTime dt = DateTime.now();
String timeFormat = '24h';

Map<String, double?> prayerTimes = {
  "Imsak": null,
  'Fajr': null,
  "Sunrise": null,
  // "Noon": null,
  "Luhar": null,
  "Asr": null,
  // "Sunset": null,
  "Magrib": null,
  "Isha": null,
  "Midnight": null
};

Map<String, IconData> icons = {
  "Imsak": Icons.nightlight_round,
  'Fajr': Icons.wb_twighlight,
  "Sunrise": Icons.wb_twilight_rounded,
  // "Noon": Icons.sunny,
  "Luhar": Icons.sunny,
  "Asr": Icons.wb_sunny_rounded,
  // "Sunset": Icons.wb_twilight_rounded,
  "Magrib": Icons.wb_twighlight,
  "Isha": Icons.mode_night_rounded,
  "Midnight": Icons.night_shelter_rounded
};

DateTime today = DateTime.now();
double timezone = today.timeZoneOffset.inMinutes / 60;
double latitude = 25.2048;
double longitide = 55.2708;
double horizontalParrallax = 34 / 60 + 16 / 60; // 0.833°
String defaultMethod = "Makkah";
String school = "Shafi"; // Shafi'i, Maliki, Ja'fari, and Hanbali

double JC = julianCentury(julian(today, hour: 12));

Map<String, double> solarData = getEquationOfTime(JC);
double Eq_of_Time = solarData['Equation of Time']!;
double Sun_Declin = solarData['Sun Declination']!;

double Solar_Noon =
    (720 - 4 * longitide - Eq_of_Time + timezone * 60) / (24 * 60);

double calculateTime(double angle) {
  return aCos(sin(angle) / (cos(latitude) * cos(Sun_Declin)) -
          tan(latitude) * tan(Sun_Declin)) *
      (4 / (24 * 60));
}

double HourAngle(String prayerName) {
  double hourAngle;
  int direction;

  if (prayerTimes[prayerName] != null) {
    return prayerTimes[prayerName]!;
  } else {
    direction = ["Fajr", "Sunrise"].contains(prayerName) ? -1 : 1;
    switch (prayerName) {
      case 'Imsak':
        hourAngle = HourAngle("Fajr") - 10.0 / (60 * 24); // 10 mins less
        break;
      case 'Fajr':
        hourAngle =
            direction * calculateTime(-methods[defaultMethod]["angle"]["Fajr"]);
        break;
      case 'Noon':
        hourAngle = 0;
        break;
      case 'Luhar':
        hourAngle = 0;
        break;
      case 'Asr':
        int shadowFacor = school != "Hambali" ? 1 : 2;
        hourAngle = direction *
            calculateTime(aTan(1 / (shadowFacor + tan(latitude - Sun_Declin))));
        break;
      case 'Magrib':
        hourAngle = defaultMethod == "Tehran"
            ? calculateTime(-4.5)
            : defaultMethod == "Jafari"
                ? calculateTime(-4)
                : HourAngle("Sunset");
        break;
      case 'Isha':
        hourAngle = defaultMethod != "Makkah"
            ? calculateTime(-methods[defaultMethod]["angle"]["Isha"])
            : HourAngle("Magrib") + 1.5 / 24;
        break;
      case 'Midnight':
        String morning =
            ["Tehran", "Jafari"].contains(defaultMethod) ? "Fajr" : "Sunrise";
        hourAngle = (1 + HourAngle(morning) + HourAngle("Sunset")) / 2;
        break;
      default:
        hourAngle = direction * calculateTime(-horizontalParrallax);
        break;
    }

    prayerTimes[prayerName] = hourAngle;
    return hourAngle;
  }
}

TimeOfDay getPrayerTime(String prayerName) {
  double time = Solar_Noon + HourAngle(prayerName);
  time = time % 1; // if time is greater than 1 day, reset time to 0

  int hh = (time * 24).floor();
  int mm = ((time * 24 * 60) % 60).floor();
  int ss = ((time * 24 * 60 * 60) % 60).floor();
  if (ss >= 30) mm = mm + 1;

  return TimeOfDay(hour: hh, minute: mm);
}

String textify(TimeOfDay datetime) {
  int hour = datetime.hour;
  hour = hour > 12 ? hour % 12 : hour;
  String hh = hour.toString().padLeft(2, "0");
  String mm = datetime.minute.toString().padLeft(2, "0");
  String format = datetime.period.name;
  var output = "$hh:$mm $format";
  return output;
}
