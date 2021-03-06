import 'dart:async';
import '../data/data.dart';
import 'package:intl/intl.dart';
import '../functions/functions.dart';
import 'package:flutter/material.dart';
import 'package:prayertime/screen/home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PrayerTimesPage extends StatefulWidget {
  const PrayerTimesPage({Key? key, required this.sharedPreferences, required this.locationData}) : super(key: key);
  final LocationData locationData;
  final SharedPreferences? sharedPreferences;

  @override
  State<PrayerTimesPage> createState() => _PrayerTimesPageState();
}

class _PrayerTimesPageState extends State<PrayerTimesPage> {
  double _latitude = 0;
  double _longitude = 0;
  String _address = '';

  Timer? _timer;
  DateTime _now = DateTime.now();
  double? _nowHourAngle;
  double horizontalParrallax = 34 / 60 + 16 / 60; // 0.833°

  double? _sunDeclination;

  double? _solarNoon;
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
  List<String> prayerList = ['Imsak', 'Fajr', 'Sunrise', 'Luhar', 'Asr', 'Maghrib', 'Isha', 'Midnight'];

  Map<String, Data>? prayertimesdata;

  String? defaultMethod;
  String? asrMethod;

  // final isButtonSelected = <bool>[false, true, false];

  @override
  void initState() {
    super.initState();
    _latitude = widget.locationData.position.latitude;
    _longitude = widget.locationData.position.longitude;
    _address = '${widget.locationData.placemark.locality}, ${widget.locationData.placemark.country}';
    _nowHourAngle = (_now.hour + _now.minute / 60) / 24;

    double _timeZone = _now.timeZoneOffset.inMinutes / 60;
    Map<String, double> _solarData = getEquationOfTime(JulianCentury(Julian(_now.toUtc())));
    double? _equationOfTime = _solarData['Equation of Time'];
    _sunDeclination = _solarData['Sun Declination'];

    _timer = Timer.periodic(const Duration(seconds: 1), (Timer timer) => _getTime());

    setState(() {
      defaultMethod = widget.sharedPreferences?.getString('defaultMethod') ?? 'MWL';
      asrMethod = widget.sharedPreferences?.getString('asrMethod') ?? 'Standard';
      _solarNoon = (720 - 4 * _longitude - _equationOfTime! + _timeZone * 60) / (24 * 60);
      getdata();
    });
  }

  @override
  void dispose() {
    super.dispose();
    _timer?.cancel();
  }

  void _getTime() {
    setState(() {
      _now = DateTime.now();
      _nowHourAngle = (_now.hour + _now.minute / 60) / 24;
    });
  }

  double calculateTime(double angle) {
    return aCos(Sin(angle) / (Cos(_latitude) * Cos(_sunDeclination!)) - Tan(_latitude) * Tan(_sunDeclination!)) * (4 / (24 * 60));
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
          hourAngle = calculateHourAngle("Fajr")! - 10.0 / (60 * 24); // 10 mins less
          break;
        case 'Fajr':
          hourAngle = direction * calculateTime(-methods[defaultMethod]["angle"]["Fajr"]);
          break;
        case 'Noon':
          hourAngle = 0;
          break;
        case 'Luhar':
          hourAngle = 0;
          break;
        case 'Asr':
          int shadowFacor = asrMethod != "Hanafi" ? 1 : 2;
          double deltaAngle = (_latitude - _sunDeclination!).abs();
          hourAngle = direction * calculateTime(aTan(1 / (shadowFacor + Tan(deltaAngle))));
          break;
        case 'Maghrib':
          hourAngle = (defaultMethod == "Tehran"
              ? calculateTime(-4.5)
              : defaultMethod == "Jafari"
                  ? calculateTime(-4)
                  : calculateHourAngle("Sunset"))!;
          break;
        case 'Isha':
          hourAngle = defaultMethod != "Makkah" ? calculateTime(-methods[defaultMethod]["angle"]["Isha"]) : calculateHourAngle("Maghrib")! + 1.5 / 24;
          break;
        case 'Midnight':
          String morning = ["Tehran", "Jafari"].contains(defaultMethod) ? "Fajr" : "Sunrise";
          hourAngle = (1 + calculateHourAngle(morning)! + calculateHourAngle("Sunset")!) / 2;
          break;
        default:
          hourAngle = direction * calculateTime(-horizontalParrallax);
          break;
      }
      // prayerTimes[prayerName]?.hourAngle = hourAngle;
      return hourAngle;
    }
  }

  getPrayerTime(String prayerName) {
    double time = _solarNoon! + calculateHourAngle(prayerName)!;
    time = time % 1; // if time is greater than 1 day, reset time to 0

    int hh = (time * 24).floor();
    int mm = ((time * 24 * 60) % 60).floor();
    int ss = ((time * 24 * 60 * 60) % 60).floor();
    // if (ss >= 30) mm = mm + 1;

    DateTime dateTime = DateTime(_now.year, _now.month, _now.day, hh, mm, ss);

    prayerTimes[prayerName]?.time = time;
    prayerTimes[prayerName]?.timeOfDay = dateTime;
    prayerTimes[prayerName]?.hour12 = DateFormat('hh:mm a').format(dateTime);
    prayerTimes[prayerName]?.hour24 = DateFormat('HH:mm').format(dateTime);
  }

  getdata() {
    for (var item in prayerTimes.keys) {
      getPrayerTime(item);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.location_on_outlined,
              size: 15,
              semanticLabel: 'Location',
              color: Colors.green,
            ),
            const SizedBox(
              width: 10,
            ),
            Text(_address),
          ],
        ),
        Stack(
          alignment: Alignment.center,
          children: [
            SolarBackground(prayerTimes: prayerTimes),
            Sun(nowHourAngle: _nowHourAngle, prayerTimes: prayerTimes),
          ],
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Row(
            children: [
              Column(
                children: [
                  Text(DateFormat('yyyy-MM-dd').format(_now), style: Theme.of(context).textTheme.headline6),
                  Text(DateFormat('EEEE').format(_now)),
                ],
              ),
              const Flexible(
                fit: FlexFit.tight,
                child: Text(
                  '',
                ),
              ),
              Text(DateFormat('hh:mm:ss a').format(_now), style: Theme.of(context).textTheme.headline6)
            ],
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Expanded(
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: prayerList.length,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(5)),
                  color: Theme.of(context).backgroundColor,
                  boxShadow: [
                    BoxShadow(
                      color: Theme.of(context).shadowColor,
                      spreadRadius: 0,
                      blurRadius: 10,
                    )
                  ],
                ),
                margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                padding: const EdgeInsets.all(8),
                child: IntrinsicHeight(
                  child: Row(
                    children: [
                      Icon(
                        prayerTimes[prayerList[index]]?.icon,
                        semanticLabel: prayerList[index],
                      ),
                      const VerticalDivider(),
                      Flexible(
                        fit: FlexFit.tight,
                        child: Text(
                          prayerList[index],
                        ),
                      ),
                      const VerticalDivider(),
                      Text(
                        prayerTimes[prayerList[index]]?.hour12 ?? '- - : - -  - -',
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Based on',
                    textAlign: TextAlign.end,
                  ),
                  DropdownButton<String>(
                    dropdownColor: Theme.of(context).primaryColorLight,
                    // isDense: true,
                    // iconSize: 15,
                    value: defaultMethod,
                    alignment: AlignmentDirectional.centerEnd,
                    items: methods.keys.map<DropdownMenuItem<String>>(
                      (String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(methods[value]['title'].toString()),
                        );
                      },
                    ).toList(),
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    underline: const SizedBox.shrink(),
                    style: TextStyle(color: Theme.of(context).primaryColorDark, fontSize: 12),
                    onChanged: (String? string) async {
                      widget.sharedPreferences?.setString('defaultMethod', string!);
                      setState(() {
                        String? olddefaultMethod = defaultMethod;
                        defaultMethod = string;

                        if (defaultMethod != olddefaultMethod) getdata();
                      });
                    },
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Asr method',
                    textAlign: TextAlign.end,
                  ),
                  DropdownButton<String>(
                    dropdownColor: Theme.of(context).primaryColorLight,
                    isDense: false,
                    // iconSize: 0.0,
                    value: asrMethod,
                    alignment: AlignmentDirectional.centerEnd,
                    items: ["Standard", "Hanafi"].map<DropdownMenuItem<String>>(
                      (String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      },
                    ).toList(),
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    underline: const SizedBox.shrink(),
                    style: TextStyle(color: Theme.of(context).primaryColorDark, fontSize: 12),
                    onChanged: (String? string) async {
                      widget.sharedPreferences?.setString('asrMethod', string!);
                      setState(() {
                        String? oldAsrMethod = asrMethod;
                        asrMethod = string;
                        if (asrMethod != oldAsrMethod) getdata();
                      });
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

///------------------------------------------------------------------------- [Sun]

class Sun extends StatelessWidget {
  const Sun({
    Key? key,
    required double? nowHourAngle,
    required this.prayerTimes,
  })  : _nowHourAngle = nowHourAngle,
        super(key: key);

  final double? _nowHourAngle;
  final Map<String, Data> prayerTimes;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: (100 - 16) / 2 * (1 + Cos(_nowHourAngle! * 360)),
      left: (MediaQuery.of(context).size.width - 40 - 16) / 2 * (1 + Sin(-_nowHourAngle! * 360)),
      child: Container(
        height: 16,
        width: 16,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(8)),
          color: (_nowHourAngle! > (prayerTimes['Sunrise']?.time ?? 0.25)) & (_nowHourAngle! < (prayerTimes['Sunset']?.time ?? 0.75))
              ? Colors.yellow.shade500
              : Colors.orange,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 0,
              blurRadius: 2,
            )
          ],
        ),
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        padding: const EdgeInsets.all(8),
      ),
    );
  }
}

///------------------------------------------------------------------------- [SolarBackground]

class SolarBackground extends StatelessWidget {
  const SolarBackground({
    Key? key,
    required this.prayerTimes,
  }) : super(key: key);

  final Map<String, Data>? prayerTimes;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(5)),
        color: Colors.white,
        gradient: SweepGradient(
          colors: [
            Colors.black,
            Colors.red,
            Colors.yellow.shade50.withOpacity(0.8),
            Colors.yellow.shade50,
            Colors.yellow.shade50.withOpacity(0.8),
            Colors.red,
            Colors.black,
          ],
          stops: [
            (prayerTimes?['Sunrise']?.time ?? 0.25),
            (prayerTimes?['Sunrise']?.time ?? 0.25) + 3 / 360,
            (prayerTimes?['Sunrise']?.time ?? 0.25) + 6 / 360,
            (prayerTimes?['Luhar']?.time ?? 0.5),
            (prayerTimes?['Sunset']?.time ?? 0.75) - 6 / 360,
            (prayerTimes?['Sunset']?.time ?? 0.75) - 3 / 360,
            (prayerTimes?['Sunset']?.time ?? 0.75),
          ],
          transform: GradientRotation(PI / 2),
        ),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).shadowColor,
            spreadRadius: 0,
            blurRadius: 10,
          )
        ],
      ),
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      padding: const EdgeInsets.all(8),
    );
  }
}
