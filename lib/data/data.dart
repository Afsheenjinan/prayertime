import 'package:flutter/material.dart';

Map<String, dynamic> methods = {
  "MWL": {
    "title": "Muslim World League",
    "angle": {"Fajr": 18.0, "Isha": 17.0},
  },
  "ISNA": {
    "title": "Islamic Society of North America",
    "angle": {"Fajr": 15.0, "Isha": 15.0},
  },
  "France": {
    "title": "Union of Islamic Orgs of France",
    "angle": {"Fajr": 12.0, "Isha": 12.0},
  },
  "Egypt": {
    "title": "Egyptian General Authority of Survey",
    "angle": {"Fajr": 19.5, "Isha": 17.5},
  },
  "Makkah": {
    "title": "Umm al-Qura University, Makkah",
    "angle": {"Fajr": 18.5},
  },
  "Karachi": {
    "title": "University of Islamic Sciences, Karachi",
    "angle": {"Fajr": 18.0, "Isha": 18.0},
  },
  "Singapur": {
    "title": "Majlis Ugama Islam Singapura",
    "angle": {"Fajr": 20.0, "Isha": 18.0},
  },
  "Jafari": {
    "title": "Shia Ithna-Ashari, Leva Inst., Qum",
    "angle": {"Fajr": 16.0, "Isha": 14.0},
  },
  "Tehran": {
    "title": "Institute of Geophysics, University of Tehran",
    "angle": {"Fajr": 17.7, "Isha": 14.0},
  },
};

class Data {
  double? hourAngle; // hourangle
  DateTime? timeOfDay; // timeOfDay
  String? string; // time in string
  double? time; //hourAngle + noon
  IconData? icon;
  String? hour12;
  String? hour24;

  Data({required this.icon});
}
