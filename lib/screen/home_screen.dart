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
  final prayerNames = prayerTimes.keys.toList();
  final icondata = icons.values.toList();
  @override
  Widget build(BuildContext context) {
    // print(dt.timeZoneOffset.inHours);
    var now = const TimeOfDay(hour: 9, minute: 5);
    // print(now.period.name);

    return SafeArea(
      child: Scaffold(
        // appBar: AppBar(
        //   title: const Text("Prayer Times"),
        // ),
        body: Column(
          children: [
            Stack(
              children: [
                Container(
                  height: 100,
                  // width: 200,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(5)),
                    color: Colors.white,
                    gradient: SweepGradient(
                      // startAngle: math.pi / 2,
                      // endAngle: math.pi * 2,
                      colors: [
                        Colors.black,
                        Colors.red,
                        Colors.orange.shade50,
                        Colors.yellow.shade100,
                        Colors.orange.shade50,
                        Colors.red,
                        Colors.black,
                      ],
                      // center: Alignment.bottomCenter,
                      stops: [
                        (prayerTimes['Fajr']! + 0.5),
                        (prayerTimes['Sunrise']! + 0.5),
                        0.25,
                        (prayerTimes['Luhar']! + 0.5),
                        0.75,
                        (prayerTimes['Magrib']! + 0.5),
                        (prayerTimes['Isha']! + 0.5),
                      ],
                      transform: const GradientRotation(math.pi / 2),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 0,
                        blurRadius: 5,
                        // offset: const Offset(5, 3),
                      )
                    ],
                  ),
                  margin:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  padding: const EdgeInsets.all(8),
                ),
                const Positioned(
                  top: 16,
                  left: 200 / 2,
                  child: Sun(),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: prayerNames.length,
                itemBuilder: (BuildContext context, int index) {
                  return populateContainers(index);
                },
              ),
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
              semanticLabel: prayerNames[index],
            ),
            const VerticalDivider(color: Colors.black),
            // SizedBox(width: 20),
            Flexible(
              // flex: 1,
              fit: FlexFit.tight,
              child: Text(
                prayerNames[index],
              ),
            ),
            Icon(
              icondata[index],
              // color: Colors.pink,
              // size: 24.0,
              semanticLabel: prayerNames[index],
            ),
            const VerticalDivider(color: Colors.black),
            Text(
              // JC.toString(),
              textify(getPrayerTime(prayerNames[index])),
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
