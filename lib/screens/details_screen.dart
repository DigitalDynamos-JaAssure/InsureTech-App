import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:insuretech_ja_assure/constants.dart';
import 'package:insuretech_ja_assure/data/policies_data.dart';
import 'package:insuretech_ja_assure/screens/upload_file_screen.dart';
import 'package:insuretech_ja_assure/screens/verification_screen.dart';
import 'package:insuretech_ja_assure/widgets/buttons.dart';
import 'package:insuretech_ja_assure/widgets/show_snack_bar.dart';
import 'package:page_transition/page_transition.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailsScreen extends StatefulWidget {
  final Policies policies;
  const DetailsScreen({Key? key, required this.policies}) : super(key: key);

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  var _myBox = Hive.box("myBox");
  String isProcessing = "no";
  var details;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isProcessing = _myBox.get(widget.policies.sId).toString();
    details = _myBox.get(widget.policies.sId! + "details");
  }

  @override
  Widget build(BuildContext context) {
    print(details.runtimeType);
    print(widget.policies.sId);
    var size = MediaQuery.of(context).size;
    var height = size.height;
    var width = size.width;
    var textScale = MediaQuery.of(context).textScaleFactor;
    return (isProcessing == "processing")
        ? UnderProcessPage(
            pid: widget.policies.sId,
          )
        : Scaffold(
            extendBodyBehindAppBar: true,
            appBar: AppBar(
              automaticallyImplyLeading: true,
              backgroundColor: Colors.transparent,
              elevation: 0,
              systemOverlayStyle: SystemUiOverlayStyle.dark,
            ),
            backgroundColor: Color(0xfff0f0f0),
            body: Container(
              height: height,
              width: width,
              child: SafeArea(
                top: false,
                child: Column(
                  children: [
                    Expanded(
                      flex: 5,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                              left: 16.0,
                              top: height * 0.08,
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
                              "assets/${(widget.policies.carDetails!.model.toString().split(" ")[0].toLowerCase() == 'i10') ? "i10" : "kiaseltos"}.png",
                              height: height * 0.16,
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
                              Spacer(),
                              (details == null || details == "null")
                                  ? SizedBox(
                                      height: height * 0.08,
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: Container(
                                              height: height * 0.08,
                                              decoration: BoxDecoration(
                                                color: Colors.grey.shade200,
                                                borderRadius:
                                                    BorderRadius.circular(
                                                  16,
                                                ),
                                              ),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 16.0),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment
                                                          .stretch,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      "Make",
                                                      style: TextStyle(
                                                        color: Colors.grey,
                                                      ),
                                                    ),
                                                    Text(
                                                      widget.policies
                                                          .carDetails!.model
                                                          .toString(),
                                                      style: TextStyle(
                                                        color: Colors.black,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 8,
                                          ),
                                          Expanded(
                                            child: Container(
                                              height: height * 0.08,
                                              decoration: BoxDecoration(
                                                color: Colors.grey.shade200,
                                                borderRadius:
                                                    BorderRadius.circular(
                                                  16,
                                                ),
                                              ),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 16.0),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment
                                                          .stretch,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      "Year",
                                                      style: TextStyle(
                                                        color: Colors.grey,
                                                      ),
                                                    ),
                                                    Text(
                                                      widget.policies
                                                          .carDetails!.year
                                                          .toString(),
                                                      style: TextStyle(
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  : SizedBox(),
                              SizedBox(
                                height: 12,
                              ),
                              Container(
                                height: height * 0.08,
                                width: width - 32,
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade200,
                                  borderRadius: BorderRadius.circular(
                                    16,
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        (details == null || details == "null")
                                            ? "Engine Number"
                                            : "Name",
                                        style: TextStyle(
                                          color: Colors.grey,
                                        ),
                                      ),
                                      Text(
                                        (details == null || details == "null")
                                            ? widget
                                                .policies.carDetails!.engineNo
                                                .toString()
                                            : details["name"].toString(),
                                        style: TextStyle(
                                          color: Colors.black,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 12,
                              ),
                              Container(
                                height: height * 0.08,
                                width: width - 32,
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade200,
                                  borderRadius: BorderRadius.circular(
                                    16,
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        (details == null || details == "null")
                                            ? "Chasis Number"
                                            : "Phone number",
                                        style: TextStyle(
                                          color: Colors.grey,
                                        ),
                                      ),
                                      Text(
                                        (details == null || details == "null")
                                            ? widget
                                                .policies.carDetails!.chesisNo
                                                .toString()
                                            : details["phone"],
                                        style: TextStyle(
                                          color: Colors.black,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Spacer(),
                              (details == null || details == "null")
                                  ? InkWell(
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
                                    )
                                  : SizedBox.shrink(),
                              SizedBox(
                                height: 4,
                              ),
                              Button1(
                                height: height,
                                width: width,
                                textScale: textScale,
                                text: (details == null || details == "null")
                                    ? "Claim Insurance"
                                    : "Call agent",
                                onTap: () async {
                                  if (details == null || details == "null") {
                                    await _myBox.put(
                                      "originalCar",
                                      widget.policies.carDetails!.carImg,
                                    );
                                    await _myBox.put(
                                      "pid",
                                      widget.policies.sId,
                                    );
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
                                  } else {
                                    final call =
                                        Uri.parse('tel:${details["phone"]}');
                                    if (await canLaunchUrl(call)) {
                                      launchUrl(call);
                                    } else {
                                      showSnackBar(
                                        context,
                                        "Could not launch $call",
                                        Colors.red,
                                      );
                                    }
                                  }
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
