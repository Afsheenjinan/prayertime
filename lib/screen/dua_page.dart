import 'package:flutter/material.dart';
import '../data/duas.dart';

class DuaPage extends StatefulWidget {
  const DuaPage({Key? key}) : super(key: key);

  @override
  State<DuaPage> createState() => _DuaPageState();
}

class _DuaPageState extends State<DuaPage> {
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
                  checkColor: Colors.green.shade50,
                  activeColor: Colors.green.shade900,
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
                  checkColor: Colors.green.shade50,
                  activeColor: Colors.green.shade900,
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
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                        // color: Colors.amber.shade50,
                        color: Colors.green.shade50,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        duaList[index].arabic,
                        textDirection: TextDirection.rtl,
                        textAlign: TextAlign.justify,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'ScheherazadeNew',
                        ),
                      ),
                    ),
                    isTransliterationChecked
                        ? Container(
                            padding: const EdgeInsets.symmetric(vertical: 5),
                            child: Text(duaList[index].transliteration,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                    // fontStyle: FontStyle.italic,
                                    fontFamily: 'Kalam')),
                          )
                        : const SizedBox.shrink(),
                    isTranslationChecked
                        ? Container(
                            padding: const EdgeInsets.symmetric(vertical: 5),
                            child: Text(
                              duaList[index].translation,
                              textAlign: TextAlign.justify,
                              style: const TextStyle(fontFamily: 'Ubuntu'),
                            ),
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
                    )
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
