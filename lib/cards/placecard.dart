import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PlaceCard extends StatefulWidget {
  int number;
  var place;
  PlaceCard({super.key, required this.number, required this.place});

  @override
  State<PlaceCard> createState() => _PlaceCardState();
}

class _PlaceCardState extends State<PlaceCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      //margin: EdgeInsets.symmetric(horizontal: 30, vertical: 5),
      margin: EdgeInsets.fromLTRB(15, 0, 15, 0),
      decoration: BoxDecoration(
          color:
              //Colors.primaries[Random().nextInt(Colors.primaries.length)],
              Colors.transparent,
          border: Border(
            bottom: BorderSide(width: 0.5, color: Colors.black12),
          )),
      child: Row(
        children: [
          Text(
            (widget.number + 1).toString() + "  ",
            style: TextStyle(
                fontSize: 14, fontWeight: FontWeight.bold, color: Colors.grey),
          ),
          Text(
            (widget.place).toString(),
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
