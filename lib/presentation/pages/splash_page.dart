import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:todo_manager/data/AdsHelper/ads_helper.dart';
import 'package:todo_manager/domain/utils/app_style.dart';
import 'package:todo_manager/presentation/pages/home_page.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 5), () {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => HomePage()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: Column(
      children: [
        Expanded(
          child: RichText(
            textAlign: TextAlign.center,
            text: TextSpan(text: 'ToDo', style: mTextStyle30(), children: [
              TextSpan(
                  text: '\tManager',
                  style: mTextStyle30(
                    mFontWeight: FontWeight.bold,
                    mColor: Colors.blue,
                  ))
            ]),
          ),
        ),
       /* Align(
          alignment: Alignment.bottomCenter,
          child: SafeArea(
            child: SizedBox(
              width: AdsHelper.getBannerAd().size.width.toDouble(),
              height: AdsHelper.getBannerAd().size.height.toDouble(),
              child: AdWidget(ad: AdsHelper.getBannerAd()..load()),
            ),
          ),
        )*/
      ],
    )));
  }
}
