// ignore_for_file: non_constant_identifier_names

import 'dart:math' as math;

double julian(DateTime dateTime,
    {int hour = 0, int minute = 0, double timezone = 0}) {
  int year = dateTime.year;
  int month = dateTime.month;
  int day = dateTime.day;

  if (month <= 2) {
    year -= 1;
    month += 12;
  }

  int A = (year / 100).floor();
  int B = 2 - A + (A / 4).floor();
  return ((365.25 * (year + 4716)).floor() +
      (30.6001 * (month + 1)).floor() +
      day +
      (minute / 60 + hour) / 24 +
      B -
      1524.5 -
      timezone / 24);
}

// 2451545 is 12:0:0.00 UT on January 1, 2000 .
double julianCentury(julianDay) => (julianDay - 2451545) / 36525;

double degrees(rad) => rad / math.pi * 180;
double radians(deg) => deg / 180 * math.pi;

double sin(x) => math.sin(radians(x));
double cos(x) => math.cos(radians(x));
double tan(x) => math.tan(radians(x));

double aSin(x) => degrees(math.asin(x));
double aCos(x) => degrees(math.acos(x));
double aTan(x) => degrees(math.atan(x));

double aTan2(x, y) => degrees(math.atan2(x, y));

Map<String, double> getEquationOfTime(double JC) {
  double Geom_Mean_Long_Sun =
      (280.46646 + JC * (36000.76983 + JC * 0.0003032)) %
          360; //Geometric Mean Longitude of the Sun °
  double Geom_Mean_Anom_Sun = 357.52911 +
      JC * (35999.05029 - 0.0001537 * JC); // Mean Anomaly of the Sun °
//  Eccentricity of the Earth’s Orbit
  double Eccent_Earth_Orbit =
      0.016708634 - JC * (0.000042037 + 0.0000001267 * JC);

//    Equation of the Center
  double Sun_Eq_of_Ctr =
      (sin(Geom_Mean_Anom_Sun) * (1.914602 - JC * (0.004817 + 0.000014 * JC)) +
          sin(2 * Geom_Mean_Anom_Sun) * (0.019993 - 0.000101 * JC) +
          sin(3 * Geom_Mean_Anom_Sun) * 0.000289);

// True Longitude and True Anomaly °
  double Sun_True_Long = Geom_Mean_Long_Sun + Sun_Eq_of_Ctr;
  double Sun_True_Anom = Geom_Mean_Anom_Sun + Sun_Eq_of_Ctr;

// Calculate the Radius Vector (AUs)
  double Sun_Rad_Vector =
      (1.000001018 * (1 - Eccent_Earth_Orbit * Eccent_Earth_Orbit)) /
          (1 + Eccent_Earth_Orbit * cos(Sun_True_Anom));
// The Apparent Longitude of the Sun
  double Sun_App_Long =
      Sun_True_Long - 0.00569 - 0.00478 * sin(125.04 - 1934.136 * JC);

// Obliquity of the Ecliptic # 23.44°
// ε = 23°26′21.45″ − 46.815″ T − 0.0006″ T2 + 0.00181″ T3
// NEW ε = 23°26′21.406″ − 46.836769″ T − 0.0001831″ T2 + 0.00200340″ T3 − 0.576×10−6″ T4 − 4.34×10−8″ T5 // Sohould Try
// 23 + (26+ (21.406- JC* (46.836769+ JC* (0.0001831- JC* (0.00200340 - JC * (0.576 * (10**-6) + JC * 4.34 * (10**-8))))))/ 60)/ 60

  double Mean_Obliq_Ecliptic = (23 +
      (26 + ((21.448 - JC * (46.815 + JC * (0.00059 - JC * 0.001813)))) / 60) /
          60);

// Oblique correction
  double Obliq_Corr =
      Mean_Obliq_Ecliptic + 0.00256 * cos(125.04 - 1934.136 * JC);
  double Sun_Rt_Ascen =
      aTan2(cos(Obliq_Corr) * sin(Sun_App_Long), cos(Sun_App_Long));

// Solar declination
  double Sun_Declin = aSin(sin(Obliq_Corr) * sin(Sun_App_Long));

  double gamma = tan(Obliq_Corr / 2) * tan(Obliq_Corr / 2);

// Equation of Time (minutes)

  double Eq_of_Time = 4 *
      degrees(gamma * sin(2 * Geom_Mean_Long_Sun) -
          2 * Eccent_Earth_Orbit * sin(Geom_Mean_Anom_Sun) +
          4 *
              Eccent_Earth_Orbit *
              gamma *
              sin(Geom_Mean_Anom_Sun) *
              cos(2 * Geom_Mean_Long_Sun) -
          0.5 * gamma * gamma * sin(4 * Geom_Mean_Long_Sun) -
          1.25 *
              Eccent_Earth_Orbit *
              Eccent_Earth_Orbit *
              sin(2 * Geom_Mean_Anom_Sun));

  return {'Equation of Time': Eq_of_Time, 'Sun Declination': Sun_Declin};
}
