import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:insuretech_ja_assure/constants.dart';
import 'package:insuretech_ja_assure/screens/home_screen.dart';
import 'package:insuretech_ja_assure/screens/loading_screen.dart';
import 'package:insuretech_ja_assure/services/api_calls.dart';
import 'package:insuretech_ja_assure/widgets/buttons.dart';
import 'package:insuretech_ja_assure/widgets/show_snack_bar.dart';
import 'package:page_transition/page_transition.dart';

class CoverageScreen extends StatefulWidget {
  final double riskFactor;
  const CoverageScreen({Key? key, required this.riskFactor}) : super(key: key);

  @override
  State<CoverageScreen> createState() => _CoverageScreenState();
}

class _CoverageScreenState extends State<CoverageScreen> {
  final _myBox = Hive.box("myBox");
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    List<String> value = (widget.riskFactor < 0.5)
        ? [
            "Crash",
            "Dent",
            "Headlight",
            "Windshield",
            "Scratches",
            "Tyre",
          ]
        : (widget.riskFactor < 0.8)
            ? [
                "Crash",
                "Headlight",
                "Windshield",
                "Tyre",
              ]
            : [
                "Windshield",
                "Crash",
              ];
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
                  padding: const EdgeInsets.symmetric(horizontal: 32.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Coverages under your risk factor",
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
                        'These are the coverages that come under your risk factor.',
                        style: GoogleFonts.montserrat(
                            color: Colors.black,
                            fontSize: 16 * textScale,
                            fontWeight: FontWeight.w400),
                        textAlign: TextAlign.start,
                      ),
                      SizedBox(
                        height: height * 40 / 892,
                      ),
                      Container(
                        height: height * 0.35,
                        width: width,
                        decoration: BoxDecoration(
                          color: kPrimaryColor.withOpacity(0.1),
                          border: Border.all(
                            color: kPrimaryColor,
                          ),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ListView.builder(
                            itemBuilder: (context, index) => Padding(
                              padding: const EdgeInsets.only(bottom: 8.0),
                              child: Container(
                                height: height * 0.07,
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                        blurRadius: 2,
                                        color: Colors.black12,
                                        offset: Offset(
                                          1,
                                          1,
                                        )),
                                  ],
                                  borderRadius: BorderRadius.circular(
                                    8,
                                  ),
                                  color: Colors.white,
                                ),
                                child: Center(
                                  child: Text(
                                    value[index],
                                    style: TextStyle(
                                      fontSize: textScale * 18,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            itemCount: value.length,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: height * 40 / 892,
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Button1(
                          height: height,
                          width: width,
                          textScale: textScale,
                          text: "Confirm Purchase",
                          onTap: () async {
                            setState(() {
                              loading = true;
                            });
                            APICalls apiCalls = APICalls(context);
                            Map<String, dynamic> frc = await _myBox.get("frc");
                            Map<String, dynamic> brc = await _myBox.get("brc");
                            Map<String, dynamic> car = await _myBox.get("car");
                            Map<String, dynamic> data = {
                              "riskFactor": 0.5,
                              "policyType": "Car",
                              "carDetails": {
                                "carImg": car["car"],
                                "Engine_No": frc["Engion_No"],
                                "Color": brc["Color"],
                                "model": brc["model"],
                                "year": frc["year"],
                                "chesis_no": frc["chesis_no"],
                                "coverage": value
                              }
                            };
                            try {
                              await apiCalls.createPolicy(data);

                              Navigator.pushAndRemoveUntil(
                                context,
                                PageTransition(
                                  child: HomeScreen(),
                                  type: PageTransitionType.fade,
                                ),
                                (route) => false,
                              );
                            } catch (e) {
                              showSnackBar(
                                context,
                                "Some error occured!",
                                Colors.red,
                              );
                            }
                            setState(() {
                              loading = false;
                            });
                          },
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
