import 'package:children_now/components/login/card_login.dart';
import 'package:children_now/components/login/card_register.dart';
import 'package:flutter/material.dart';

class PageLogin extends StatefulWidget {
  const PageLogin({Key? key}) : super(key: key);

  @override
  _PageLoginState createState() => _PageLoginState();
}

class _PageLoginState extends State<PageLogin> {
  bool showCardLogin = true;

  @override
  Widget build(BuildContext context) {
    Size deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.bottomCenter,
              end: Alignment(
                  0.8, 0.0), // 10% of the width, so there are ten blinds.
              colors: <Color>[
                Color(0xff666264),
                Color(0xffCAC4C7)
              ], // red to yellow
              tileMode: TileMode.mirror, // repeats the gradient over the canvas
            ),
          ),
          child: ListView(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 0, horizontal: 50),
                child: Image.asset(
                  'assets/logo.png',
                  height: deviceSize.height / 2.8,
                  width: deviceSize.width / 3,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    top: 5.0, bottom: 15, left: 10, right: 10),
                child: showCardLogin
                    ? CardLogin(showRegister: () {
                        setState(() {
                          showCardLogin = !showCardLogin;
                        });
                      })
                    : CardRegister(showRegister: () {
                        setState(() {
                          showCardLogin = !showCardLogin;
                        });
                      }),
              )
            ],
          ),
        ),
      ),
    );
  }
}
