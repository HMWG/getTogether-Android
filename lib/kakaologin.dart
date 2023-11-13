import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get_together_android/entity/memberentity.dart';
import 'package:get_together_android/langdingpage.dart';
import 'package:get_together_android/mainpage.dart';
import 'package:get_together_android/spring.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'package:flutter/services.dart';
import 'package:logging/logging.dart';

import 'loginpage.dart';

//final Logger _logger = Logger('Kakao Login');

UserInfo userInfo = new UserInfo(name: '알수없음');

void _getUserInfo() async {
  try {
    User user = await UserApi.instance.me();
    print(
        '사용자 정보 요청 성공: 회원번호: ${user.id}, 닉네임: ${user.kakaoAccount?.profile?.nickname}');
    userInfo.id = user.id;
    userInfo.name = "${user.kakaoAccount?.profile?.nickname}";
  } catch (error) {
    print('사용자 정보 요청 실패: $error');
    userInfo.id = null;
    userInfo.name = "알수없음";
  }
}

void _joinUserInfo() async {
  try {
    User user = await UserApi.instance.me();
    print(
        '사용자 정보 요청 성공: 회원번호: ${user.id}, 닉네임: ${user.kakaoAccount?.profile?.nickname}');
    userInfo.id = user.id;
    userInfo.name = "${user.kakaoAccount?.profile?.nickname}";
    await saveMember(new Member(
        id: user.id, username: user.kakaoAccount?.profile?.nickname));
  } catch (error) {
    print('사용자 정보 요청 실패: $error');
    userInfo.id = null;
    userInfo.name = "알수없음";
  }
}

class UserInfo {
  int? id;
  String name;

  UserInfo({this.id, required this.name});
}

Future<void> _goLoginPage(BuildContext context) async {
  Get.offAll(LoginPage());
}

Future<void> logout() async {
  try {
    await UserApi.instance.logout();
    print('로그아웃 성공, SDK에서 토큰 삭제');
  } catch (error) {
    print('로그아웃 실패, SDK에서 토큰 삭제 $error');
  }
}

Future<void> checkSignInWithKakao(BuildContext context) async {
  if (await AuthApi.instance.hasToken()) {
    try {
      AccessTokenInfo tokenInfo = await UserApi.instance.accessTokenInfo();
      print('토큰 유효성 체크 성공: ${tokenInfo.id} ${tokenInfo.expiresIn}');
      _getUserInfo();
    } catch (error) {
      if (error is KakaoException && error.isInvalidTokenError()) {
        print('토큰 만료: $error');
      } else {
        print('토큰 정보 조회 실패: $error');
      }

      await _goLoginPage(context);
    }
  } else {
    print('발급된 토큰 없음');
    await _goLoginPage(context);
  }
}

Future<void> autoSignInWithKakao(BuildContext context) async {
  if (await AuthApi.instance.hasToken()) {
    try {
      AccessTokenInfo tokenInfo = await UserApi.instance.accessTokenInfo();
      print('토큰 유효성 체크 성공: ${tokenInfo.id} ${tokenInfo.expiresIn}');
      Get.offAll(LandingPage());
      _getUserInfo();
    } catch (error) {
      if (error is KakaoException && error.isInvalidTokenError()) {
        print('토큰 만료: $error');
      } else {
        print('토큰 정보 조회 실패: $error');
      }
    }
  } else {
    print('발급된 토큰 없음');
  }
}

Future<void> signInWithKakao(BuildContext context) async {
  if (await AuthApi.instance.hasToken()) {
    try {
      AccessTokenInfo tokenInfo = await UserApi.instance.accessTokenInfo();
      print('토큰 유효성 체크 성공: ${tokenInfo.id} ${tokenInfo.expiresIn}');
      _getUserInfo();
      Get.offAll(LandingPage());
    } catch (error) {
      if (error is KakaoException && error.isInvalidTokenError()) {
        print('토큰 만료: $error');
      } else {
        print('토큰 정보 조회 실패: $error');
      }

      await loginWithKakaoAccount(context);
    }
  } else {
    print('발급된 토큰 없음');
    await loginWithKakaoAccount(context);
  }
}

Future<void> loginWithKakaoAccount(BuildContext context) async {
  if (await isKakaoTalkInstalled()) {
    try {
      OAuthToken token = await UserApi.instance.loginWithKakaoTalk();
      print('카카오톡으로 로그인 성공: ${token.accessToken}');
      _joinUserInfo();
      Get.offAll(LandingPage());
    } catch (error) {
      print('카카오톡으로 로그인 실패: $error');

      if (error is PlatformException && error.code == 'CANCELED') {
        return;
      }

      await _loginWithKakaoAccountFallback(context);
    }
  } else {
    await _loginWithKakaoAccountFallback(context);
  }
}

Future<void> _loginWithKakaoAccountFallback(BuildContext context) async {
  try {
    OAuthToken token = await UserApi.instance.loginWithKakaoAccount();
    print('카카오계정으로 로그인 성공: ${token.accessToken}');
    _joinUserInfo();
    Get.offAll(LandingPage());
  } catch (error) {
    print('카카오계정으로 로그인 실패: $error');
  }
}

Future<int?> _getUserId() async {
  try {
    User user = await UserApi.instance.me();
    print(
        '사용자 정보 요청 성공: 회원번호: ${user.id}, 닉네임: ${user.kakaoAccount?.profile?.nickname}');
    return user.id;
  } catch (error) {
    print('사용자 정보 요청 실패: $error');
    return null;
  }
}

Future<void> loginWithKakaoNewScope() async {
  User user;
  List<String> haveScopes = ['friends'];
  List<String> scopes = [];

  try {
    user = await UserApi.instance.me();
  } catch (error) {
    print('사용자 정보 요청 실패 $error');
    return;
  }

  try {
    ScopeInfo scopeInfo = await UserApi.instance.scopes(scopes: haveScopes);
    print('동의 정보 확인 성공'
        '\n현재 사용자가 동의한 항목: ${scopeInfo.scopes}');
    if (scopeInfo.scopes![0].agreed == false) {
      scopes.add("friends");
    } else
      print("확인 성공");
  } catch (error) {
    print('동의 내역 확인 실패 $error');
  }

  if (scopes.length > 0) {
    print('사용자에게 추가 동의 받아야 하는 항목이 있습니다');

    // OpenID Connect 사용 시
    // scope 목록에 "openid" 문자열을 추가하고 요청해야 함
    // 해당 문자열을 포함하지 않은 경우, ID 토큰이 재발급되지 않음
    // scopes.add("openid")

    // scope 목록을 전달하여 추가 항목 동의 받기 요청
    // 지정된 동의항목에 대한 동의 화면을 거쳐 다시 카카오 로그인 수행
    OAuthToken token;
    try {
      token = await UserApi.instance.loginWithNewScopes(scopes);
      print('현재 사용자가 동의한 동의항목: ${token.scopes}');
    } catch (error) {
      print('추가 동의 요청 실패 $error');
      return;
    }

    // 사용자 정보 재요청
    _getUserInfo();
  }
}

Future<SelectedUsers?> kakaoPicker(BuildContext context) async {
  // 파라미터 설정
  loginWithKakaoNewScope();

  var params = PickerFriendRequestParams(
    title: '멀티 친구 피커',
    enableSearch: true,
    showMyProfile: true,
    showFavorite: true,
    showPickedFriend: null,
    maxPickableCount: null,
    minPickableCount: null,
    enableBackButton: true,
  );

  var pickedId;

// 피커 호출
  try {
    SelectedUsers users = await PickerApi.instance
        .selectFriends(params: params, context: context);
    print('친구 선택 성공: ${users.users!.length}');

    return users;
  } catch (e) {
    print('친구 선택 실패: $e');
  }
  return null;
}

Future<List<Friend>> kakaoFriends() async {
  List<Friend> friendsList = [];

  try {
    Friends friends = await TalkApi.instance.friends();
    print('카카오톡 친구 목록 가져오기 성공'
        '\n${friends.elements?.map((friend) => friend.profileNickname).join('\n')}'
        '\n${friends.elements?.map((friend) => friend.profileThumbnailImage).join('\n')}');
    friendsList.addAll(friends.elements as Iterable<Friend>);
  } catch (error) {
    print('카카오톡 친구 목록 가져오기 실패 $error');
  }
  return friendsList;
}
