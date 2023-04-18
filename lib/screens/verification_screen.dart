import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:insuretech_ja_assure/data/policies_data.dart';
import 'package:insuretech_ja_assure/screens/details_screen.dart';
import 'package:insuretech_ja_assure/services/api_calls.dart';
import 'package:insuretech_ja_assure/services/media_service.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:page_transition/page_transition.dart';

class UnderProcessPage extends StatefulWidget {
  final String? pid;
  const UnderProcessPage({super.key, this.pid});

  @override
  State<UnderProcessPage> createState() => _UnderProcessPageState();
}

class _UnderProcessPageState extends State<UnderProcessPage> {
  var _myBox = Hive.box("myBox");
  var response;
  callApi() async {
    var uid = await _myBox.get(widget.pid.toString() + "claimid");
    print(uid);
    while (true) {
      print("SLKDFJasdfasdfasd");
      await Future.delayed(Duration(seconds: 5));
      try {
        response = await MediaService().get('/claim/getAcceptedClaim/${uid}');
        print("YE");
      } catch (e) {
        print("SDJFHLJSKDF");
        print(e);
      }
      print((response));
      if (!((response as Map).keys.contains("message"))) {
        _myBox.put(widget.pid, "processed");
        _myBox.put(widget.pid! + "details", response);
        PolicyDetails res = await APICalls(context).getAllPolicies();
        for (Policies i in res.policies!) {
          if (i.sId == widget.pid) {
            Navigator.pushReplacement(
              context,
              PageTransition(
                child: DetailsScreen(
                  policies: i,
                ),
                type: PageTransitionType.fade,
              ),
            );
            break;
          }
        }
        break;
      }
    }
  }

  @override
  void initState() {
    super.initState();
    if (widget.pid != null) {
      callApi();
    }
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
