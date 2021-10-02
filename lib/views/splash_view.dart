import 'dart:math';

import 'package:develove/views/login_view.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  final List<Widget> _pages = [
    SplashPage1(),
    SplashPage2(),
    SplashPage3(),
    SplashPage4(),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
            colors: [Color(0xFF313131), Color(0xFF282828)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight),
      ),
      child: Scaffold(
        body: SafeArea(
            child: Column(
          children: [
            Expanded(
              child: PageView(
                physics: BouncingScrollPhysics(),
                pageSnapping: true,
                onPageChanged: (index) {
                  setState(() {
                    _currentPage = index;
                  });
                },
                controller: _pageController,
                children: _pages,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  DotsIndicator(
                    controller: _pageController,
                    itemCount: _pages.length,
                    onPageSelected: (index) {},
                    color: Color(0xFF57AF70),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _currentPage == 0
                          ? TextButton(
                              onPressed: () {
                                Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => LoginView()),
                                    (route) => false);
                              },
                              child: Text(
                                "Skip",
                                style: Theme.of(context).textTheme.subtitle1,
                              ))
                          : TextButton(
                              onPressed: () {
                                _pageController.previousPage(
                                    duration: Duration(milliseconds: 250),
                                    curve: Curves.easeIn);
                              },
                              child: Text(
                                "Back",
                                style: Theme.of(context).textTheme.subtitle1,
                              )),
                      _currentPage == _pages.length - 1
                          ? TextButton(
                              onPressed: () {
                                Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => LoginView()),
                                    (route) => false);
                              },
                              child: Text(
                                "Done",
                                style: Theme.of(context).textTheme.subtitle1,
                              ))
                          : TextButton(
                              onPressed: () {
                                _pageController.nextPage(
                                    duration: Duration(milliseconds: 250),
                                    curve: Curves.easeIn);
                              },
                              child: Text(
                                "Next",
                                style: Theme.of(context).textTheme.subtitle1,
                              )),
                    ],
                  ),
                ],
              ),
            )
          ],
        )),
      ),
    );
  }
}

class SplashPage1 extends StatelessWidget {
  const SplashPage1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.1),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 240,
            child: Image.asset(
              'assets/images/HeartMap.png',
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(height: 30),
          Text(
            "Welcome to Develove",
            style: Theme.of(context).textTheme.headline4,
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            maxLines: 3,
          ),
        ],
      ),
    );
  }
}

class SplashPage2 extends StatelessWidget {
  const SplashPage2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.1),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 240,
            child: Image.asset(
              'assets/images/Earth.png',
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(height: 30),
          Text(
            "Here in Develove, you can meet and hangout with developers from all around the world ",
            style: Theme.of(context)
                .textTheme
                .headline4
                ?.apply(fontSizeDelta: -10),
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            maxLines: 5,
          ),
        ],
      ),
    );
  }
}

class SplashPage3 extends StatelessWidget {
  const SplashPage3({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.1),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 240,
            child: Image.asset(
              'assets/images/Search.png',
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(height: 30),
          Text(
            "Search them up using the interactive map, or shoot them a DM. You might get lucky!",
            style: Theme.of(context)
                .textTheme
                .headline4
                ?.apply(fontSizeDelta: -10),
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            maxLines: 5,
          ),
        ],
      ),
    );
  }
}

class SplashPage4 extends StatelessWidget {
  const SplashPage4({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.1),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 240,
            child: Image.asset(
              'assets/images/Group.png',
              fit: BoxFit.fitWidth,
            ),
          ),
          SizedBox(height: 30),
          Text(
            "Meet people tailored to your interests, build hype, and new friends using Develove.",
            style: Theme.of(context)
                .textTheme
                .headline4
                ?.apply(fontSizeDelta: -10),
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            maxLines: 5,
          ),
        ],
      ),
    );
  }
}

class DotsIndicator extends AnimatedWidget {
  DotsIndicator({
    required this.controller,
    required this.itemCount,
    required this.onPageSelected,
    this.color: Colors.white,
  }) : super(listenable: controller);

  final PageController controller;
  final int itemCount;
  final ValueChanged<int> onPageSelected;
  final Color color;
  static const double _kDotSize = 8.0;
  static const double _kMaxZoom = 2.0;
  static const double _kDotSpacing = 25.0;

  Widget _buildDot(int index) {
    double selectedness = Curves.easeOut.transform(
      max(
        0.0,
        1.0 - ((controller.page ?? controller.initialPage) - index).abs(),
      ),
    );
    double zoom = 1.0 + (_kMaxZoom - 1.0) * selectedness;
    return new Container(
      width: _kDotSpacing,
      child: new Center(
        child: new Material(
          color: color,
          type: MaterialType.circle,
          child: new Container(
            width: _kDotSize * zoom,
            height: _kDotSize * zoom,
            child: new InkWell(
              onTap: () => onPageSelected(index),
            ),
          ),
        ),
      ),
    );
  }

  Widget build(BuildContext context) {
    return new Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: new List<Widget>.generate(itemCount, _buildDot),
    );
  }
}
