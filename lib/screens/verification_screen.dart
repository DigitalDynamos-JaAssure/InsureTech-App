import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class UnderProcessPage extends StatefulWidget {
  const UnderProcessPage({super.key});

  @override
  State<UnderProcessPage> createState() => _UnderProcessPageState();
}

class _UnderProcessPageState extends State<UnderProcessPage> {
  // var _myBox = Hive.box("hoursBox");
  var response;
  // callApi() async {
  //   var uid = await _myBox.get(kUid);
  //   while (true) {
  //     print("ds");
  //     await Future.delayed(Duration(seconds: 5));
  //     try {
  //       response = await MediaService().get('/user/${uid}');
  //     } catch (e) {
  //       print(e);
  //     }
  //     print((response)[0]);
  //     if (response.runtimeType == List && (response)[0]["idVerified"] == true) {
  //       Navigator.push(
  //         context,
  //         MaterialPageRoute(
  //           builder: (builder) => HomePage(
  //             response: response[0],
  //           ),
  //         ),
  //       );
  //       break;
  //     }
  //   }
  // }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // callApi();
  }

  @override
  Widget build(BuildContext context) {
    double textscale = MediaQuery.of(context).textScaleFactor;
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: height,
            width: width,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/onlyjalogo.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            width: width,
            height: height,
            color: Colors.black.withOpacity(0.7),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: height * 220 / 640),
                Text(
                  'Verification\nunder process',
                  style: GoogleFonts.montserrat(
                      color: Colors.white,
                      fontSize: 26 * textscale,
                      fontWeight: FontWeight.w600),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20),
                Text(
                  "This may take a while, we're verifying \nyour details",
                  style: GoogleFonts.montserrat(
                      color: Colors.white,
                      fontSize: 16 * textscale,
                      fontWeight: FontWeight.w400),
                  textAlign: TextAlign.center,
                  maxLines: 2,
                ),
                Spacer(),
                LoadingAnimationWidget.staggeredDotsWave(
                    color: Colors.white, size: 35),
                SizedBox(height: height * 150 / 640),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
