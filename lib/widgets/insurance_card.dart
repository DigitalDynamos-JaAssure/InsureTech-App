import 'package:flutter/material.dart';
import 'package:insuretech_ja_assure/constants.dart';

class InsuranceCard extends StatelessWidget {
  const InsuranceCard({
    super.key,
    required this.textScale,
    required this.width,
    required this.height,
    this.onTap,
    required this.assetId,
    required this.carName,
  });

  final double textScale;
  final double width;
  final double height;
  final Function()? onTap;
  final String assetId;
  final String carName;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32.0),
      child: InkWell(
        onTap: onTap,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(
                48,
              ),
            ),
          ),
          color: kPrimaryColor,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(
                  40.0,
                  32,
                  0,
                  8,
                ),
                child: Text(
                  "${carName}\nwill be\nprotected",
                  style: TextStyle(
                    fontSize: textScale * 32,
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(
                  40.0,
                  8,
                  0,
                  8,
                ),
                child: Text(
                  "Insurance is covered!",
                  style: TextStyle(
                    fontSize: textScale * 32 / 1.6,
                    color: Colors.white,
                  ),
                ),
              ),
              ClipRRect(
                child: Container(
                  width: width,
                  transform: Matrix4.translationValues(
                    width * 0.25,
                    0,
                    0,
                  ),
                  child: Hero(
                    tag: "car",
                    child: Image.asset(
                      "assets/${assetId}.png",
                      fit: BoxFit.fitHeight,
                      height: height * 0.25,
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
