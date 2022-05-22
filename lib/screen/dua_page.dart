import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../data/duas.dart';

class DuaPage extends StatefulWidget {
  const DuaPage({Key? key, required this.sharedPreferences}) : super(key: key);
  final SharedPreferences? sharedPreferences;
  @override
  State<DuaPage> createState() => _DuaPageState();
}

class _DuaPageState extends State<DuaPage> {
  bool? isTransliterationChecked;
  bool? isTranslationChecked;

  @override
  void initState() {
    super.initState();
    isTransliterationChecked = widget.sharedPreferences?.getBool('isTransliterationChecked') ?? true;
    isTranslationChecked = widget.sharedPreferences?.getBool('isTranslationChecked') ?? true;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
          Row(
            children: [
              Checkbox(
                  checkColor: Theme.of(context).primaryColorLight,
                  activeColor: Theme.of(context).primaryColorDark,
                  value: isTransliterationChecked,
                  onChanged: (bool? value) {
                    setState(() {
                      isTransliterationChecked = value!;
                      widget.sharedPreferences?.setBool('isTransliterationChecked', value);
                    });
                  }),
              const Text('Transliteration'),
            ],
          ),
          Row(
            children: [
              Checkbox(
                  checkColor: Theme.of(context).primaryColorLight,
                  activeColor: Theme.of(context).primaryColorDark,
                  value: isTranslationChecked,
                  onChanged: (bool? value) {
                    setState(() {
                      isTranslationChecked = value!;
                      widget.sharedPreferences?.setBool('isTranslationChecked', value);
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
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColorLight,
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
                    isTransliterationChecked ?? false
                        ? Container(
                            padding: const EdgeInsets.symmetric(vertical: 5),
                            child: Text(duaList[index].transliteration,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                    // fontStyle: FontStyle.italic,
                                    fontFamily: 'Kalam')),
                          )
                        : const SizedBox.shrink(),
                    isTranslationChecked ?? false
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
                    const Divider()
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
