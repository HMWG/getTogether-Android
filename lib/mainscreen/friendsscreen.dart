import 'package:flutter/material.dart';
import 'package:get_together_android/cards/friendcard.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';

import '../kakaologin.dart';

class FriendsScreen extends StatefulWidget {
  const FriendsScreen({Key? key}) : super(key: key);

  @override
  State<FriendsScreen> createState() => _FriendsScreenState();
}

class _FriendsScreenState extends State<FriendsScreen> {
  List<Friend> friendsList = [];
  bool isLoading = true;

  Future initFriends() async {
    friendsList = await kakaoFriends();
  }

  @override
  void initState() {
    checkSignInWithKakao(context);
    super.initState();
    initFriends().then((_) {
      setState(() {
        isLoading = false;
      });
    });
  }

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
          //IconButton(onPressed: () {}, icon: Icon(Icons.person_add_alt_1))
        ],
      ),
      body: isLoading
          ? Center(
              child: const CircularProgressIndicator(),
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.fromLTRB(15, 3, 3, 3),
                  child: Text(
                    "친구 - " + friendsList.length.toString() + "명",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                ),
                friendsList.isEmpty
                    ? Center(
                        child: Text(
                          userInfo.name + '님의 친구가 없습니다.',
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1.0),
                        ),
                      )
                    : Container(
                        child: Expanded(
                          child: ListView.builder(
                              itemCount: friendsList.length,
                              itemBuilder: (BuildContext context, int index) {
                                return InkWell(
                                    onTap: () {},
                                    child: FriendCard(
                                      id: friendsList[index].id!,
                                      name: friendsList[index].profileNickname!,
                                      image: friendsList[index]
                                                  .profileThumbnailImage ==
                                              ""
                                          ? "https://velog.velcdn.com/images/bluesun147/post/4715896b-1cb1-4c72-a577-4a0847dfbf1d/image.jpg"
                                          : friendsList[index]
                                              .profileThumbnailImage!,
                                    ));
                              }),
                        ),
                      ),
              ],
            ),
    );
  }
}
