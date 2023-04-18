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
import 'package:insuretech_ja_assure/screens/home_screen.dart';
import 'package:insuretech_ja_assure/screens/loading_screen.dart';
import 'package:insuretech_ja_assure/screens/risk_screen.dart';
import 'package:insuretech_ja_assure/screens/verification_screen.dart';
import 'package:insuretech_ja_assure/services/api_calls.dart';
import 'package:insuretech_ja_assure/widgets/show_snack_bar.dart';
import 'package:mime_type/mime_type.dart';
import 'package:page_transition/page_transition.dart';

class ShowPipeDamage extends StatefulWidget {
  const ShowPipeDamage({
    Key? key,
  }) : super(key: key);

  @override
  State<ShowPipeDamage> createState() => _ShowPipeDamageState();
}

class _ShowPipeDamageState extends State<ShowPipeDamage> {
  var _myBox = Hive.box("myBox");
  File? file;
  String? fileGet;
  bool loading = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
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
                    top: 0,
                    right: 32,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        (file == null)
                            ? "Detect pipe damage"
                            : "Damage detected",
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
                        (file != null)
                            ? 'This is the damage detected'
                            : "Add file to detect damage",
                        style: GoogleFonts.montserrat(
                            color: Colors.black,
                            fontSize: 16 * textScale,
                            fontWeight: FontWeight.w400),
                        textAlign: TextAlign.start,
                      ),
                      SizedBox(
                        height: height * 10 / 892,
                      ),
                      (file != null)
                          ? Align(
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
                                  child: Image.file(
                                    file!,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            )
                          : SizedBox.shrink(),
                      SizedBox(
                        height: height * 10 / 892,
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: InkWell(
                          onTap: () async {
                            FilePickerResult? result =
                                await FilePicker.platform.pickFiles();

                            if (result != null) {
                              file = File(result.files.single.path!);
                              loading = true;
                              setState(() {});
                              //call api
                              String fileName = file!.path
                                      .toString()
                                      .split('/')[
                                  file!.path.toString().split('/').length - 1];
                              String mimeType = mime(fileName)!;
                              String mimee = mimeType.split('/')[0];
                              String type = mimeType.split('/')[1];
                              FormData formData = new FormData.fromMap(
                                {
                                  'image': await MultipartFile.fromFile(
                                    file!.path,
                                    filename: fileName,
                                    contentType: MediaType(mimee, type),
                                  )
                                },
                              );
                              var response = await Dio().post(
                                "https://insure-tech-flask-production.up.railway.app/predict",
                                data: formData,
                              );
                              fileGet = response.data;
                              setState(() {
                                loading = false;
                              });
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
                            width: width * 280 / 412,
                            decoration: BoxDecoration(
                              border: Border.all(color: kPrimaryColor),
                              borderRadius: BorderRadius.circular(16),
                              color: kPrimaryColor.withOpacity(0.1),
                            ),
                            child: (fileGet != null)
                                ? ClipRRect(
                                    borderRadius: BorderRadius.circular(
                                      16,
                                    ),
                                    child: Image.memory(
                                      base64Decode(fileGet!),
                                      fit: BoxFit.cover,
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
                        height: height * 10 / 892,
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
