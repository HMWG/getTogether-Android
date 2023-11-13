import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class FriendCard extends StatefulWidget {
  int id;
  String name;
  String image;
  FriendCard(
      {Key? key, required this.id, required this.name, required this.image})
      : super(key: key);

  @override
  State<FriendCard> createState() => _FriendCardState();
}

class _FriendCardState extends State<FriendCard> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 15),
        width: double.maxFinite,
        height: 65,
        decoration: BoxDecoration(
            color:
                //Colors.primaries[Random().nextInt(Colors.primaries.length)],
                Colors.transparent,
            border: Border(
              bottom: BorderSide(width: 0.5, color: Colors.black12),
            )),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 23,
                  child: CircularProgressIndicator(),
                  foregroundImage: CachedNetworkImageProvider(
                    widget.image,
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Container(
                  child: Text(
                    widget.name,
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                )
              ],
            ),
            //IconButton(onPressed: () {}, icon: Icon(Icons.more_horiz))
          ],
        ),
      ),
    );
  }
}
