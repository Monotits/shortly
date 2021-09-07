import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shortly/constant/app_constant.dart';
import 'package:shortly/constant/text_constant.dart';

import 'onborarding.dart';

class WelcomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey.shade200,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            titleTopWidget(),
            svgWidget(),
            centerText(),
            buttonWidget(context),
          ],
        ),
      ),
    );
  }

  Column titleTopWidget() {
    return Column(
      children: [
        SizedBox(
          height: 10,
        ),
        Text(
          'Shortly',
          style: welcomeTitleUp,
        ),
      ],
    );
  }

  Row svgWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        SizedBox(),
        SizedBox(
          height: 280,
          child: SvgPicture.asset(
            svgAssetsPath[1],
            alignment: Alignment.centerRight,
            width: 375,
            height: 324,
          ),
        ),
      ],
    );
  }

  Column centerText() {
    return Column(
      children: [
        Text(
          'More then just\nshorter links',
          style: welcomeTitleCenter,
          textAlign: TextAlign.center,
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          'Build your brand\'s recognition and get detailed\ninsights on how links are performing',
          style: welcomeTextDown,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Padding buttonWidget(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15.0, right: 15, top: 5, bottom: 5),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                primary: Color(0xff2BD0D0),
                textStyle: TextStyle(fontWeight: FontWeight.bold)),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Onboarding()),
              );
            },
            child: Text(
              'START',
              style: welcomeButton,
            )),
      ),
    );
  }
}
