import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;
import '../data/data.dart';

class FirstPage extends StatelessWidget {
  const FirstPage({
    Key? key,
    required this.prayertimesdata,
    required double nowHourAngle,
    required DateTime now,
    required this.prayerList,
    required String address,
  })  : _nowHourAngle = nowHourAngle,
        _now = now,
        _address = address,
        super(key: key);

  final Map<String, Data>? prayertimesdata;
  final double _nowHourAngle;
  final DateTime _now;
  final List<String> prayerList;
  final String _address;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 10,
        ),
        Stack(
          children: [
            SolarBackground(prayertimesdata: prayertimesdata),
            Positioned(
              top: (((_nowHourAngle - 0.5).abs()) * 1.5 + 0.25) * (100 + 16) -
                  16,
              left: _nowHourAngle *
                      (MediaQuery.of(context).size.width - 40 + 16) -
                  16,
              child: Container(
                height: 16,
                width: 16,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(8)),
                  // color: _nowHourAngle > prayerTimes!['Sunset']?.time ||
                  //         _nowHourAngle < prayerTimes!['Sunrise']!.time
                  //     ? Colors.red.shade500
                  //     : Colors.yellow.shade500,
                  color: Colors.yellow,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 0,
                      blurRadius: 2,
                    )
                  ],
                ),
                margin:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                padding: const EdgeInsets.all(8),
              ),
            ),
          ],
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Row(
            children: [
              Text(DateFormat('yyyy-MM-dd').format(_now),
                  style: Theme.of(context).textTheme.headline6),
              const Flexible(
                fit: FlexFit.tight,
                child: Text(
                  '',
                ),
              ),
              Text(DateFormat('hh:mm:ss a').format(_now),
                  style: Theme.of(context).textTheme.headline6)
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
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 0,
                      blurRadius: 10,
                    )
                  ],
                ),
                margin:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                padding: const EdgeInsets.all(8),
                child: IntrinsicHeight(
                  child: Row(
                    children: [
                      Icon(
                        Icons.access_time_rounded,
                        semanticLabel: prayerList[index],
                      ),
                      const VerticalDivider(color: Colors.black),
                      Flexible(
                        fit: FlexFit.tight,
                        child: Text(
                          prayerList[index],
                        ),
                      ),
                      prayertimesdata != null
                          ? Icon(
                              prayertimesdata?[prayerList[index]]?.icon,
                              semanticLabel: prayerList[index],
                            )
                          : const Text(''),
                      const VerticalDivider(color: Colors.black),
                      Text(
                        prayertimesdata?[prayerList[index]]?.hour12 ??
                            '- - : - -  - -',
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.location_on_outlined,
              semanticLabel: 'Location',
            ),
            const SizedBox(
              width: 10,
            ),
            Text(_address, style: Theme.of(context).textTheme.subtitle1),
          ],
        ),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }
}

class SolarBackground extends StatelessWidget {
  const SolarBackground({
    Key? key,
    required this.prayertimesdata,
  }) : super(key: key);

  final Map<String, Data>? prayertimesdata;

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
            Colors.yellow.shade50.withOpacity(0.75),
            Colors.yellow.shade50,
            Colors.yellow.shade50.withOpacity(0.75),
            Colors.red,
            Colors.black,
          ],
          stops: [
            (prayertimesdata?['Sunrise']?.time ?? 0.25) - 0.01,
            (prayertimesdata?['Sunrise']?.time ?? 0.25),
            (prayertimesdata?['Sunrise']?.time ?? 0.25) + 0.01,
            (prayertimesdata?['Luhar']?.time ?? 0.5),
            (prayertimesdata?['Sunset']?.time ?? 0.75) - 0.01,
            (prayertimesdata?['Sunset']?.time ?? 0.75),
            (prayertimesdata?['Sunset']?.time ?? 0.75) + 0.01,
          ],
          transform: const GradientRotation(math.pi / 2),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
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



  // populateContainers(int index) {
  //   return ;
  // }