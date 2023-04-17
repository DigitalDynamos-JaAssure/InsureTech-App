import 'package:flutter/material.dart';
import 'package:insuretech_ja_assure/constants.dart';

class Button1 extends StatelessWidget {
  Button1({
    super.key,
    required this.height,
    required this.width,
    required this.textScale,
    this.onTap,
    required this.text,
  });

  final double height;
  final double width;
  final double textScale;
  final Function()? onTap;
  final String text;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height * 40 / 640,
      width: width * 313 / 360,
      child: FilledButton(
        onPressed: onTap,
        child: Text(
          text,
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: textScale * 17,
          ),
        ),
        style: FilledButton.styleFrom(
          backgroundColor: kPrimaryMaterialColor,
        ),
      ),
    );
  }
}
