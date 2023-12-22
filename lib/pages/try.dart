// import "package:flutter/material.dart";
// import "../models/country.dart";
// import "../widgets/country.dart";
// // import "../widgets/meet.dart";

// class MyTabBar extends StatefulWidget {
//   @override
//   _MyTabBarState createState() => _MyTabBarState();
// }

// class _MyTabBarState extends State<MyTabBar>
//     with SingleTickerProviderStateMixin {
//   late TabController controller;

//   @override
//   void initState() {
//     super.initState();

//     controller = TabController(length: 3, vsync: this);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         bottom: TabBar(
//           padding: EdgeInsets.only(top: 10),
//           controller: controller,
//           tabs: [
//             Tab(
//               icon: Icon(Icons.schedule),
//               text: "Accueil",
//             ),
//             Tab(
//               icon: Icon(Icons.sports_score),
//               text: "Recherche",
//             ),
//             Tab(icon: Icon(Icons.equalizer), text: "Paramètres")
//           ],
//         ),
//       ),
//       body: TabBarView(
//         controller: controller,
//         children: [FirstTab(), SecondTab(), ThirdTab()],
//       ),
//     );
//   }
// }

// class FirstTab extends StatelessWidget {
//   const FirstTab({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(body: Text("data"));
//   }
// }

// class SecondTab extends StatelessWidget {
//   const SecondTab({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(child: FlagsGrid(countries: countries())),
//     );
//   }
// }

// class ThirdTab extends StatelessWidget {
//   const ThirdTab({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return const Center(
//       child: Text("Page 1"),
//     );
//   }
// }
