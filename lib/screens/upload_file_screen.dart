import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:http_parser/http_parser.dart';
import 'package:insuretech_ja_assure/constants.dart';
import 'package:insuretech_ja_assure/screens/loading_screen.dart';
import 'package:insuretech_ja_assure/screens/risk_screen.dart';
import 'package:insuretech_ja_assure/screens/show_car_damage_screen.dart';
import 'package:insuretech_ja_assure/screens/verification_screen.dart';
import 'package:insuretech_ja_assure/widgets/show_snack_bar.dart';
import 'package:mime_type/mime_type.dart';
import 'package:page_transition/page_transition.dart';

class UploadFile extends StatefulWidget {
  final String typeOfDocument;
  final String title;
  final String type;
  const UploadFile(
      {Key? key,
      required this.type,
      required this.title,
      required this.typeOfDocument})
      : super(key: key);

  @override
  State<UploadFile> createState() => _UploadFileState();
}

class _UploadFileState extends State<UploadFile> {
  var _myBox = Hive.box("myBox");
  bool loading = false;
  File? file;
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
                        widget.title,
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
                        'Upload your ${widget.typeOfDocument} for further verification',
                        style: GoogleFonts.montserrat(
                            color: Colors.black,
                            fontSize: 16 * textScale,
                            fontWeight: FontWeight.w400),
                        textAlign: TextAlign.start,
                      ),
                      SizedBox(
                        height: height * 80 / 892,
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: InkWell(
                          onTap: () async {
                            FilePickerResult? result =
                                await FilePicker.platform.pickFiles();

                            if (result != null) {
                              file = File(result.files.single.path!);
                              setState(() {});
                            } else {
                              showSnackBar(
                                context,
                                "Unable to get file, user cancelled!",
                                Colors.red.shade700,
                              );
                            }
                          },
                          child: Container(
                            height: height * 220 / 892,
                            width: width * 220 / 412,
                            decoration: BoxDecoration(
                              border: Border.all(color: kPrimaryColor),
                              borderRadius: BorderRadius.circular(16),
                              color: kPrimaryColor.withOpacity(0.1),
                            ),
                            child: (file != null)
                                ? (widget.type == "car")
                                    ? ClipRRect(
                                        borderRadius: BorderRadius.circular(
                                          16,
                                        ),
                                        child: Image.file(
                                          file!,
                                          fit: BoxFit.cover,
                                        ),
                                      )
                                    : Center(
                                        child: Text(
                                          file!.path.toString().split('/')[file!
                                                  .path
                                                  .toString()
                                                  .split('/')
                                                  .length -
                                              1],
                                          textAlign: TextAlign.center,
                                        ),
                                      )
                                : Icon(
                                    CupertinoIcons.arrow_up_doc,
                                    size: 64,
                                    color: kPrimaryMaterialColor.shade800,
                                  ),
                          ),
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
                          onPressed: () async {
                            setState(() {
                              loading = true;
                            });
                            var type = widget.type;
                            if (file == null) {
                              showSnackBar(
                                context,
                                "Please add a file",
                                Colors.red,
                              );

                              setState(() {
                                loading = false;
                              });
                              return;
                            }
                            if (type == 'cc') {
                              await Future.delayed(
                                Duration(
                                  seconds: 6,
                                ),
                              );
                              Navigator.push(
                                context,
                                PageTransition(
                                  child: ShowCarDamageScreen(),
                                  type: PageTransitionType.fade,
                                ),
                              );
                            } else if (type == 'bb') {
                              final bytes = await file!.readAsBytes();

                              String file64 = base64Encode(bytes);
                              await _myBox.put("bbpdf", file64);
                              Navigator.push(
                                context,
                                PageTransition(
                                  child: UploadFile(
                                    type: 'cc',
                                    title: 'Damaged Car Picture Upload',
                                    typeOfDocument: 'damaged car picture',
                                  ),
                                  type: PageTransitionType.fade,
                                ),
                              );
                            } else if (type == 'frc') {
                              String fileName = file!.path
                                      .toString()
                                      .split('/')[
                                  file!.path.toString().split('/').length - 1];
                              String mimeType = mime(fileName)!;
                              String mimee = mimeType.split('/')[0];
                              String type = mimeType.split('/')[1];
                              FormData formData = new FormData.fromMap(
                                {
                                  'document': await MultipartFile.fromFile(
                                    file!.path,
                                    filename: fileName,
                                    contentType: MediaType(mimee, type),
                                  )
                                },
                              );
                              var response = await Dio().post(
                                "https://api.mindee.net/v1/products/Utkarsh3012/rc_front/v1/predict",
                                data: formData,
                                options: Options(
                                  headers: {
                                    "Authorization":
                                        "b99503ae6741c730db66da45e7bb2767"
                                  },
                                ),
                              );
                              Map<String, dynamic> data = {
                                "chesis_no": response.data["document"]
                                        ["inference"]["prediction"]
                                    ["chassis_no"]["values"][0]["content"],
                                "Engion_No": response.data["document"]
                                        ["inference"]["prediction"]
                                    ["engine_number"]["values"][0]["content"],
                                "year": (response.data["document"]["inference"]
                                            ["prediction"]["registration_date"]
                                        ["values"][0]["content"] as String)
                                    .split("-")[0],
                              };
                              await _myBox.put('frc', data);
                              Navigator.push(
                                context,
                                PageTransition(
                                  child: UploadFile(
                                    type: "brc",
                                    typeOfDocument: "back of RC card",
                                    title: "Back of RC Card",
                                  ),
                                  type: PageTransitionType.fade,
                                ),
                              );
                            } else if (type == 'brc') {
                              String fileName = file!.path
                                      .toString()
                                      .split('/')[
                                  file!.path.toString().split('/').length - 1];
                              String mimeType = mime(fileName)!;
                              String mimee = mimeType.split('/')[0];
                              String type = mimeType.split('/')[1];
                              FormData formData = new FormData.fromMap(
                                {
                                  'document': await MultipartFile.fromFile(
                                    file!.path,
                                    filename: fileName,
                                    contentType: MediaType(mimee, type),
                                  )
                                },
                              );
                              var response = await Dio().post(
                                "https://api.mindee.net/v1/products/Utkarsh3012/r_c_back/v1/predict",
                                data: formData,
                                options: Options(
                                  headers: {
                                    "Authorization":
                                        "b99503ae6741c730db66da45e7bb2767"
                                  },
                                ),
                              );
                              Map<String, dynamic> data = {
                                "Color": response.data["document"]["inference"]
                                        ["prediction"]["color"]["values"][0]
                                    ["content"],
                                "model": response.data["document"]["inference"]
                                        ["prediction"]["company"]["values"][0]
                                    ["content"],
                              };
                              // print(data);
                              await _myBox.put('brc', data);

                              Navigator.push(
                                context,
                                PageTransition(
                                  child: UploadFile(
                                    type: "car",
                                    typeOfDocument: "car's current photo",
                                    title: "Car's current photo",
                                  ),
                                  type: PageTransitionType.fade,
                                ),
                              );
                            } else if (type == 'car') {
                              final bytes = await file!.readAsBytes();
                              String base64Image = "data:image/png;base64," +
                                  base64Encode(bytes);
                              Map<String, dynamic> data = {"car": base64Image};
                              await _myBox.put("car", data);
                              Navigator.push(
                                context,
                                PageTransition(
                                  child: UploadFile(
                                    type: "cbill",
                                    typeOfDocument: "car's purchase bill",
                                    title: "Car's purchase bill",
                                  ),
                                  type: PageTransitionType.fade,
                                ),
                              );
                            } else if (type == "cbill") {
                              final bytes = await file!.readAsBytes();
                              String base64Image = "data:image/png;base64," +
                                  base64Encode(bytes);
                              Map<String, dynamic> data = {"car": base64Image};
                              await _myBox.put("cbill", data);
                              await Future.delayed(
                                Duration(
                                  seconds: 3,
                                ),
                              );
                              Navigator.push(
                                context,
                                PageTransition(
                                  child: RiskScreen(),
                                  type: PageTransitionType.fade,
                                ),
                              );
                            }

                            setState(() {
                              loading = false;
                            });
                          },
                          child: Icon(
                            Icons.arrow_forward,
                            color: Colors.white,
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
