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


