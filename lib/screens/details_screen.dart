import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:insuretech_ja_assure/constants.dart';
import 'package:insuretech_ja_assure/screens/upload_file_screen.dart';
import 'package:insuretech_ja_assure/widgets/buttons.dart';
import 'package:page_transition/page_transition.dart';

class DetailsScreen extends StatefulWidget {
  const DetailsScreen({Key? key}) : super(key: key);

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var height = size.height;
    var width = size.width;
    var textScale = MediaQuery.of(context).textScaleFactor;
    return Scaffold(
      backgroundColor: Color(0xfff0f0f0),
      body: Container(
        height: height,
        width: width,
        child: SafeArea(
          child: Column(
            children: [
              Expanded(
                flex: 5,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 16.0,
                        top: 32,
                      ),
                      child: Text(
                        "Type of the vehicle",
                        style: TextStyle(
                          fontSize: textScale * 48,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 16.0,
                      ),
                      child: Text(
                        "Gas",
                        style: TextStyle(
                          fontSize: textScale * 18,
                          fontWeight: FontWeight.w600,
                          color: kPrimaryColor,
                        ),
                      ),
                    ),
                    Hero(
                      tag: "car",
                      child: Image.asset(
                        "assets/landcruiser.png",
                        height: height * 0.18,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 6,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(32),
                      topRight: Radius.circular(32),
                    ),
                    color: Colors.white,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24.0,
                      vertical: 32,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          "Information",
                          style: TextStyle(
                            fontSize: textScale * 24,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        Spacer(),
                        InkWell(
                          onTap: () {},
                          child: RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(
                              text: "Insurance expiring? ",
                              style: GoogleFonts.nunito(
                                color: Colors.black,
                              ),
                              children: [
                                TextSpan(
                                  text: "Renew Now!",
                                  style: TextStyle(
                                    color: kPrimaryColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        Button1(
                          height: height,
                          width: width,
                          textScale: textScale,
                          text: "Claim Insurance",
                          onTap: () {
                            Navigator.push(
                              context,
                              PageTransition(
                                child: UploadFile(
                                  type: "bb",
                                  title: "Let's get started",
                                  typeOfDocument: "bifurcated bill",
                                ),
                                type: PageTransitionType.fade,
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
