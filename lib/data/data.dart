/*
Calculation Method	                            |  Fajr Angle	|   ʿIshā’ Angle   |    Region
------------------------------------------------|---------------|------------------|--------------
Muslim World League                     [MWL]   |     18°       |       17°        |    Europe, Far East, parts of US
Islamic Society of North America        [ISNA]	|     15°	    |       15°        |    North America (US and Canada)
Union of Islamic Orgs of France         [France]	|     12°	    |       12°        |    France
Egyptian General Authority of Survey	[Egypt]  |     19.5°	    |       17.5°      |    Africa, Syria, Lebanon, Malaysia   
Umm al-Qura University, Makkah          [Makkah]|     18.5°	    |       90 min     |    Arabian Peninsula
University of Islamic Sciences, Karachi [Karachi]   |     18°	    |       18°        |    Pakistan, Afganistan, Bangladesh, India
Majlis Ugama Islam Singapura	        [Singapur]  |     20°	    |       18°        |    Singapur
Shia Ithna-Ashari, Leva Inst., Qum	    [Jafari]  |     16°	    |       14°        |    Some Shia communities worldwide
Institute of Geophysics,                        |               |                  |              
                University of Tehran    [Tehran]	|     17.7      |       14         |    Some Shia communities

*/

/*
Prayer	Start Time
------------------
Fajr	Dawn: when a line of light first appears and begins to spread across the horizon
Ẓuhr	After midday: when the sun has crossed its highest point and has begun to decline
ʿAsr	When the shadow of an object, minus its shadow at noon, equals the object itself 
        [or twice the object according to Imam Abū Ḥanīfah]
Maghrib	Sunset: when the disc of the sun has gone below the horizon
ʿIshā’	When the reddish glow has disappeared from the sky after sunset 
        [or whitish glow according to Imam Abū Ḥanīfah]

*/

Map methods = {
  "MWL": {
    "title": "Muslim World League",
    "angle": {"Fajr": 18, "Isha": 17},
  },
  "ISNA": {
    "title": "Islamic Society of North America",
    "angle": {"Fajr": 15, "Isha": 15},
  },
  "France": {
    "title": "Union of Islamic Orgs of France",
    "angle": {"Fajr": 12, "Isha": 12},
  },
  "Egypt": {
    "title": "Egyptian General Authority of Survey",
    "angle": {"Fajr": 19.5, "Isha": 17.5},
  },
  "Makkah": {
    "title": "Umm al-Qura University, Makkah",
    "angle": {"Fajr": 18.5},
  },
  "Karachi": {
    "title": "University of Islamic Sciences, Karachi",
    "angle": {"Fajr": 18, "Isha": 18},
  },
  "Singapur": {
    "title": "Majlis Ugama Islam Singapura",
    "angle": {"Fajr": 20, "Isha": 18},
  },
  "Jafari": {
    "title": "Shia Ithna-Ashari, Leva Inst., Qum",
    "angle": {"Fajr": 16, "Isha": 14},
  },
  "Tehran": {
    "title": "Institute of Geophysics, University of Tehran",
    "angle": {"Fajr": 17.7, "Isha": 14},
  },
};
