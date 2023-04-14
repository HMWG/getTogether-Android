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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          child: Text("친구 " + num.toString()),
        ),
        Container(
          child: Expanded(
            child: ListView.builder(
                itemCount: num,
                itemBuilder: (BuildContext context, int index) {
                  return FriendCard(number: index);
                }),
          ),
        ),
      ],
    );
  }
}
