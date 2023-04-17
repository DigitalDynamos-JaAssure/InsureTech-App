import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gauges/gauges.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:insuretech_ja_assure/constants.dart';
import 'package:insuretech_ja_assure/screens/coverage_screen.dart';
import 'package:insuretech_ja_assure/screens/loading_screen.dart';
import 'package:page_transition/page_transition.dart';

class RiskScreen extends StatefulWidget {
  const RiskScreen({Key? key}) : super(key: key);

  @override
  State<RiskScreen> createState() => _RiskScreenState();
}

class _RiskScreenState extends State<RiskScreen> {
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var height = size.height;
    var width = size.width;
    var textScale = MediaQuery.of(context).textScaleFactor;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        automaticallyImplyLeading: !loading,
        backgroundColor: Colors.transparent,
        elevation: 0,
        systemOverlayStyle: SystemUiOverlayStyle.dark,
      ),
      body: (loading)
          ? LoadingPage()
          : SizedBox(
              height: height,
              width: width,
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(32.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Great!",
                        style: GoogleFonts.montserrat(
                            color: Colors.black,
                            fontSize: 37 * textScale,
                            fontWeight: FontWeight.w600),
                        textAlign: TextAlign.start,
                      ),
                      SizedBox(
                        height: 2,
                      ),
                      Text(
                        'Your risk factor is calculated as follows! This will be used to calculate your insurance amount.',
                        style: GoogleFonts.montserrat(
                            color: Colors.black,
                            fontSize: 16 * textScale,
                            fontWeight: FontWeight.w400),
                        textAlign: TextAlign.start,
                      ),
                      SizedBox(
                        height: height * 120 / 892,
                      ),
                      Container(
                        height: height * 0.15,
                        width: width,
                        child: Stack(
                          fit: StackFit.expand,
                          children: [
                            RadialGauge(
                              axes: [
                                RadialGaugeAxis(
                                  pointers: [
                                    RadialNeedlePointer(
                                      value: 0.5,
                                      thicknessStart: 10,
                                      thicknessEnd: 0,
                                      length: 0.65,
                                      knobRadiusAbsolute: 10,
                                    )
                                  ],
                                  segments: [
                                    RadialGaugeSegment(
                                      minValue: 0,
                                      maxValue: 0.3,
                                      minAngle: -90,
                                      maxAngle: -30,
                                      color: Colors.green,
                                    ),
                                    RadialGaugeSegment(
                                      minValue: 0.3,
                                      maxValue: 0.7,
                                      minAngle: -30,
                                      maxAngle: 30,
                                      color: Colors.orange,
                                    ),
                                    RadialGaugeSegment(
                                      minValue: 0.7,
                                      maxValue: 1,
                                      minAngle: 30,
                                      maxAngle: 90,
                                      color: Colors.red,
                                    ),
                                  ],
                                  minValue: 0,
                                  maxValue: 1,
                                  minAngle: -90,
                                  maxAngle: 90,
                                  radius: 0.6,
                                ),
                              ],
                            ),
                            Align(
                              alignment: Alignment.bottomCenter,
                              child: Text(
                                "0.5",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: textScale * 30,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: height * 100 / 892,
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                              kPrimaryColor,
                            ),
                            padding: MaterialStateProperty.all(
                              EdgeInsets.symmetric(
                                horizontal: 0,
                                vertical: 20,
                              ),
                            ),
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              PageTransition(
                                child: CoverageScreen(
                                  riskFactor: 0.5,
                                ),
                                type: PageTransitionType.fade,
                              ),
                            );
                          },
                          child: Text(
                            "OK",
                            style: TextStyle(
                              fontSize: textScale * 17,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: height * 60 / 892,
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
