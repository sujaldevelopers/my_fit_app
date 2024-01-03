import 'dart:io';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:my_fit_app/Data/Data_base.dart';
import 'package:my_fit_app/Helper/My_color.dart';
import 'package:my_fit_app/Helper/my_side_menu.dart';
import 'package:provider/provider.dart';

import 'audio/chart.dart';
import 'audio/my_provider.dart';
import 'chart_data/widget_chart.dart';
import 'chart_data/widget_home.dart';
import 'chart_data/widget_recod.dart';
import 'main.dart';
import 'my_final_fit.dart';

class FirstList extends StatefulWidget {
  const FirstList({super.key});

  @override
  State<FirstList> createState() => _FirstListState();
}

class _FirstListState extends State<FirstList> {
  List list = List.filled(Database.name.length, false);
  int maxFailedLoadAttempts = 3;
  InterstitialAd? _interstitialAd;
  int _numInterstitialLoadAttempts = 0;

  void _createInterstitialAd() {
    InterstitialAd.load(
        adUnitId: Platform.isAndroid
            ? 'ca-app-pub-3940256099942544/1033173712'
            : 'ca-app-pub-3940256099942544/4411468910',
        request: AdRequest(),
        adLoadCallback: InterstitialAdLoadCallback(
          onAdLoaded: (InterstitialAd ad) {
            print('$ad loaded');
            _interstitialAd = ad;
            _numInterstitialLoadAttempts = 0;
            _interstitialAd!.setImmersiveMode(true);
          },
          onAdFailedToLoad: (LoadAdError error) {
            print('InterstitialAd failed to load: $error.');
            _numInterstitialLoadAttempts += 1;
            _interstitialAd = null;
            if (_numInterstitialLoadAttempts < maxFailedLoadAttempts) {
              _createInterstitialAd();
            }
          },
        ));
  }

  void _showInterstitialAd() {
    if (_interstitialAd == null) {
      print('Warning: attempt to show interstitial before loaded.');
      return;
    }
    _interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
      onAdShowedFullScreenContent: (InterstitialAd ad) =>
          print('ad onAdShowedFullScreenContent.'),
      onAdDismissedFullScreenContent: (InterstitialAd ad) {
        print('$ad onAdDismissedFullScreenContent.');
        ad.dispose();
        _createInterstitialAd();
      },
      onAdFailedToShowFullScreenContent: (InterstitialAd ad, AdError error) {
        print('$ad onAdFailedToShowFullScreenContent: $error');
        ad.dispose();
        _createInterstitialAd();
      },
    );
    _interstitialAd!.show();
    _interstitialAd = null;
  }

  @override
  void initState() {
    super.initState();
    _createInterstitialAd();
    Provider.of<AudioProvider>(context, listen: false).loadRecords();
    appOpenAdManager.showAdIfAvailable();
  }

  @override
  Widget build(BuildContext context) {
    final weightRecords = Provider.of<AudioProvider>(context).records;
    final fontProvider = Provider.of<AudioProvider>(context);
    return FutureBuilder(
      future: Future.delayed(Duration(seconds: 1)),
      builder: (context, snapshot) {
        return Scaffold(
          backgroundColor: CustomColor.background,
          drawer: NavigationDrawers(),
          appBar: AppBar(
            leading: Builder(builder: (context) {
              return IconButton(
                  onPressed: () {
                    return Scaffold.of(context).openDrawer();
                  },
                  icon: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: CustomColor.background,
                    ),
                    height: 40,
                    width: 40,
                    child: Icon(Icons.menu),
                  ));
            }),
            actions: [
              IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HomeScreen(),
                    ),
                  );
                },
                icon: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image(
                    height: 40,
                    image: AssetImage("assert/icon/weight-scale.gif"),
                  ),
                ),
                // icon: Icon(
                //   Icons.monitor_weight,
                //   color: CustomColor.fontcolor2,
                //   size: 40,
                // ),
              ),
            ],
            backgroundColor: CustomColor.Appbarcolor,
            title: Center(
              child: Text("Home Page",
                  style: TextStyle(
                      color: CustomColor.fontcolor2,
                      fontFamily: fontProvider.selectedFonts)),
            ),
          ),
          body: Container(
            color: Colors.grey.shade200,
            child: ListView.separated(
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      if (index == 0)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Card(
                              elevation: 1,
                              child: Padding(
                                padding: EdgeInsets.all(10.0),
                                child: Container(
                                  child: Column(
                                    children: [
                                      Center(child: Text("Current Wight")),
                                      Center(
                                        child: Text(
                                          "${AudioProvider().getSpots(weightRecords).last.y}",
                                          style: TextStyle(
                                            fontSize: 26.0,
                                            fontFamily:
                                                fontProvider.selectedFonts,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  // child: Consumer<AudioProvider>(
                                  //   builder: (context, appFeaturesProvider, child) {
                                  //     return Column(
                                  //       crossAxisAlignment: CrossAxisAlignment.start,
                                  //       children: [
                                  //         Text('Feature Status:'),
                                  //         for (var feature in appFeaturesProvider.info2)
                                  //           Text(
                                  //             '${feature['featureName']}: ${feature['isEnabled']}',
                                  //           ),
                                  //       ],
                                  //     );
                                  //   },
                                  // ),
                                  height: 150,
                                  width: 150,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(13),
                                    color: Colors.white70,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      GestureDetector(
                        onTapDown: (details) {
                          setState(() {
                            list[index] = true;
                          });
                        },
                        onTap: () {
                          if (index == 1) {
                            _showInterstitialAd();
                          }
                          setState(() {
                            list[index] = true;
                          });
                          Navigator.push(context, MaterialPageRoute(
                            builder: (context) {
                              print(index);
                              return FitList(index);
                            },
                          ));
                        },
                        onTapUp: (details) {
                          setState(() {
                            list[index] = false;
                          });
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(20),
                                        topRight: Radius.circular(20))),
                                padding: EdgeInsets.all(10),
                                child: ClipRRect(
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(20),
                                        topRight: Radius.circular(20)),
                                    child: Image(
                                        image: AssetImage(
                                            'assert/image/${Database.mimg[index]}'))),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    color: Colors.white70,
                                    borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(20),
                                        bottomRight: Radius.circular(20))),
                                child: ListTile(
                                  selected: list[index],
                                  title: Center(
                                    child: Text("${Database.name[index]}",
                                            style: TextStyle(
                                                fontFamily:
                                                    fontProvider.selectedFonts))
                                        .animate()
                                        .fadeIn(duration: 1000.ms)
                                        .then(delay: 2.seconds)
                                        .slide(),
                                  ),
                                  trailing:
                                      SvgPicture.asset('assert/icon/right2.svg',
                                              // ignore: deprecated_member_use
                                              color: CustomColor.fontcolor,
                                              fit: BoxFit.fill)
                                          .animate()
                                          .fadeIn(duration: 1000.ms)
                                          .then(delay: 2.seconds)
                                          .scale(),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                },
                separatorBuilder: (context, index) {
                  return Divider(
                    height: 20,
                    thickness: 2,
                  );
                },
                itemCount: Database.mimg.length),
          ),
        );
      },
    );
  }
}
