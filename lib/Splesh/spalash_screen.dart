import 'dart:async';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:my_fit_app/Helper/My_color.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../First_home.dart';
import '../audio/my_provider.dart';
import '../chart_data/widget_recod.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

SharedPreferences? sharedPrefs;
dynamic font = '';

share(BuildContext context) async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  final result = pref.getString('font');
  context.read<AudioProvider>().changeFont(result!);
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  initState() {
    super.initState();
    Timer(
      Duration(seconds: 3),
          () => Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => FirstList(),
        ),
      ),
    );
     share(context);
  }

  @override
  Widget build(BuildContext context) {
    share(context);
    return Scaffold(
      body: SizedBox(
        width: double.maxFinite,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Container(
                height: 120,
                width: 120,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.asset(
                    'assert/video/splesh.gif',
                  ),
                ),
              ),
            ),
            Text(
              "Strong Body, Strong Mind",
              style: TextStyle(
                fontSize: 25,
                color: CustomColor.fontcolor,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              "Welcome To Our Service",
              style: TextStyle(
                fontSize: 20,
                color: CustomColor.fontcolor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
//#0E2954
// #1F6E8C
// #2E8A99
// #84A7A1
