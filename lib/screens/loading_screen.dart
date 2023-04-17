import 'package:flutter/material.dart';
import 'package:insuretech_ja_assure/constants.dart';

class LoadingPage extends StatefulWidget {
  const LoadingPage({super.key});

  @override
  State<LoadingPage> createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Container(
      color: Colors.white,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: height * 80 / 640),
            SizedBox(
              height: height * 180 / 640,
              width: width * 180 / 360,
              child: Image.asset("assets/jalogo-grey.png"),
            ),
            SizedBox(height: height * 180 / 640),
            const CircularProgressIndicator(
              color: kPrimaryColor,
            ),
          ],
        ),
      ),
    );
  }
}
