import 'package:flutter/material.dart';

class Match {
  String group;
  String team1;
  String team2;
  String date;
  String hours;
  String pictureTeam1;
  String pictureTeam2;

  Match(
      {required this.group,
      required this.team1,
      required this.team2,
      required this.date,
      required this.hours,
      required this.pictureTeam1,
      required this.pictureTeam2});
}

List<Match> getFakeMatch() {
  return [
    Match(
        group: "groupe A",
        team1: "CIV",
        team2: "GNB",
        date: "13/01/2024",
        hours: "20:00",
        pictureTeam1: "https://flagcdn.com/w2560/ci.png",
        pictureTeam2:
            "https://th.bing.com/th?id=OIP.lZLciSn74umnAVtqbkjk_gHaEx&w=311&h=200&c=8&rs=1&qlt=90&o=6&dpr=1.5&pid=3.1&rm=2"),
    Match(
        group: "groupe A",
        team1: "NGA",
        team2: "EQG",
        date: "14/01/2024",
        hours: "14:00",
        pictureTeam1:
            "https://test.s-p5.com/appbckk/ANSUT/public/storage/team_flags/YYlZCoiMXou7jntftEG96ADmLgA30jClVqu4De27.png",
        pictureTeam2:
            "https://test.s-p5.com/appbckk/ANSUT/public/storage/team_flags/iGIEGNaLaT1OJj19t0n7dPsPdnRHsJ7MQ9hExrVH.jpg"),
    Match(
        group: "groupe B",
        team1: "EGY",
        team2: "MOZ",
        date: "14/01/2024",
        hours: "17:00",
        pictureTeam1: "https://flagcdn.com/h240/ci.png",
        pictureTeam2:
            "https://th.bing.com/th?id=OIP.lZLciSn74umnAVtqbkjk_gHaEx&w=311&h=200&c=8&rs=1&qlt=90&o=6&dpr=1.5&pid=3.1&rm=2"),
    Match(
        group: "groupe B",
        team1: "GHA",
        team2: "CPV",
        date: "14/01/2024",
        hours: "20:00",
        pictureTeam1:
            "https://test.s-p5.com/appbckk/ANSUT/public/storage/team_flags/Puz5NFobdH8nUSejIGVGLgNAQGJHq78zIQwEOu5U.png",
        pictureTeam2:
            "https://flagcdn.com/h240/cv.png")
  ];
}
