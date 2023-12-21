import 'package:flutter/material.dart';

class Country {
  String team;
  String flag;

  Country({required this.team, required this.flag});
}

List<Country> countries() {
  return [
    
    Country(
      team: "Algérie",
      flag: "https://flagcdn.com/w2560/dz.png"
    ),
    
    Country(
      team: "afrique du sud",
      flag: "https://flagcdn.com/w2560/za.png"
    ),
    Country(
      team: "angola", 
      flag: "https://flagcdn.com/w2560/ao.png"
    ),
    Country(
      team: "Burkina Faso",
      flag: "https://flagcdn.com/w2560/bf.png"
    ),
    Country(
      team: "cameroun",
      flag: "https://flagcdn.com/w2560/cm.png"
    ),
    Country(
      team: "Cap-Vert",
      flag: "https://flagcdn.com/w2560/cv.png"
    ),
    Country( 
      team: "Côte d'Ivoire",
      flag: "https://flagcdn.com/w2560/ci.png"
    ),
    Country(
      team: "Égypte",
      flag: "https://flagcdn.com/w2560/eg.png"
    ),
    Country(
      team: "Gambie",
      flag: "https://flagcdn.com/w2560/gm.png"
    ),
    Country(
      team: "Ghana",
      flag: "https://flagcdn.com/w2560/gh.png"
    ),
    Country(
      team: "Guinee",
      flag: "https://flagcdn.com/w2560/gn.png"
    ),
    Country(
      team: "Guinée-Bissau",
      flag: "https://flagcdn.com/w2560/gw.png" 
    ),
    Country(
      team: "Guinée équatoriale",
      flag: "https://flagcdn.com/w2560/gq.png"
    ),
    Country(
      team: "Mali", 
      flag: "https://flagcdn.com/w2560/ml.png"
    ),
    Country(
      team: "Maroc", 
      flag: "https://flagcdn.com/w2560/ma.png"
    ),
    Country(
      team: "Mauritanie", 
      flag: "https://flagcdn.com/w2560/mr.png"
    ),
    Country(
      team: "Mozambique", 
      flag: "https://flagcdn.com/w2560/mz.png"
    ),
    Country(
      team: "Namibie", 
      flag: "https://flagcdn.com/w2560/na.png"
    ),
    Country(
      team: "Nigeria", 
      flag: "https://flagcdn.com/w2560/ng.png"
    ),
    Country(
      team: "RD congo", 
      flag: "https://flagcdn.com/w2560/cd.png"
    ),
    Country(
      team: "Sénégal", 
      flag: "https://flagcdn.com/w2560/sn.png"
    ),
    Country(
      team: "Tanzanie", 
      flag: "https://flagcdn.com/w2560/tz.png"
    ),
    Country(
      team: "Tunisie", 
      flag: "https://flagcdn.com/w2560/tn.png"
    ),
    Country(
      team: "Zambie", 
      flag: "https://flagcdn.com/w2560/zm.png"
    ),
  ];
}