import 'package:flutter/material.dart';

import 'kakaologin.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  void initState() {
    autoSignInWithKakao(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.all(40.0),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "헤쳐모여",
              style: TextStyle(
                color: Colors.green,
                fontWeight: FontWeight.bold,
                fontSize: 60,
                decoration: TextDecoration.none,
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 2 / 5,
            ),
            ElevatedButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.yellow)),
                onPressed: () {
                  signInWithKakao(context);
                },
                child: Text("카카오톡으로 로그인"))
          ],
        ),
      ),
    );
    ;
  }
}
