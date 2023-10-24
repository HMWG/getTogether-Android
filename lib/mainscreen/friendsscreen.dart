import 'package:flutter/material.dart';
import 'package:get_together_android/cards/friendcard.dart';

class FriendsScreen extends StatefulWidget {
  const FriendsScreen({Key? key}) : super(key: key);

  @override
  State<FriendsScreen> createState() => _FriendsScreenState();
}

class _FriendsScreenState extends State<FriendsScreen> {
  int num = 30;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "친구",
          style: TextStyle(
              fontFamily: "yeonSung", fontSize: 25, color: Colors.black),
        ),
        centerTitle: false,
        elevation: 0.0,
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.person_add_alt_1))
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.fromLTRB(15, 3, 3, 3),
            child: Text(
              "친구 - " + num.toString() + "명",
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            child: Expanded(
              child: ListView.builder(
                  itemCount: num,
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(
                        onTap: () {}, child: FriendCard(number: index));
                  }),
            ),
          ),
        ],
      ),
    );
  }
}
