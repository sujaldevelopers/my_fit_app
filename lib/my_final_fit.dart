import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:my_fit_app/Helper/My_color.dart';
import 'package:my_fit_app/my_run_page.dart';
import 'package:provider/provider.dart';
import 'Data/Data_base.dart';
import 'audio/my_provider.dart';

class FitList extends StatefulWidget {
  int pos;

  FitList(this.pos);

  @override
  State<FitList> createState() => _FitListState();
}

class _FitListState extends State<FitList> {
  late BannerAd bannerAd;
  bool isAdLoded = false;
  var adUnitId = Platform.isAndroid
      ? 'ca-app-pub-3940256099942544/6300978111'
      : 'ca-app-pub-3940256099942544/2934735716';

  @override
  List<String> list = [];
  List<dynamic> list2 = [];


  @override
  void initState() {
    if (widget.pos == 0) {
      list = Database.Texts;
      list2 = Database.image;
    } else if (widget.pos == 1) {
      list = Database.Texts2;
      list2 = Database.image2;
    } else if (widget.pos == 2) {
      list = Database.Texts3;
      list2 = Database.image3;
    } else if (widget.pos == 3) {
      list = Database.Texts4;
      list2 = Database.image4;
      initBannerAd();
    }
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

  @override
  Widget build(BuildContext context) {
    final fontProvider = Provider.of<AudioProvider>(context);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading:IconButton(
            onPressed: () {
              return Navigator.pop(context);
            },
            icon: Icon(
              CupertinoIcons.left_chevron,
              color: Colors.white,
            )),
        backgroundColor: CustomColor.Appbarcolor,
        //elevation: 10,
        title: Center(
          child: Text(
            "Fit-List",
            style: TextStyle(fontFamily: fontProvider.selectedFonts,color: CustomColor.fontcolor2),
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assert/image/background2.jpg"),
                fit: BoxFit.fill)),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisExtent: 235,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10),
            itemCount: Database.image3.length,
            itemBuilder: (context, index) {
              return Card(
                color: Colors.white,
                shadowColor: Colors.blue.shade900,
                //elevation: 20,
                surfaceTintColor: Colors.white,
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      CupertinoPageRoute(
                        builder: (context) {
                          return ReadPage(list, list2,index);
                        },
                      ),
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: CupertinoColors.black),
                        borderRadius: BorderRadius.circular(10)),
                    child: Column(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image(
                            image: AssetImage('assert/image/${list2[index]}'),
                          ),
                        ),
                        Divider(),
                        Spacer(),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: Text("${list[index]}",
                                style: TextStyle(
                                    fontFamily: fontProvider.selectedFonts)),
                          ),
                       // Image.asset("assert/image/${Tools.toolser[index][index]}",height: 10,width: 10,)
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
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
