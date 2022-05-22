// ignore_for_file: non_constant_identifier_names

import 'dart:math' as math;

double PI = math.pi;

double Average(List<double> list) {
  double total = 0;
  for (double item in list) {
    total += item;
  }

  return total / list.length;
}

double Julian(DateTime dateTime, {int hour = 0, int minute = 0, double timezone = 0}) {
  int year = dateTime.year;
  int month = dateTime.month;
  int day = dateTime.day;

  if (month <= 2) {
    year -= 1;
    month += 12;
  }

  int A = (year / 100).floor();
  int B = 2 - A + (A / 4).floor();

  return ((365.25 * (year + 4716)).floor() + (30.6001 * (month + 1)).floor() + day + (minute / 60 + hour) / 24 + B - 1524.5 - timezone / 24);
}

// 2451545 is 12:0:0.00 UT on January 1, 2000 .
double JulianCentury(double julianDay) => (julianDay - 2451545) / 36525;

double Degrees(double rad) => rad / math.pi * 180;
double Radians(double deg) => deg / 180 * math.pi;

double Sqrt(double x) => math.sqrt(x);

double Sin(double x) => math.sin(Radians(x));
double Cos(double x) => math.cos(Radians(x));
double Tan(double x) => math.tan(Radians(x));

double aSin(double x) => Degrees(math.asin(x));
double aCos(double x) => Degrees(math.acos(x));
double aTan(double x) => Degrees(math.atan(x));

double aTan2(double y, double x) => Degrees(math.atan2(y, x));

Map<String, double> getEquationOfTime(double JC) {
  double L0 = (280.46646 + JC * (36000.76983 + JC * 0.0003032)) % 360; // Mean Longitude of Sun  °
  double M0 = 357.52911 + JC * (35999.05029 - 0.0001537 * JC); // Mean Anomaly of the Sun °
  double e = 0.016708634 - JC * (0.000042037 + 0.0000001267 * JC); // Eccentricity Earth Orbits
  // Equation of Center
  double eq = (Sin(M0) * (1.914602 - JC * (0.004817 + 0.000014 * JC)) + Sin(2 * M0) * (0.019993 - 0.000101 * JC) + Sin(3 * M0) * 0.000289);
  double l = L0 + eq; // True Longitude °
  double apparentLongitude = l - 0.00569 - 0.00478 * Sin(125.04 - 1934.136 * JC);
  // ε = 23°26′21.45″ − 46.815″ T − 0.0006″ T2 + 0.00181″ T3
  double obliquity = (23 + (26 + ((21.448 - JC * (46.815 + JC * (0.00059 - JC * 0.001813)))) / 60) / 60);
  double obliqueCorrection = obliquity + 0.00256 * Cos(125.04 - 1934.136 * JC);
  double declination = aSin(Sin(obliqueCorrection) * Sin(apparentLongitude));
  double gamma = Tan(obliqueCorrection / 2) * Tan(obliqueCorrection / 2);

  double equationOfTime = Degrees(
        gamma * Sin(2 * L0) -
            2 * e * Sin(M0) +
            4 * e * gamma * Sin(M0) * Cos(2 * L0) -
            0.5 * gamma * gamma * Sin(4 * L0) -
            1.25 * e * e * Sin(2 * M0),
      ) *
      60 /
      15;

  return {
    'Equation of Time': equationOfTime,
    'Sun Declination': declination,
  };
}
