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
  var Sun_Geom_Mean_Long = (280.46646 + JC * (36000.76983 + JC * 0.0003032)) % 360; // M0 °

  double Sun_Geom_Mean_Anom = 357.52911 + JC * (35999.05029 - 0.0001537 * JC); // Mean Anomaly of the Sun °

  double Eccent_Earth_Orbit = 0.016708634 - JC * (0.000042037 + 0.0000001267 * JC);

  double Sun_Eq_of_Center = (Sin(Sun_Geom_Mean_Anom) * (1.914602 - JC * (0.004817 + 0.000014 * JC)) +
      Sin(2 * Sun_Geom_Mean_Anom) * (0.019993 - 0.000101 * JC) +
      Sin(3 * Sun_Geom_Mean_Anom) * 0.000289);

  double Sun_True_Long = Sun_Geom_Mean_Long + Sun_Eq_of_Center; //°

  double Sun_Apparent_Long = Sun_True_Long - 0.00569 - 0.00478 * Sin(125.04 - 1934.136 * JC);

// ε = 23°26′21.45″ − 46.815″ T − 0.0006″ T2 + 0.00181″ T3
  double Mean_Obliquity_Ecliptic = (23 + (26 + ((21.448 - JC * (46.815 + JC * (0.00059 - JC * 0.001813)))) / 60) / 60);

  double Oblique_Correction = Mean_Obliquity_Ecliptic + 0.00256 * Cos(125.04 - 1934.136 * JC);

  double Sun_Declination = aSin(Sin(Oblique_Correction) * Sin(Sun_Apparent_Long));

  double gamma = Tan(Oblique_Correction / 2) * Tan(Oblique_Correction / 2);

  double Equation_of_Time = Degrees(
        gamma * Sin(2 * Sun_Geom_Mean_Long) -
            2 * Eccent_Earth_Orbit * Sin(Sun_Geom_Mean_Anom) +
            4 * Eccent_Earth_Orbit * gamma * Sin(Sun_Geom_Mean_Anom) * Cos(2 * Sun_Geom_Mean_Long) -
            0.5 * gamma * gamma * Sin(4 * Sun_Geom_Mean_Long) -
            1.25 * Eccent_Earth_Orbit * Eccent_Earth_Orbit * Sin(2 * Sun_Geom_Mean_Anom),
      ) *
      60 /
      15;

  return {
    'Equation of Time': Equation_of_Time,
    'Sun Declination': Sun_Declination,
  };
}
