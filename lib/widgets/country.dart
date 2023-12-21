import 'package:flutter/material.dart';
import '../models/country.dart';


class FlagCircle extends StatelessWidget {
  
  final String flag;
  
  const FlagCircle({
    Key? key, 
    required this.flag,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 20,
      height: 20,
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        image: DecorationImage(
          image: NetworkImage(flag),
          fit: BoxFit.cover
        )  
      ),
    );
  }
}


class FlagsGrid extends StatelessWidget {

  final List<Country> countries;
  final int crossAxisCount;

  const FlagsGrid({
    Key? key,
    required this.countries,
    this.crossAxisCount = 4,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.count(  
      padding: EdgeInsets.all(20),
      crossAxisCount: crossAxisCount,
      children: countries.map((country) {
        return Padding(
          padding: const EdgeInsets.all(5.0),
          child: FlagCircle(flag: country.flag), 
        );  
      }).toList(),
    );
  }
}