import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:insuretech_ja_assure/constants.dart';
import 'package:insuretech_ja_assure/screens/details_screen.dart';
import 'package:insuretech_ja_assure/widgets/insurance_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var height = size.height;
    var width = size.width;
    var textScale = MediaQuery.of(context).textScaleFactor;

    AppBar appBar = AppBar(
      leading: IconButton(
        icon: const Icon(
          Icons.grid_view,
        ),
        onPressed: () {},
      ),
      actions: [
        IconButton(
          icon: const Icon(
            Icons.notifications_outlined,
          ),
          onPressed: () {},
        ),
        IconButton(
          icon: const Icon(
            Icons.account_circle_outlined,
          ),
          onPressed: () {},
        ),
      ],
      centerTitle: true,
      title: Text(
        "InsureTech",
        style: GoogleFonts.montserrat(
          fontWeight: FontWeight.w600,
        ),
      ),
    );
    return Scaffold(
      appBar: appBar,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: ClipOval(
        child: FloatingActionButton(
          backgroundColor: kPrimaryColor,
          onPressed: () {},
          child: Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
      ),
      bottomNavigationBar: AnimatedBottomNavigationBar(
        leftCornerRadius: 15,
        rightCornerRadius: 15,
        inactiveColor: Colors.grey,
        gapLocation: GapLocation.center,
        backgroundColor: Colors.white,
        icons: [
          Icons.home,
          Icons.bar_chart_outlined,
          Icons.history,
          Icons.account_circle_outlined,
        ],
        activeIndex: 0,
        onTap: (int) {},
      ),
      body: SizedBox(
        height: height - appBar.preferredSize.height,
        width: width,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              CarouselSlider(
                items: [
                  InsuranceCard(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (builder) => DetailsScreen(),
                        ),
                      );
                    },
                    textScale: textScale,
                    width: width,
                    height: height,
                  ),
                  InsuranceCard(
                    textScale: textScale,
                    width: width,
                    height: height,
                  ),
                  InsuranceCard(
                    textScale: textScale,
                    width: width,
                    height: height,
                  ),
                ],
                options: CarouselOptions(
                  enlargeStrategy: CenterPageEnlargeStrategy.zoom,
                  enableInfiniteScroll: false,
                  enlargeCenterPage: true,
                  height: height * 0.55,
                  viewportFraction: 1.1,
                  pageViewKey: const PageStorageKey<String>('carousel_slider'),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              ...List.generate(
                1,
                (index) => Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 4,
                  ),
                  child: Container(
                    height: height * 0.12,
                    width: width,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(
                        16,
                      ),
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 8,
                          color: kPrimaryMaterialColor.shade100,
                          offset: const Offset(
                            3,
                            3,
                          ),
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Land Cruiser",
                                style: TextStyle(
                                  fontSize: textScale * 24,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                "Insured",
                                style: TextStyle(
                                  color: Colors.green.shade700,
                                ),
                              ),
                            ],
                          ),
                          ClipRect(
                            child: Container(
                              transform: Matrix4.translationValues(
                                50,
                                0,
                                0,
                              ),
                              child: Image.asset(
                                "assets/landcruiser.png",
                              ),
                            ),
                          ),
                        ],
                      ),
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
