import 'dart:math';

import 'package:flutter/material.dart';

class FriendCard extends StatefulWidget {
  int number;
  FriendCard({Key? key, required this.number}) : super(key: key);

  @override
  State<FriendCard> createState() => _FriendCardState();
}

class _FriendCardState extends State<FriendCard> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: InkWell(
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
                    backgroundImage: NetworkImage(
                        "https://search.pstatic.net/common/?src=http%3A%2F%2Fblogfiles.naver.net%2FMjAyMDEwMTFfMjYy%2FMDAxNjAyNDE3MTAyNzA5.s9DDYjp80nMnE9hYw_Y6X48ey8j1Tl34KwcfNBkKMMUg.7nTl9qcOXOcI28QZeBKkJ_ysXJYdRSfYJu6DdLKPAmIg.GIF.mynxax%2F963FB7AF-8672-4E9D-B9FD-A0D10AEC34AE-1106-000000C63BF7B273_file.gif&type=sc960_832_gif"),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Container(
                    child: Text("친구이름 " + widget.number.toString()),
                  )
                ],
              ),
            ],
          ),
        ),
        onTap: () {},
      ),
    );
  }
}
