import 'package:flutter/material.dart';
import 'package:insuretech_ja_assure/screens/home_screen.dart';
import 'package:insuretech_ja_assure/widgets/buttons.dart';
import 'package:page_transition/page_transition.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var height = size.height;
    var width = size.width;
    var textScale = MediaQuery.of(context).textScaleFactor;
    return Scaffold(
      body: Container(
        height: height,
        width: width,
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: height * 0.08,
              ),
              Container(
                width: width * 0.85,
                child: Image.asset(
                  "assets/jalogo-grey.png",
                  fit: BoxFit.fitHeight,
                ),
              ),
              SizedBox(
                height: height * 0.4,
              ),
              Hero(
                tag: "login",
                child: Button1(
                  height: height,
                  width: width,
                  textScale: textScale,
                  text: 'Login',
                  onTap: () {
                    Navigator.pushAndRemoveUntil(
                      context,
                      PageTransition(
                        child: HomeScreen(),
                        type: PageTransitionType.fade,
                        duration: Duration(
                          milliseconds: 350,
                        ),
                      ),
                      (route) => false,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
