import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:my_fit_app/audio/my_provider.dart';
import 'package:my_fit_app/chart_data/widget_recod.dart';
import 'package:provider/provider.dart';
import '../Helper/My_color.dart';

class WeightChart extends StatefulWidget {
  @override
  State<WeightChart> createState() => _WeightChartState();
}

class _WeightChartState extends State<WeightChart> {
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
  List<WeightRecord> _records = [];

  List<WeightRecord> get records => _records;

  @override
  Widget build(BuildContext context) {
    final weightRecords = Provider.of<AudioProvider>(context).records;
    final fontProvider = Provider.of<AudioProvider>(context);
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Container(
              decoration: BoxDecoration(
                color: CustomColor.bmi,
                borderRadius: BorderRadius.circular(20.0),
              ),
              height: 150,
              width: double.maxFinite,
              padding: EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Text("Current Wight",
                      style: TextStyle(
                        fontSize: 20.0,
                        fontFamily: fontProvider.selectedFonts,
                      )),
                  Center(
                    child: Text(
                      "${getSpots(weightRecords).last.y}",
                      style: TextStyle(
                        fontSize: 26.0,
                        fontFamily: fontProvider.selectedFonts,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 50,
          ),
          SizedBox(
            height: 450,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.black.withOpacity(0.2),
                ),
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Padding(
                  padding: const EdgeInsets.only(right: 20, bottom: 10),
                  child: LineChart(
                    LineChartData(
                      titlesData: FlTitlesData(
                          topTitles: AxisTitles(drawBelowEverything: false),
                          rightTitles: AxisTitles(drawBelowEverything: false)),
                      borderData: FlBorderData(
                        show: true,
                        border: Border.all(
                            color: const Color(0xff37434d), width: 1),
                      ),
                      minX: 0,
                      maxX: weightRecords.length - 1.0,
                      minY: 0,
                      maxY: _calculateMaxY(weightRecords),
                      lineBarsData: [
                        LineChartBarData(
                          spots: getSpots(weightRecords),
                          isCurved: true,
                          barWidth: 1,
                          color: Colors.blue.shade900,
                          shadow: Shadow(color: Colors.black.withOpacity(0.6),blurRadius: 1.5),
                          belowBarData: BarAreaData(show: false),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
           isAdLoded?SizedBox(
            height: bannerAd.size.height.toDouble(),
            width: bannerAd.size.width.toDouble(),
            child: AdWidget(ad: bannerAd),
          ):SizedBox(),
        ],
      ),

    );
  }

  double _calculateMaxY(List<WeightRecord> records) {
    if (records.isEmpty) {
      return 100.0; // A default maximum value if there are no records
    }

    // Find the maximum weight value in the records
    double maxWeight = 0;
    for (final record in records) {
      if (record.weight > maxWeight) {
        maxWeight = record.weight;
      }
    }
    return maxWeight +
        10.0; // Add some padding to the maximum value for better visualization
  }

  List<FlSpot> getSpots(List<WeightRecord> records) {
    final List<FlSpot> spots = [FlSpot(0,0)];
    for (int i = 0; i < records.length; i++) {
      final record = records[i];
      spots.add(FlSpot(i.toDouble(), record.weight));
    }
    return spots;
  }
}
