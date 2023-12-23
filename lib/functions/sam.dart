import 'package:hive/hive.dart';

import '../models/country.dart';

// Définir un box Hive pour stocker les drapeaux
// final _flagsBox = Hive.box('flags'); 

String getFlag(String countryName) {

  // Liste des équipes 
  final teams = [
    
    Country(
      team: "Algérie",
      flag: "https://s-p5.com/medi/ansut/pictures/Alg%C3%A9rie.png"
    ),
    
    Country(
      team: "afrique du sud",
      flag: "https://s-p5.com/medi/ansut/pictures/Afrique%20du%20Sud.png"
    ),
    Country(
      team: "angola", 
      flag: "https://s-p5.com/medi/ansut/pictures/Angola.png"
    ),
    Country(
      team: "Burkina Faso",
      flag: "https://s-p5.com/medi/ansut/pictures/Burkina.png"
    ),
    Country(
      team: "cameroun",
      flag: "https://s-p5.com/medi/ansut/pictures/Cameroun.png"
    ),
    Country(
      team: "Cap-Vert",
      flag: "https://s-p5.com/medi/ansut/pictures/Cape%20vert.png"
    ),
    Country( 
      team: "Côte d'Ivoire",
      flag: "https://s-p5.com/medi/ansut/pictures/C%C3%B4te%20d%E2%80%99Ivoire.png"
    ),
    Country(
      team: "Égypte",
      flag: "https://s-p5.com/medi/ansut/pictures/%C3%89gypte.png"
    ),
    Country(
      team: "Gambie",
      flag: "https://s-p5.com/medi/ansut/pictures/Gambie.png"
    ),
    Country(
      team: "Ghana",
      flag: "https://s-p5.com/medi/ansut/pictures/Ghana.png"
    ),
    Country(
      team: "Guinee",
      flag: "https://s-p5.com/medi/ansut/pictures/Guin%C3%A9e%20Conakry.png"
    ),
    Country(
      team: "Guinée-Bissau",
      flag: "https://s-p5.com/medi/ansut/pictures/Guin%C3%A9e%20Bissau.png" 
    ),
    Country(
      team: "Guinée équatoriale",
      flag: "https://s-p5.com/medi/ansut/pictures/%C3%89quatoriale%20Guin%C3%A9e.png"
    ),
    Country(
      team: "Mali", 
      flag: "https://s-p5.com/medi/ansut/pictures/Mali.png"
    ),
    Country(
      team: "Maroc", 
      flag: "https://s-p5.com/medi/ansut/pictures/Maroc.png"
    ),
    Country(
      team: "Mauritanie", 
      flag: "https://s-p5.com/medi/ansut/pictures/Mauritanie.png"
    ),
    Country(
      team: "Mozambique", 
      flag: "https://s-p5.com/medi/ansut/pictures/Mozambique.png"
    ),
    Country(
      team: "Namibie", 
      flag: "https://s-p5.com/medi/ansut/pictures/Namibie.png"
    ),
    Country(
      team: "Nigeria", 
      flag: "https://s-p5.com/medi/ansut/pictures/Nigeria.png"
    ),
    Country(
      team: "RD congo", 
      flag: "https://s-p5.com/medi/ansut/pictures/RD%20Congo.png"
    ),
    Country(
      team: "Sénégal", 
      flag: "https://s-p5.com/medi/ansut/pictures/S%C3%A9n%C3%A9gal.png"
    ),
    Country(
      team: "Tanzanie", 
      flag: "https://s-p5.com/medi/ansut/pictures/Tanzanie.png"
    ),
    Country(
      team: "Tunisie", 
      flag: "https://s-p5.com/medi/ansut/pictures/Tunisie.png"
    ),
    Country(
      team: "Zambie", 
      flag: "https://s-p5.com/medi/ansut/pictures/Zambie.png"
    ),
  ];

  // Trouver le pays dans la liste
  final country = teams.firstWhere((c) => c.team == countryName);

  if (true) {
    // Enregistrer le drapeau dans Hive
    // _flagsBox.put(countryName, country.flag);

    // Retourner le drapeau
    return country.flag; 
  }

}