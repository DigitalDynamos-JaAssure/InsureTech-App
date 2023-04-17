import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:insuretech_ja_assure/screens/login_screen.dart';
import 'package:insuretech_ja_assure/widgets/buttons.dart';
import 'package:page_transition/page_transition.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var height = size.height;
    var width = size.width;
    var textScale = MediaQuery.of(context).textScaleFactor;
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: height,
            width: width,
            decoration: BoxDecoration(
                image: DecorationImage(
              image: AssetImage(
                "assets/home_bg.png",
              ),
              fit: BoxFit.cover,
            )),
          ),
          Container(
            height: height,
            width: width,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xff060f1b),
                  Color(0xff060f1b),
                  Color(0xff060f1b).withOpacity(0.9),
                  Color(0xff060f1b).withOpacity(0.7),
                  Color(0xff060f1b).withOpacity(0.5),
                  Color(0xff060f1b).withOpacity(0.0),
                  Color(0xff060f1b).withOpacity(0.0),
                  Color(0xff060f1b).withOpacity(0.0),
                  Color(0xff060f1b).withOpacity(0.0),
                  Color(0xff060f1b).withOpacity(0.0),
                  Color(0xff060f1b).withOpacity(0.0),
                  Color(0xff060f1b).withOpacity(0.0),
                  Color(0xff060f1b).withOpacity(0.5),
                  Color(0xff060f1b).withOpacity(0.7),
                  Color(0xff060f1b).withOpacity(0.9),
                  Color(0xff060f1b),
                  Color(0xff060f1b),
                ],
              ),
            ),
          ),
          SizedBox(
            height: height,
            width: width,
            child: Column(
              children: [
                SizedBox(
                  height: height * 0.08,
                ),
                Container(
                  width: width * 0.85,
                  child: Image.asset(
                    "assets/jalogo.png",
                    fit: BoxFit.fitHeight,
                  ),
                ),
                Spacer(),
                Text(
                  "Dont have an account? Sign Up",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                Hero(
                  tag: "login",
                  child: Button1(
                    height: height,
                    width: width,
                    textScale: textScale,
                    text: 'Login',
                    onTap: () {
                      Navigator.push(
                        context,
                        PageTransition(
                          child: LoginScreen(),
                          type: PageTransitionType.fade,
                          duration: Duration(
                            milliseconds: 350,
                          ),
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(
                  height: height * 0.04,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
