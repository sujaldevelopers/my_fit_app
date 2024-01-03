import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:my_fit_app/audio/my_provider.dart';
import 'package:my_fit_app/chart_data/widget_recod.dart';
import 'package:provider/provider.dart';

class WeightEntryScreen extends StatefulWidget {
  @override
  State<WeightEntryScreen> createState() => _WeightEntryScreenState();
}

class _WeightEntryScreenState extends State<WeightEntryScreen> {
  late BannerAd bannerAd;
  bool isAdLoded = false;
  var adUnitId = Platform.isAndroid
      ? 'ca-app-pub-3940256099942544/6300978111'
      : 'ca-app-pub-3940256099942544/2934735716';
  void initState() {
    super.initState();
    initBannerAd();
  }

  @override
  initBannerAd() {
    bannerAd = BannerAd(
      size: AdSize.banner,
      adUnitId: adUnitId,
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          setState(() {
            isAdLoded = true;
          });
        },
        onAdFailedToLoad: (ad, error) {
          ad.dispose();
          print(error);
        },
      ),
      request: AdRequest(),
    );
    bannerAd.load();
  }
  TextEditingController _weightController =TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Weight Entry'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Container(
                decoration: BoxDecoration(border: Border.all(width: 2),borderRadius: BorderRadius.circular(12)),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    maxLength: 2,
                    controller: _weightController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(labelText: 'Weight (kg)'),
                  ),
                ),
              ),
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.only(bottom: 50),
              child: ElevatedButton(
                onPressed: () {
                  final weight = double.tryParse(_weightController.text);
                  if (weight != null) {
                    Provider.of<AudioProvider>(context, listen: false).addRecord(
                      WeightRecord(date: DateTime.now(), weight: weight),
                    );
                    Navigator.pop(context);
                  }
                  Fluttertoast.showToast(msg: "Add Data");
                },
                child: Text('Save'),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: isAdLoded?SizedBox(
        height: bannerAd.size.height.toDouble(),
        width: bannerAd.size.width.toDouble(),
        child: AdWidget(ad: bannerAd),
      ):SizedBox(),
    );
  }
}
