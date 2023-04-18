import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:http_parser/http_parser.dart';
import 'package:insuretech_ja_assure/constants.dart';
import 'package:insuretech_ja_assure/screens/home_screen.dart';
import 'package:insuretech_ja_assure/screens/loading_screen.dart';
import 'package:insuretech_ja_assure/screens/risk_screen.dart';
import 'package:insuretech_ja_assure/screens/verification_screen.dart';
import 'package:insuretech_ja_assure/services/api_calls.dart';
import 'package:insuretech_ja_assure/widgets/show_snack_bar.dart';
import 'package:mime_type/mime_type.dart';
import 'package:page_transition/page_transition.dart';

class ShowCarDamageScreen extends StatefulWidget {
  const ShowCarDamageScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<ShowCarDamageScreen> createState() => _ShowCarDamageScreenState();
}

class _ShowCarDamageScreenState extends State<ShowCarDamageScreen> {
  var _myBox = Hive.box("myBox");
  bool loading = false;
  late String file;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    file = _myBox.get("originalCar").toString().split(',')[1];
  }

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
                top: false,
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 32.0,
                    top: 64,
                    right: 32,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Damage detected",
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
                        'This is the damage detected',
                        style: GoogleFonts.montserrat(
                            color: Colors.black,
                            fontSize: 16 * textScale,
                            fontWeight: FontWeight.w400),
                        textAlign: TextAlign.start,
                      ),
                      SizedBox(
                        height: height * 10 / 892,
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Container(
                          height: height * 220 / 892,
                          width: width * 280 / 412,
                          decoration: BoxDecoration(
                            border: Border.all(color: kPrimaryColor),
                            borderRadius: BorderRadius.circular(16),
                            color: kPrimaryColor.withOpacity(0.1),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(
                              16,
                            ),
                            child: Image.memory(
                              base64Decode(
                                file,
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: height * 10 / 892,
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Container(
                          height: height * 220 / 892,
                          width: width * 280 / 412,
                          decoration: BoxDecoration(
                            border: Border.all(color: kPrimaryColor),
                            borderRadius: BorderRadius.circular(16),
                            color: kPrimaryColor.withOpacity(0.1),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(
                              16,
                            ),
                            child: Image.asset(
                              "assets/final.png",
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: height * 10 / 892,
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
                          onPressed: () async {
                            setState(() {
                              loading = true;
                            });
                            var pid = await _myBox.get("pid");

                            var bpdf = await _myBox.get("bbpdf");
                            List<int> bytesp = base64Decode(bpdf);

                            // Save bytes to a temporary file with .pdf extension
                            // File tempPdf = File('temp.pdf');
                            // await tempPdf.writeAsBytes(bytesp);
                            ByteData bytes =
                                await rootBundle.load('assets/final.png');
                            var buffer = bytes.buffer;
                            var m = base64.encode(Uint8List.view(buffer));
                            print(pid);
                            try {
                              var response = await Dio().post(
                                'https://jaassure-backend.up.railway.app/claim/claimAdd/643e290bc106c626d12f6c17/${pid}',
                                data: {
                                  "object": {
                                    "damages": {"crash%": 83},
                                    'img': "image.png"
                                  }
                                },
                              );
                              print(response.data["claimId"]);
                              await _myBox.put(
                                pid + "claimid",
                                response.data["claimId"],
                              );
                            } catch (e) {
                              print(e.toString());
                              showSnackBar(
                                  context, "Something went wrong!", Colors.red);
                              setState(() {
                                loading = false;
                              });
                              return;
                            }

                            await _myBox.put(pid, "processing");
                            setState(() {
                              loading = false;
                            });
                            Navigator.pushAndRemoveUntil(
                              context,
                              PageTransition(
                                child: HomeScreen(),
                                type: PageTransitionType.fade,
                              ),
                              (route) => false,
                            );
                            Navigator.push(
                              context,
                              PageTransition(
                                child: UnderProcessPage(
                                  pid: pid,
                                ),
                                type: PageTransitionType.fade,
                              ),
                            );
                          },
                          child: Text(
                            "OK",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
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
