import 'package:flutter/material.dart';
import '../functions/calculations.dart';
import 'dart:math' as math;

class Homescreen extends StatefulWidget {
  const Homescreen({
    Key? key,
  }) : super(key: key);

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  DateTime today = DateTime.now();
  Map<String, Data?> prayertimesdata = getdata();
  List<String> prayerList = [
    'Imsak',
    'Fajr',
    'Luhar',
    'Asr',
    'Maghrib',
    'Isha'
  ];

  @override
  Widget build(BuildContext context) {
    // print(prayertimesdata['Fajr']?.hourAngle);
    // print(prayertimesdata['Imsak']?.time);
    // print(prayertimesdata['Maghrib']?.hourAngle);
    // print(prayertimesdata['Fajr']?.timeOfDay);
    // print(prayertimesdata['Maghrib']?.hour12);
    // print(prayertimesdata['Maghrib']?.hour24);
    // print(prayertimesdata['Fajr']?.icon);
    // print(prayertimesdata['Fajr']?.icon);

    return SafeArea(
      child: Scaffold(
        // appBar: AppBar(
        //   title: const Text("Prayer Times"),
        // ),
        body: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: prayerList.length,
                itemBuilder: (BuildContext context, int index) {
                  return populateContainers(index);
                },
              ),
            ),
            // Stack(
            //   children: [
            //     Container(
            //       height: 100,
            //       // width: 200,
            //       decoration: BoxDecoration(
            //         borderRadius: const BorderRadius.all(Radius.circular(5)),
            //         color: Colors.white,
            //         gradient: SweepGradient(
            //           // startAngle: math.pi / 2,
            //           // endAngle: math.pi * 2,
            //           colors: [
            //             Colors.black,
            //             Colors.red,
            //             Colors.yellow.shade50,
            //             Colors.yellow.shade50,
            //             Colors.yellow.shade50,
            //             Colors.red,
            //             Colors.black,
            //           ],
            //           // center: Alignment.bottomCenter,
            //           stops: [
            //             (prayerTimes['Fajr']! + 0.5),
            //             (prayerTimes['Sunrise']! + 0.5),
            //             0.25,
            //             (prayerTimes['Luhar']! + 0.5),
            //             0.75,
            //             (prayerTimes['Maghrib']! + 0.5),
            //             (prayerTimes['Isha']! + 0.5),
            //           ],
            //           transform: const GradientRotation(math.pi / 2),
            //         ),
            //         boxShadow: [
            //           BoxShadow(
            //             color: Colors.grey.withOpacity(0.5),
            //             spreadRadius: 0,
            //             blurRadius: 5,
            //             // offset: const Offset(5, 3),
            //           )
            //         ],
            //       ),
            //       margin:
            //           const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            //       padding: const EdgeInsets.all(8),
            //     ),
            //     const Positioned(
            //       top: 16,
            //       left: 200 / 2,
            //       child: Sun(),
            //     ),
            //   ],
            // ),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }

  populateContainers(int index) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(5)),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 0,
            blurRadius: 5,
            // offset: const Offset(5, 3),
          )
        ],
      ),
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      padding: const EdgeInsets.all(8),
      child: IntrinsicHeight(
        child: Row(
          children: [
            Icon(
              Icons.access_time_rounded,
              // color: Colors.pink,
              // size: 24.0,
              semanticLabel: prayerList[index],
            ),
            const VerticalDivider(color: Colors.black),
            // SizedBox(width: 20),
            Flexible(
              // flex: 1,
              fit: FlexFit.tight,
              child: Text(
                prayerList[index],
              ),
            ),
            Icon(
              prayertimesdata[prayerList[index]]?.icon, // icondata[index],
              semanticLabel: prayerList[index],
            ),
            const VerticalDivider(color: Colors.black),
            Text(
              // JC.toString(),
              prayertimesdata[prayerList[index]]!.hour12,
              // textify(getPrayerTime(prayerNames[index])),
            ),
          ],
        ),
      ),
    );
  }
}

class Sun extends StatelessWidget {
  const Sun({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 16,
      width: 16,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(8)),
        color: Colors.yellow.shade500,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 0,
            blurRadius: 1,
            // offset: const Offset(5, 3),
          )
        ],
      ),
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      padding: const EdgeInsets.all(8),
    );
  }
}
