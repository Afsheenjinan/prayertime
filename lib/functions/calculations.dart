// ignore_for_file: non_constant_identifier_names
import 'package:flutter/material.dart';
import 'functions.dart';
import '../data/data.dart';

class Data {
  double? hourAngle; // hourangle
  late TimeOfDay timeOfDay; // timeOfDay
  late String string; // time in string
  late double time; //hourAngle + noon
  final IconData icon;
  late String hour12;
  late String hour24;

  Data({required this.icon});
}

Map<String, Data> prayerTimes = {
  "Imsak": Data(icon: Icons.nightlight_round),
  'Fajr': Data(icon: Icons.wb_twighlight),
  "Sunrise": Data(icon: Icons.wb_twilight_rounded),
  "Noon": Data(icon: Icons.sunny),
  "Luhar": Data(icon: Icons.sunny),
  "Asr": Data(icon: Icons.wb_sunny_rounded),
  "Sunset": Data(icon: Icons.wb_twilight_rounded),
  "Maghrib": Data(icon: Icons.wb_twighlight),
  "Isha": Data(icon: Icons.mode_night_rounded),
  "Midnight": Data(icon: Icons.night_shelter_rounded)
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

double? calculateHourAngle(String prayerName) {
  double hourAngle;
  int direction;
  if (prayerTimes[prayerName]?.hourAngle != null) {
    return prayerTimes[prayerName]?.hourAngle;
  } else {
    direction = ["Fajr", "Sunrise"].contains(prayerName) ? -1 : 1;
    switch (prayerName) {
      case 'Imsak':
        hourAngle =
            calculateHourAngle("Fajr")! - 10.0 / (60 * 24); // 10 mins less
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
      case 'Maghrib':
        hourAngle = (defaultMethod == "Tehran"
            ? calculateTime(-4.5)
            : defaultMethod == "Jafari"
                ? calculateTime(-4)
                : calculateHourAngle("Sunset"))!;
        break;
      case 'Isha':
        hourAngle = defaultMethod != "Makkah"
            ? calculateTime(-methods[defaultMethod]["angle"]["Isha"])
            : calculateHourAngle("Maghrib")! + 1.5 / 24;
        break;
      case 'Midnight':
        String morning =
            ["Tehran", "Jafari"].contains(defaultMethod) ? "Fajr" : "Sunrise";
        hourAngle =
            (1 + calculateHourAngle(morning)! + calculateHourAngle("Sunset")!) /
                2;
        break;
      default:
        hourAngle = direction * calculateTime(-horizontalParrallax);
        break;
    }

    prayerTimes[prayerName]?.hourAngle = hourAngle;
    return hourAngle;
  }
}

getPrayerTime(String prayerName) {
  double time = Solar_Noon + calculateHourAngle(prayerName)!;
  time = time % 1; // if time is greater than 1 day, reset time to 0

  int hh = (time * 24).floor();
  int mm = ((time * 24 * 60) % 60).floor();
  int ss = ((time * 24 * 60 * 60) % 60).floor();
  if (ss >= 30) mm = mm + 1;

  TimeOfDay timeOfDay = TimeOfDay(hour: hh, minute: mm);

  prayerTimes[prayerName]?.time = time;
  prayerTimes[prayerName]?.timeOfDay = timeOfDay;
  prayerTimes[prayerName]?.hour12 =
      '${timify(hh > 12 ? hh % 12 : hh)} : ${timify(mm)} ${timeOfDay.period.name}';
  prayerTimes[prayerName]?.hour24 = '${timify(hh)}:${timify(mm)}';
}

String timify(int value) => value.toString().padLeft(2, "0");

getdata() {
  for (var item in prayerTimes.keys) {
    getPrayerTime(item);
  }
  return prayerTimes;
}
