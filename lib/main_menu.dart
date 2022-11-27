import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:google_fonts/google_fonts.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'models/models.dart';
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';

class MainMenu extends StatefulWidget {
  const MainMenu({Key? key}) : super(key: key);

  @override
  State<MainMenu> createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> {
  late PageController _pageController;
  int _currentPage = 1;
  final backgroundColor = const Color(0xFFE7ECEF);
  late Offset distanceMenu = Offset(4, 4);
  late double blurMenu = 6.0;
  Offset distanceImage = Offset(1, 1);
  double blurImage = 1.0;

  _onChanged(int index) {
    _currentPage = index;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();

    _pageController = PageController(
        initialPage: _currentPage, viewportFraction: 0.75, keepPage: true);
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 0.02,
                bottom: MediaQuery.of(context).size.height * 0.02),
            child: Center(
              child: Text(
                'Silahkan memilih kebutuhan Anda',
                maxLines: 3,
                textAlign: TextAlign.center,
                style: GoogleFonts.montserrat(
                  fontSize: 12,
                  color: Color(0xff403F3F),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          AspectRatio(
            aspectRatio: 0.85,
            child: PageView.builder(
              itemCount: menuList.length,
              physics: const ClampingScrollPhysics(),
              controller: _pageController,
              scrollDirection: Axis.horizontal,
              onPageChanged: _onChanged,
              itemBuilder: (context, index) {
                return carouselView(index);
              },
            ),
          ),

          ///PAGE INDICATOR

          Container(
            height: 50,
            child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: menuList.length,
                itemBuilder: (context, index) {
                  return _createIndicatorElements(index);
                }),
          ),
        ],
      ),
    );
  }

  Widget carouselView(int index) {
    return AnimatedBuilder(
      animation: _pageController,
      builder: (context, child) {
        double value = 0.0;
        const double pi = 3.1415926535897932;
        if (_pageController.position.haveDimensions) {
          value = index.toDouble() - (_pageController.page ?? 0);
          value = (value * 0.02).clamp(-1, 1);
        }
        return Transform.rotate(
          angle: pi * value,
          child: carouselCard(menuList[index]),
        );
      },
    );
  }

  Widget carouselCard(MenuModel data) {
    return Column(
      children: [
        Expanded(
          child: Padding(
            padding: EdgeInsets.only(
                left: MediaQuery.of(context).size.width * 0.015,
                right: MediaQuery.of(context).size.width * 0.015,
                top: MediaQuery.of(context).size.height * 0.02,
                bottom: MediaQuery.of(context).size.height * 0.05),
            child: GestureDetector(
              onTap: () {
                setState(() {});
              },
              child: Container(
                width: MediaQuery.of(context).size.width * 0.65,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Color(0xffD7D8DC),
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 8.0,
                        spreadRadius: 0.05,
                        offset: Offset(-1, -1),
                        color: Colors.white,
                      ),
                      BoxShadow(
                        blurRadius: 10.0,
                        offset: Offset(10, 10),
                        color: Color(0xFFA7A9AF),
                      )
                    ]),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.02,
                        left: MediaQuery.of(context).size.width * 0.02,
                        right: MediaQuery.of(context).size.width * 0.02,
                      ),
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.3,
                        width: MediaQuery.of(context).size.height * 0.35,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: Color(0xffD9D9D9),
                            boxShadow: [
                              BoxShadow(
                                  blurRadius: blurImage,
                                  offset: -distanceImage,
                                  color: Colors.white,
                                  inset: true),
                              BoxShadow(
                                  blurRadius: blurImage,
                                  offset: distanceImage,
                                  color: Color(0xFFA7A9AF),
                                  inset: true)
                            ]),
                        child: Padding(
                          padding: EdgeInsets.all(
                              MediaQuery.of(context).size.height * 0.08),
                          child: Image.asset(
                            data.imageName,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.03,
                        left: MediaQuery.of(context).size.width * 0.05,
                        right: MediaQuery.of(context).size.width * 0.05,
                      ),
                      child: Text(
                        data.title,
                        textAlign: TextAlign.center,
                        style: GoogleFonts.montserrat(
                          fontWeight: FontWeight.w600,
                          fontSize: 20,
                          color: Color(0xff000000),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.015,
                        left: MediaQuery.of(context).size.width * 0.05,
                        right: MediaQuery.of(context).size.width * 0.05,
                      ),
                      child: Text(
                        data.description,
                        textAlign: TextAlign.justify,
                        style: GoogleFonts.montserrat(
                          fontWeight: FontWeight.normal,
                          fontSize: 12,
                          color: Color(0xff000000),
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
    );
  }

  Widget _createIndicatorElements(index) {
    double w = MediaQuery.of(context).size.height * 0.02;
    double h = MediaQuery.of(context).size.height * 0.02;

    BoxDecoration boxDecoration = BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: Color(0xffD9D9D9),
        boxShadow: [
          BoxShadow(
              blurRadius: 2,
              offset: Offset(-1, -1),
              color: Colors.white,
              inset: true),
          BoxShadow(
              blurRadius: 2,
              offset: Offset(1, 1),
              color: Color(0xFFA7A9AF),
              inset: true)
        ]);

    if (_currentPage == index) {
      w = MediaQuery.of(context).size.height * 0.08;

      boxDecoration = BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: Color(0xffD7D8DC),
          boxShadow: [
            BoxShadow(
              blurRadius: 2,
              spreadRadius: 0.05,
              offset: Offset(-1, -1),
              color: Colors.white,
            ),
            BoxShadow(
              blurRadius: 1.0,
              offset: Offset(1, 1),
              color: Color(0xFFA7A9AF),
            )
          ]);
    }

    return Center(
      child: AnimatedContainer(
          duration: Duration(milliseconds: 100),
          margin: EdgeInsets.all(5),
          width: w,
          height: h,
          decoration: boxDecoration),
    );
  }
}
