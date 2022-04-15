class Dua {
  String verse;
  String arabic;
  String transliteration;
  String translation;

  Dua({
    required this.verse,
    required this.arabic,
    required this.transliteration,
    required this.translation,
  });
}

List duaList = [
  Dua(
      // #1
      verse: '2:127',
      arabic: 'رَبَّنَا تَقَبَّلْ مِنَّآ إِنَّكَ أَنْتَ السَّمِیعُ العَلِیمُ',
      transliteration: 'Rabbana taqabbal minnaa innaka Antas Samee’ul Aleem',
      translation:
          '“Our Lord, accept [this] from us. Indeed You are the Hearing, the Knowing.”'),
  Dua(
      // #2
      verse: '2:128',
      arabic:
          'رَبَّنَا وَاجْعَلْنَا مُسْلِمَیْنِ لَكَ وَمِن ذُرِّیَّتِنَآ أُمَّةً مُّسْلِمَةً لَّكَ وَأَرِنَا مَنَاسِكَنَا وَتُبْ عَلَیْنَآ إِنَّكَ أَنتَ التَّوَّابُ الرَّحِیمُ',
      transliteration:
          'Rabbana waj’alnaa muslimaini laka wa min zurriyyatinaaa ummatam muslimatal laka wa arinaa manaasikanaa wa tub ‘alainaa innaka antat Tawwaabur Raheem',
      translation:
          '“Our Lord, and make us Muslims [in submission] to You and from our descendants a Muslim nation [in submission] to You. And show us our rites [of worship] and accept our repentance. Indeed, You are the Accepting of Repentance, the Merciful.”'),
  Dua(
      // #3
      verse: '2:201',
      arabic:
          'رَبَّنَآ ءَاتِنَا فِى ٱلدُّنْيَا حَسَنَةً وَفِى ٱلْءَاخِرَةِ حَسَنَةً وَقِنَا عَذَابَ ٱلنَّارِ',
      transliteration:
          'Rabbana atina fid dunyaa hasanatanw wa fil aakhirati hasanatanw wa qinaa azaaban Naar',
      translation:
          '“Our Lord, give us in this world [that which is] good and in the Hereafter [that which is] good and protect us from the punishment of the Fire.”'),
  Dua(
      // #4
      verse: '2:250',
      arabic:
          'رَبَّنَآ أَفْرِغْ عَلَیْنَا صَبْراً وَثَبِّتْ أَقْدَامَنَا وَانصُرْنَا عَلَى القَوْمِ الكَافِرِینَ',
      transliteration:
          'Rabbana afrigh ‘alainaa sabranw wa sabbit aqdaamanaa wansurnaa ‘alal qawmil kaafireen',
      translation:
          '“Our Lord, pour upon us patience and plant firmly our feet and give us victory over the disbelieving people.”'),
  Dua(
      // #5
      verse: '2:286',
      arabic: 'رَبَّنَا لَا تُؤَاخِذْنَآ إِن نَّسِينَآ أَوْ أَخْطَأْنَا',
      transliteration: 'Rabbana laa tu’aakhiznaaa in naseenaaa aw akhtaanaa',
      translation:
          '“Our Lord, do not impose blame upon us if we have forgotten or erred.”'),
  Dua(
      // #6
      verse: '2:286',
      arabic:
          'رَبَّنَا وَلَا تَحْمِلْ عَلَيْنَآ إِصْرًا كَمَا حَمَلْتَهُۥ عَلَى ٱلَّذِينَ مِن قَبْلِنَا',
      transliteration:
          'Rabbana wa laa tahmil-‘alainaaa isran kamaa hamaltahoo ‘alal-lazeena min qablinaa',
      translation:
          '“Our Lord, and lay not upon us a burden like that which You laid upon those before us.”'),
  Dua(
      // #7
      verse: '2:286',
      arabic:
          'رَبَّنَا وَلَا تُحَمِّلْنَا مَا لَا طَاقَةَ لَنَا بِهِۦ ۖ وَٱعْفُ عَنَّا وَٱغْفِرْ لَنَا وَٱرْحَمْنَآ ۚ أَنتَ مَوْلَىٰنَا فَٱنصُرْنَا عَلَى ٱلْقَوْمِ ٱلْكَٰفِرِينَ',
      transliteration:
          'Rabbana wa laa tuhammilnaa maa laa taaqata lanaa bih; wa’fu ‘annaa waghfir lanaa warhamnaa; Anta mawlaanaa fansurnaa ‘alal qawmil kaafireen',
      translation:
          '“Our Lord, and burden us not with that which we have no ability to bear. And pardon us; and forgive us; and have mercy upon us. You are our protector, so give us victory over the disbelieving people.”'),
//------------------------------------------------Chapter 3
  Dua(
      // #8
      verse: '3:8',
      arabic:
          'رَبَّنَا لاَ تُزِغْ قُلُوبَنَا بَعْدَ إِذْ ھَدَیْتَنَا وَھَبْ لَنَا مِن لَّدُنكَ رَحْمَةً إِنَّكَ أَنتَ الْوَھَّابُ',
      transliteration:
          'Rabbana laa tuzigh quloobanaa ba’da iz hadaitanaa wa hab lanaa mil ladunka rahmah; innaka antal Wahhaab',
      translation:
          '“Our Lord, let not our hearts deviate after You have guided us and grant us from Yourself mercy. Indeed, You are the Bestower.”'),
  Dua(
      // #9
      verse: '3:9',
      arabic:
          'رَبَّنَآ إِنَّكَ جَامِعُ ٱلنَّاسِ لِيَوْمٍ لَّا رَيْبَ فِيهِ ۚ إِنَّ ٱللَّهَ لَا يُخْلِفُ ٱلْمِيعَادَ',
      transliteration:
          'Rabbanaaa innaka jaami ‘un-naasil Yawmil laa raibafeeh; innal laaha laa yukhliful mee’aad',
      translation:
          '“Our Lord, surely You will gather the people for a Day about which there is no doubt. Indeed, Allah does not fail in His promise.”'),
  Dua(
      // #10
      verse: '3:16',
      arabic:
          'رَبَّنَآ إِنَّنَآ ءَامَنَّا فَٱغْفِرْ لَنَا ذُنُوبَنَا وَقِنَا عَذَابَ ٱلنَّارِ',
      transliteration:
          'Rabbanaaa innanaaa aamannaa faghfir lanaa zunoobanaa wa qinaa ‘azaaban Naar',
      translation:
          '“Our Lord, indeed we have believed, so forgive us our sins and protect us from the punishment of the Fire”'),
  Dua(
      // #11
      verse: '3:53',
      arabic:
          'رَبَّنَآ ءَامَنَّا بِمَآ أَنزَلْتَ وَٱتَّبَعْنَا ٱلرَّسُولَ فَٱكْتُبْنَا مَعَ ٱلشَّٰھِدِینَ',
      transliteration:
          'Rabbanaaa aamannaa bimaaa anzalta wattaba’nar Rasoola faktubnaa ma’ash shaahideen',
      translation:
          '“Our Lord, we have believed in what You revealed and have followed the messenger [i.e., Jesus], so register us among the witnesses [to truth].”'),
  Dua(
      // #12
      verse: '3:147',
      arabic:
          'رَبَّنَا ٱغْفِرْ لَنَا ذُنُوبَنَا وَإِسْرَافَنَا فِىٓ أَمْرِنَا وَثَبِّتْ أَقْدَامَنَا وَٱنصُرْنَا عَلَى ٱلْقَوْمِ ٱلْكَٰفِرِينَ',
      transliteration:
          'Rabbanagh fir lanaa zunoobanaa wa israafanaa feee amrinaa wa sabbit aqdaamanaa wansurnaa ‘alal qawmil kaafireen',
      translation:
          '“Our Lord, forgive us our sins and the excess [committed] in our affairs and plant firmly our feet and give us victory over the disbelieving people.”'),
  Dua(
      //#13
      verse: '3:191',
      arabic:
          'رَبَّنَا مَا خَلَقْتَ هَٰذَا بَٰطِلًا سُبْحَٰنَكَ فَقِنَا عَذَابَ ٱلنَّارِ',
      transliteration:
          'Rabbanaa maa khalaqta haaza baatilan Subhaanaka faqinaa ‘azaaban Naar',
      translation:
          '“Our Lord, You did not create this aimlessly; exalted are You [above such a thing]; then protect us from the punishment of the Fire.”'),
  Dua(
      //#14
      verse: '3:192',
      arabic:
          'رَبَّنَآ إِنَّكَ مَن تُدْخِلِ ٱلنَّارَ فَقَدْ أَخْزَيْتَهُۥ ۖ وَمَا لِلظَّٰلِمِينَ مِنْ أَنصَارٍ',
      transliteration:
          'Rabbanaaa innaka man tudkhilin Naara faqad akhzai tahoo wa maa lizzaalimeena min ansaar',
      translation:
          '“Our Lord, indeed whoever You admit to the Fire – You have disgraced him, and for the wrongdoers there are no helpers.”'),
  Dua(
      //#15
      verse: '3:193',
      arabic:
          'رَّبَّنَآ إِنَّنَا سَمِعْنَا مُنَادِيًا يُنَادِى لِلْإِيمَٰنِ أَنْ ءَامِنُوا۟ بِرَبِّكُمْ فَـَٔامَنَّا',
      transliteration:
          'Rabbanaaa innanaa sami’naa munaadiyai yunaadee lil eemaani an aaminoo bi Rabbikum fa aamannaa',
      translation:
          '“Our Lord, indeed we have heard a caller, calling to faith, [saying], ‘Believe in your Lord,’ and we have believed.”'),
  Dua(
      //#16
      verse: '3:193',
      arabic:
          'رَبَّنَا فَاغْفِرْ لَنَا ذُنُوبَنَا وَكَفِّرْ عَنَّا سَیِّئَاتِنَا وَتَوَفَّنَا مَعَ الأبْرَارِ',
      transliteration:
          'Rabbanaa faghfir lanaa zunoobanaa wa kaffir ‘annaa saiyi aatina wa tawaffanaa ma’al abraar',
      translation:
          '“Our Lord, so forgive us our sins and remove from us our misdeeds and cause us to die among the righteous.”'),
  Dua(
      //#17
      verse: '3:194',
      arabic:
          'رَبَّنَا وَءَاتِنَا مَا وَعَدتَّنَا عَلَىٰ رُسُلِكَ وَلَا تُخْزِنَا يَوْمَ ٱلْقِيَٰمَةِ ۗ إِنَّكَ لَا تُخْلِفُ ٱلْمِيعَادَ',
      transliteration:
          'Rabbanaa wa aatinaa maa wa’attanaa ‘alaa Rusulika wa laa tukhzinaa Yawmal Qiyaamah; innaka laa tukhliful mee’aad',
      translation:
          '“Our Lord, and grant us what You promised us through Your messengers and do not disgrace us on the Day of Resurrection. Indeed, You do not fail in [Your] promise.”'),
  Dua(
      //#18
      verse: '5:83',
      arabic: 'رَبَّنَآ ءَامَنَّا فَٱكْتُبْنَا مَعَ ٱلشَّٰهِدِينَ',
      transliteration: 'Rabbanaaa aamannaa faktubnaa ma’ash shaahideen',
      translation:
          '“Our Lord, we have believed, so register us among the witnesses.”'),
  Dua(
      //#19
      verse: '5:114',
      arabic:
          'رَبَّنَآ أَنزِلْ عَلَيْنَا مَآئِدَةً مِّنَ ٱلسَّمَآءِ تَكُونُ لَنَا عِيدًا لِّأَوَّلِنَا وَءَاخِرِنَا وَءَايَةً مِّنكَ ۖ وَٱرْزُقْنَا وَأَنتَ خَيْرُ ٱلرَّٰزِقِينَ',
      transliteration:
          'Rabbanaaa anzil ‘alainaa maaa’idatam minas samaaa’i takoonu lanaa ‘eedal li awwalinaa wa aakhirinaa wa Aayatam minka warzuqnaa wa Anta khairur raaziqeen',
      translation:
          '“O Allah, our Lord, send down to us a table [spread with food] from the heaven to be for us a festival for the first of us and the last of us and a sign from You. And provide for us, and You are the best of providers.”'),
  Dua(
      //#20
      verse: '7:23',
      arabic:
          'رَبَّنَا ظَلَمْنَآ أَنفُسَنَا وَإِن لَّمْ تَغْفِرْ لَنَا وَتَرْحَمْنَا لَنَكُونَنَّ مِنَ ٱلْخَٰسِرِينَ',
      transliteration:
          'Rabbanaa zalamnaaa anfusanaa wa illam taghfir lanaa wa tarhamnaa lanakoonanna minal khaasireen',
      translation:
          '“Our Lord, we have wronged ourselves, and if You do not forgive us and have mercy upon us, we will surely be among the losers.”'),
  Dua(
      //#21
      verse: '7:47',
      arabic: 'رَبَّنَا لاَ تَجْعَلْنَا مَعَ الْقَوْمِ الظَّالِمِینَ',
      transliteration: 'Rabbanaa laa taj’alnaa ma’al qawmiz zaalimeen',
      translation: '“Our Lord, do not place us with the wrongdoing people.”'),
  Dua(
      //#22
      verse: '7:89',
      arabic:
          'رَبَّنَا افْتَحْ بَیْنَنَا وَبَیْنَ قَوْمِنَا بِالْحَقِّ وَأَنتَ خَیْرُ الْفَاتِحِینَ',
      transliteration:
          'Rabbanaf-tah bainana wa baina qawmina bil haqqi wa anta Khairul Fatiheen',
      translation:
          '“Our Lord, decide between us and our people in truth, and You are the best of those who give decision.”'),
  Dua(
      //#23
      verse: '7:126',
      arabic: 'رَبَّنَآ أَفْرِغْ عَلَيْنَا صَبْرًا وَتَوَفَّنَا مُسْلِمِينَ',
      transliteration:
          'Rabbanaaa afrigh ‘alainaa sabranw wa tawaffanaa muslimeen',
      translation:
          '“Our Lord, pour upon us patience and let us die as Muslims [in submission to You].”'),
  Dua(
      //#24
      verse: '10:85-86',
      arabic:
          'رَبَّنَا لاَ تَجْعَلْنَا فِتْنَةً لِّلْقَوْمِ الظَّالِمِینَ ; وَنَجِّنَا بِرَحْمَتِكَ مِنَ الْقَوْمِ الْكَافِرِینَ',
      transliteration:
          '[85]. Rabbana la taj’alna fitnatal lil-qawmidh-Dhalimeen ; [86]. wa najjina bi- Rahmatika minal qawmil kafireen',
      translation:
          '“Our Lord, make us not [objects of] trial for the wrongdoing people. And save us by Your mercy from the disbelieving people.”'),
  Dua(
      //#25
      verse: '14:38',
      arabic:
          'رَبَّنَآ إِنَّكَ تَعْلَمُ مَا نُخْفِى وَمَا نُعْلِنُ ۗ وَمَا يَخْفَىٰ عَلَى ٱللَّهِ مِن شَىْءٍۢ فِى ٱلْأَرْضِ وَلَا فِى ٱلسَّمَآءِ',
      transliteration:
          'Rabbanaaa innaka ta’lamu maa nukhfee wa maa nu’lin; wa maa yakhfaa ‘alal laahi min shai’in fil ardi wa laa fis samaaa',
      translation:
          '“Our Lord, indeed You know what we conceal and what we declare, and nothing is hidden from Allah on the earth or in the heaven.”'),
  Dua(
      //#26
      verse: '14:40',
      arabic:
          'رَبِّ اجْعَلْنِي مُقِيمَ الصَّلَاةِ وَمِنْ ذُرِّيَّتِي ۚ رَبَّنَا وَتَقَبَّلْ دُعَآءِ',
      transliteration:
          'Rabbij ‘alnee muqeemas Salaati wa min zurriyyatee Rabbanaa wa taqabbal du’aaa',
      translation:
          '“My Lord, make me an establisher of prayer, and [many] from my descendants. Our Lord, and accept my supplication.”'),
  Dua(
      //#27
      verse: '14:41',
      arabic:
          'رَبَّنَا اغْفِرْ لِي وَلِوَالِدَيَّ وَلِلْمُؤْمِنِینَ یَوْمَ یَقُومُ الْحِسَابُ',
      transliteration:
          'Rabbanagh fir lee wa liwaalidaiya wa lilmu’mineena Yawma yaqoomul hisaab',
      translation:
          '“Our Lord, forgive me and my parents and the believers the Day the account is established.”'),
  Dua(
      //#28
      verse: '18:10',
      arabic:
          'رَبَّنَآ ءَتِنَا مِنْ لَدُنْكَ رَحْمَةً وَهَيِّئْ لَنَا مِنْ أَمْرِنَا رَشَدًا',
      transliteration:
          'Rabbanaaa aatinaa mil ladunka rahmatanw wa haiyi’ lanaa min amrinaa rashadaa',
      translation:
          '“Our Lord, grant us from Yourself mercy and prepare for us from our affair right guidance.”'),
  Dua(
      //#29
      verse: '20:45',
      arabic:
          'رَبَّنَآ إِنَّنَا نَخَافُ أَن يَفْرُطَ عَلَيْنَآ أَوْ أَن يَطْغَى',
      transliteration:
          'Rabbanaaa innanaa nakhaafu ai yafruta ‘alainaaa aw ai yatghaa',
      translation:
          '“Our Lord, indeed we are afraid that he will hasten [punishment] against us or that he will transgress.”'),
  Dua(
      //#30
      verse: '23:109',
      arabic:
          'رَبَّنَآ ءَمَنَّا فَاغْفِرْ لَنَا وَارْحَمْنَا وَأَنتَ خَیْرُ الرَّاحِمِینَ',
      transliteration:
          'Rabbanaaa aamannaa faghfir lanaa warhamnaa wa Anta khairur raahimeen',
      translation:
          '“Our Lord, we have believed, so forgive us and have mercy upon us, and You are the best of the merciful.”'),
  Dua(
      //#31
      verse: '25:65-66',
      arabic:
          'رَبَّنَا اصْرِفْ عَنَّا عَذَابَ جَهَنَّمَ إِنَّ عَذَابَهَا كَانَ غَرَامًا إِنَّهَا سَآءَتْ مُسْتَقَرًّا وَمُقَامًا',
      transliteration:
          '[65]. Rabbanas rif ‘annnaa ‘azaaba Jahannama inn ‘azaabahaa kaana gharaamaa [66]. Innahaa saaa’at mustaqarranw wa muqaamaa',
      translation:
          '“Our Lord, avert from us the punishment of Hell. Indeed, its punishment is ever adhering; Indeed, it is evil as a settlement and residence.”'),
  Dua(
      //#32
      verse: '25:74',
      arabic:
          'رَبَّنَا ھَبْ لَنَا مِنْ أَزْوَاجِنَا وَذُرِّیَّاتِنَا قُرَّةَ أَعْیُنٍ وَاجْعَلْنَا لِلْمُتَّقِینَ إِمَامًا',
      transliteration:
          'Rabbanaa hab lanaa min azwaajinaa wa zurriyaatinaa qurrata a’yuninw waj ‘alnaa lilmuttaqeena Imaamaa',
      translation:
          '“Our Lord, grant us from among our wives and offspring comfort to our eyes and make us a leader [i.e., example] for the righteous.”'),
  Dua(
      //#33
      verse: '35:34',
      arabic: 'رَبَّنَا لَغَفُورٌ شَكُورٌ',
      transliteration: 'Rabbana la Ghafurun shakur',
      translation: '“Our Lord is Forgiving and Appreciative”'),
  Dua(
      //#34
      verse: '40:7',
      arabic:
          'رَبَّنَا وَسِعْتَ كُلَّ شَيْءٍ رَّحْمَةً وَعِلْمًا فَاغْفِرْ لِلَّذِینَ تَابُوا وَاتَّبَعُوا سَبِیلَكَ وَقِھِمْ عَذَابَ الْجَحِیمِ',
      transliteration:
          'Rabbanaa wasi’ta kulla shai’ir rahmatanw wa ‘ilman faghfir lillazeena taaboo wattaba’oo sabeelaka wa qihim ‘azaabal Jaheem',
      translation:
          '“Our Lord, You have encompassed all things in mercy and knowledge, so forgive those who have repented and followed Your way and protect them from the punishment of Hellfire.”'),
  Dua(
      //#35
      verse: '40:8-9',
      arabic:
          'رَبَّنَا وَأَدْخِلْھُمْ جَنَّاتِ عَدْنٍ الَّتِي وَعَدتَّھُم وَمَن صَلَحَ مِنْ آبَائِھِمْ وَأَزْوَاجِھِمْ وَذُرِّیَّاتِھِمْ إِنَّكَ أَنتَ الْعَزِیزُ الْحَكِیمُ وَقِھِمُ السَّیِّئَاتِ وَمَن تَقِ السَّیِّئَاتِ یَوْمَئِذٍ فَقَدْ رَحِمْتَھُ وَذَلِكَ ھُوَ الْفَوْزُ الْعَظِیمُ',
      transliteration:
          '[8]. Rabbana wa adhkhilhum Jannati ‘adninil-lati wa’attahum wa man salaha min aba’ihim wa azwajihim wa dhuriyyatihim innaka antal ‘Azizul-Hakim, [9]. waqihimus saiyi’at wa man taqis-saiyi’ati yawma’idhin faqad rahimatahu wa dhalika huwal fawzul-‘Adheem',
      translation:
          '“Our Lord, and admit them to gardens of perpetual residence which You have promised them and whoever was righteous among their forefathers, their spouses and their offspring. Indeed, it is You who is the Exalted in Might, the Wise. And protect them from the evil consequences [of their deeds]. And he whom You protect from evil consequences that Day – You will have given him mercy. And that is the great attainment.”'),
  Dua(
      //#36
      verse: '59:10',
      arabic:
          'رَبَّنَا اغْفِرْ لَنَا وَلِإِخْوَانِنَا الَّذِينَ سَبَقُونَا بِالْإِيمَانِ وَلَا تَجْعَلْ فِي قُلُوبِنَا غِلًّا لِّلَّذِينَ اٰمَنُوا',
      transliteration:
          'Rabbanagh fir lanaa wa li ikhwaani nal lazeena sabqoonaa bil eemaani wa laa taj’al fee quloobinaa ghillalil lazeena aamanoo',
      translation:
          '“Our Lord, forgive us and our brothers who preceded us in faith and put not in our hearts [any] resentment toward those who have believed.”'),
  Dua(
      //#37
      verse: '59:10',
      arabic: 'رَبَّنَآ إِنَّكَ رَؤُوفٌ رَّحِیمٌ',
      transliteration: 'Rabbannaaa innaka Ra’oofur Raheem',
      translation: '“Our Lord, indeed You are Kind and Merciful.”'),
  Dua(
      //#38
      verse: '60:4',
      arabic:
          'رَّبَّنَا عَلَیْكَ تَوَكَّلْنَا وَإِلَیْكَ أَنَبْنَا وَإِلَیْكَ الْمَصِیرُ',
      transliteration:
          'Rabbanaa ‘alaika tawakkalnaa wa ilaika anabnaa wa ilaikal maseer',
      translation:
          '“Our Lord, upon You we have relied, and to You we have returned, and to You is the destination.”'),
  Dua(
      //#39
      verse: '60:5',
      arabic:
          'رَبَّنَا لَا تَجْعَلْنَا فِتْنَةً لِّلَّذِینَ كَفَرُوا وَاغْفِرْ لَنَا رَبَّنَآ إِنَّكَ أَنتَ الْعَزِیزُ الْحَكِیمُ',
      transliteration:
          'Rabbana laa taj’alnaa fitnatal lillazeena kafaroo waghfir lanaa rabbanaaa innaka antal azeezul hakeem',
      translation:
          '“Our Lord, make us not [objects of] torment for the disbelievers and forgive us, our Lord. Indeed, it is You who is the Exalted in Might, the Wise.”'),
  Dua(
      //#40
      verse: '66:8',
      arabic:
          'رَبَّنَآ أَتْمِمْ لَنَا نُورَنَا وَاغْفِرْ لَنَآ ۖ إِنَّكَ عَلَى كُلِّ شَيْءٍ قَدِیرٌ',
      transliteration:
          'Rabbanaaa atmim lanaa nooranaa waghfir lana innaka ‘alaa kulli shai’in qadeer',
      translation:
          '“Our Lord, perfect for us our light and forgive us. Indeed, You are over all things competent.”'),
];
