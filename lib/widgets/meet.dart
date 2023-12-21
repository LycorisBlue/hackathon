import 'package:flutter/material.dart';
import '../models/matchs.dart';


class ListMatch extends StatelessWidget {

  final List<Match> match;
  ListMatch({required this.match});

  @override
  Widget build(BuildContext context) {


    return ListView.builder(
      itemCount: match.length,
      itemBuilder: (context, index){
        var currentMatch = match[index];

        return MatchWidget(match: currentMatch);
      }
    );
  }
}


class MatchWidget extends StatelessWidget {
  
  final Match match;

  const MatchWidget({
    required this.match,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      child: Row(
        children: [
          SizedBox(width: 15), 
          Container(
            padding: EdgeInsets.all(15),
            child: Image.network(
              match.pictureTeam1,
              height: 50,
              width: 80,
              fit: BoxFit.fill,
            ),
          ),
          SizedBox(width: 10), 
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "${match.team1} - ${match.team2}",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16
                  ),
                ),

                SizedBox(height: 5),
                Text("En cours...", style: TextStyle(fontStyle: FontStyle.italic),)

              ],
            ),
          ),

          SizedBox(width: 10),
          Container(
            padding: EdgeInsets.all(15),
            child: Image.network(
              match.pictureTeam2,
              height: 50,
              width: 80,
              fit: BoxFit.fill,
            ),
          ),
          SizedBox(width: 15), 
        ],  
      ),
    );
  }

}