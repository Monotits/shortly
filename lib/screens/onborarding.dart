import 'package:flutter/material.dart';
import 'package:shortly/constant/text_constant.dart';
import 'url_short.dart';

class Onboarding extends StatefulWidget {
  const Onboarding({Key? key}) : super(key: key);

  @override
  _OnboardingState createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  final int _numPages = 3;
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;

  List<Widget> _buildPageIndicator() {
    List<Widget> list = [];
    for (int i = 0; i < _numPages; i++) {
      list.add(i == _currentPage ? _indicator(true) : _indicator(false));
    }
    return list;
  }

  Widget _indicator(bool isActive) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 150),
      margin: EdgeInsets.symmetric(horizontal: 8.0),
      height: 8.0,
      width: isActive ? 24.0 : 16.0,
      decoration: BoxDecoration(
        color: isActive ? Colors.grey : Colors.grey.shade300,
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.grey.shade200,
      body: Container(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(
              height: 20,
            ),
            Text(
              'Shortly',
              style: welcomeTitleUp,
            ),
            SizedBox(
              height: 20,
            ),
            SizedBox(
              height: 350,
              child: PageView(
                physics: ClampingScrollPhysics(),
                controller: _pageController,
                onPageChanged: (int page) {
                  setState(() {
                    _currentPage = page;
                  });
                },
                children: [
                  onboardingCenterWidget(0),
                  onboardingCenterWidget(1),
                  onboardingCenterWidget(2),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: _buildPageIndicator(),
            ),
            TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => InputPage()),
                  );
                },
                child: Text(
                  'Skip',
                  style: onboradingButton,
                ))
          ],
        ),
      ),
    ));
  }

  Stack onboardingCenterWidget(int index) {
    return Stack(
      alignment: AlignmentDirectional.topCenter,
      children: [
        Column(
          children: [
            SizedBox(
              height: 50,
            ),
            Container(
              height: 250,
              width: 300,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30.0),
              ),
              child: Column(
                children: [
                  SizedBox(
                    height: 80,
                  ),
                  Text(
                    onboardingTitleList[index],
                    style: onboardingTitle,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0, right: 20),
                    child: Text(
                      onboardingTextList[index],
                      style: onboardingText,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        Image.asset(
          'assets/logo.png',
          height: 100,
        ),
      ],
    );
  }
}
