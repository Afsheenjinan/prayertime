import 'package:flutter/material.dart';
import '../data/duas.dart';

class SecondPage extends StatefulWidget {
  const SecondPage({Key? key}) : super(key: key);

  @override
  State<SecondPage> createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  bool isTransliterationChecked = true;
  bool isTranslationChecked = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
          Row(
            children: [
              Checkbox(
                  checkColor: Colors.white,
                  activeColor: Colors.black,
                  value: isTransliterationChecked,
                  onChanged: (bool? value) {
                    setState(() {
                      isTransliterationChecked = value!;
                    });
                  }),
              const Text('Transliteration'),
            ],
          ),
          Row(
            children: [
              Checkbox(
                  checkColor: Colors.white,
                  activeColor: Colors.black,
                  value: isTranslationChecked,
                  onChanged: (bool? value) {
                    setState(() {
                      isTranslationChecked = value!;
                    });
                  }),
              const Text('Translation'),
            ],
          ),
        ]),
        const SizedBox(height: 10),
        Expanded(
          child: ListView.builder(
            itemCount: duaList.length,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                          color: Colors.amber.shade50,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(duaList[index].arabic,
                            textAlign: TextAlign.right,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'ScheherazadeNew',
                            )
                            // textDirection: TextDirection.RTL,
                            ),
                      ),
                      const SizedBox(height: 10),
                      isTransliterationChecked
                          ? Column(
                              children: [
                                Text(
                                  duaList[index].transliteration,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                      // fontStyle: FontStyle.italic,
                                      fontFamily: 'Kalam'),
                                ),
                                const SizedBox(height: 10),
                              ],
                            )
                          : const SizedBox.shrink(),
                      isTranslationChecked
                          ? Column(
                              children: [
                                Text(
                                  duaList[index].translation,
                                  textAlign: TextAlign.justify,
                                  style: const TextStyle(
                                      // fontStyle: FontStyle.italic,
                                      fontFamily: 'Ubuntu'),
                                ),
                                const SizedBox(height: 10),
                              ],
                            )
                          : const SizedBox.shrink(),
                      Text(
                        '[ ${duaList[index].verse} ]',
                        textAlign: TextAlign.right,
                        style: const TextStyle(
                          fontFamily: 'Ubuntu',
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Divider(
                        color: Colors.black,
                        // thickness: 5,
                      )
                    ]),
              );
            },
          ),
        ),
      ],
    );
  }
}
