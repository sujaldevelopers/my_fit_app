import 'dart:io';

import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:just_audio/just_audio.dart';
import 'package:my_fit_app/BMI/bmipage.dart';
import 'package:my_fit_app/First_home.dart';
import 'package:my_fit_app/Helper/My_color.dart';
import 'package:my_fit_app/chart_data/widget_chart.dart';
import 'package:my_fit_app/suggest_tools/tools_structer.dart';
import 'package:provider/provider.dart';
import 'audio/my_audioservice_widget.dart';
import 'audio/my_provider.dart';
import 'chart_data/widget_home.dart';

class ReadPage extends StatefulWidget {
  List textlist;
  List imagelist;

  int index;

  ReadPage(this.textlist, this.imagelist, this.index);

  @override
  State<ReadPage> createState() => _ReadPageState();
}

class _ReadPageState extends State<ReadPage> {
  final int _duration = 300;
  final CountDownController _controller = CountDownController();
  late AudioPlayer _audioPlayer;

  late BannerAd bannerAd;
  bool isAdLoded = false;
  var adUnitId = Platform.isAndroid
      ? 'ca-app-pub-3940256099942544/6300978111'
      : 'ca-app-pub-3940256099942544/2934735716';

  @override
  void initState() {
    super.initState();
    _audioPlayer = AudioPlayer()..setAsset("assert/music/Seasons - roljui.mp3");
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

  //final audioProvider = Provider.of<NameListProvider>(context);
  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final fontProvider = Provider.of<AudioProvider>(context);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: CustomColor.Appbarcolor,
        actions: [
          IconButton(
              onPressed: () {
                return Navigator.pop(context);
              },
              icon: Icon(
                CupertinoIcons.left_chevron,
                color: Colors.white,
              )),
          Spacer(),
          IconButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => FirstList(),
                  ));
            },
            icon: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image(
                height: 40,
                image: AssetImage(
                  "assert/icon/home.gif",
                ),
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                padding: EdgeInsets.all(50),
                decoration: BoxDecoration(
                    border: Border.all(width: 1),
                    borderRadius: BorderRadius.circular(10)),
                child: ClipRRect(
                  child: Image.asset(
                      'assert/image/${widget.imagelist[widget.index]}'),
                ),
              ),
            ),
            Text("${widget.textlist[widget.index]}",
                style: TextStyle(fontFamily: fontProvider.selectedFonts)),
            //Divider(thickness: 2),
            SizedBox(
              height: 10,
            ),
            Divider(),
            Align(
              alignment: Alignment.topLeft,
              child: Container(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Row(
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.star,
                                size: 10,
                              ),
                              Row(
                                children: [
                                  Text(" Timer",
                                      style: TextStyle(
                                          fontFamily:
                                              fontProvider.selectedFonts,
                                          fontSize: 20)),
                                  // SizedBox(
                                  //   //height: 40,
                                  //   width: 35,
                                  //   child: IconButton(onPressed: () {
                                  //
                                  //   }, icon: Image.asset("assert/icon/info.gif")),
                                  // )
                                ],
                              ),
                            ],
                          ),
                          Spacer(),
                          // Padding(
                          //     padding: const EdgeInsets.only(left: 70),
                          //     child: MyAudioPlayerWidget()),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Container(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    (widget.index != 0)
                        ? Container(
                            margin: EdgeInsets.all(10),
                            child: IconButton(
                                onPressed: () {
                                  _controller.restart(duration: _duration);
                                  setState(() {
                                    if (widget.index > 0) widget.index--;
                                  });
                                },
                                icon: SvgPicture.asset(
                                  "assert/image/Back.svg",
                                  fit: BoxFit.fill,
                                  width: 45,
                                )),
                          )
                        : Container(
                            width: 61,
                            margin: EdgeInsets.all(10),
                          ),
                    InkWell(
                      hoverColor: Colors.transparent,
                      splashColor: Colors.transparent,
                      focusColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onTap: () {
                        _controller.resume();
                      },
                      child: CircularCountDownTimer(
                        width: MediaQuery.of(context).size.width / 3,
                        height: MediaQuery.of(context).size.height / 5,
                        duration: _duration,
                        textStyle: TextStyle(
                            fontSize: 30,
                            fontFamily: "Archivo",
                            fontWeight: FontWeight.w100),
                        fillColor: CustomColor.Appbarcolor,
                        ringColor: Colors.blue.shade100,
                        controller: _controller,
                        autoStart: false,
                        timeFormatterFunction:
                            (defaultFormatterFunction, duration) {
                          if (duration.inSeconds == 0) {
                            // only format for '0'
                            return "Start";
                          } else {
                            // other durations by it's default format
                            return Function.apply(
                              defaultFormatterFunction,
                              [duration],
                            );
                          }
                        },
                      ),
                    ),
                    (widget.index != widget.imagelist.length - 1)
                        ? Container(
                            margin: EdgeInsets.all(10),
                            child: IconButton(
                              onPressed: () {
                                _controller.restart(duration: _duration);
                                setState(
                                  () {
                                    if (widget.index <
                                        widget.imagelist.length - 1)
                                      widget.index++;
                                  },
                                );
                              },
                              icon: SvgPicture.asset("assert/image/Forward.svg",
                                  fit: BoxFit.fill, width: 45),
                            ),
                          )
                        : Container(
                            width: 61,
                            margin: EdgeInsets.all(10),
                          ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 40),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.stars_rounded,
                        size: 10,
                      ),
                      SizedBox(width: 5),
                      Text(
                        "Circle  Click to '' Start ''",
                        style: TextStyle(
                            fontFamily: fontProvider.selectedFonts,
                            fontSize: 15),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(
                        width: 30,
                      ),
                      _button(
                        title: "Restart",
                        onPressed: () {
                          _controller.start();
                        },
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      _button(
                        title: "Stop",
                        onPressed: () => _controller.pause(),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            //ToolStructer(),
            // Padding(
            //   padding: const EdgeInsets.only(left: 10),
            //   child: Row(
            //     children: [
            //       Icon(
            //         Icons.star,
            //         size: 10,
            //       ),
            //       Text(
            //         " Tools",
            //         style: TextStyle(
            //             fontFamily: fontProvider.selectedFonts, fontSize: 20),
            //       ),
            //     ],
            //   ),
            // ),
            // SizedBox(
            //   height: 15,
            // ),
            // Padding(
            //   padding: const EdgeInsets.all(10),
            //   child: SizedBox(
            //     height: 100,
            //     child: ListView.builder(
            //       itemCount: 5,
            //       scrollDirection: Axis.horizontal,
            //       itemBuilder: (context, index) {
            //         return Container(
            //           margin: EdgeInsets.all(5),
            //           height: 50,
            //           width: 100,
            //           child: Image.asset(
            //             "assert/image/${widget.toolslist[widget.index2][index]}",
            //           ),
            //           //color: Colors.w,
            //         );
            //       },
            //     ),
            //   ),
            // ),
            SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Row(
                children: [
                  Icon(
                    Icons.star,
                    size: 10,
                  ),
                  Text(
                    " Tracking Tools",
                    style: TextStyle(
                        fontFamily: fontProvider.selectedFonts, fontSize: 20),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Row(
                    children: [
                      Column(
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.stars_rounded,
                                size: 10,
                              ),
                              SizedBox(width: 5),
                              Text(
                                "Calculate-BMI",
                                style: TextStyle(
                                    fontFamily: fontProvider.selectedFonts,
                                    fontSize: 15),
                              ),
                            ],
                          ),
                          Container(
                            height: 150,
                            width: 150,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              image: DecorationImage(
                                image: AssetImage("assert/video/round.gif"),
                              ),
                              // gradient: LinearGradient(colors: [
                              //   Colors.white,
                              //   CustomColor.bmi,
                              //   Colors.white,
                              // ],
                              // ),
                            ),
                            child: IconButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => BmiPage(),
                                    ));
                              },
                              icon: Icon(
                                Icons.monitor_weight_rounded,
                                color: Colors.black87,
                                size: 70,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Spacer(),
                  Column(
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.stars_rounded,
                            size: 10,
                          ),
                          SizedBox(width: 5),
                          Text(
                            "Weight-Tracker",
                            style: TextStyle(
                                fontFamily: fontProvider.selectedFonts,
                                fontSize: 15),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Container(
                            height: 150,
                            width: 150,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              image: DecorationImage(
                                image: AssetImage("assert/video/round.gif"),
                              ),
                              // gradient: LinearGradient(
                              //   colors: [
                              //     Colors.white,
                              //     CustomColor.Appbarcolor,
                              //     Colors.white,
                              //   ],
                              // ),
                            ),
                            child: IconButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => HomeScreen(),
                                    ));
                              },
                              icon: Icon(
                                Icons.add_chart,
                                color: Colors.black87,
                                size: 70,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ], //
        ),
      ),
      bottomNavigationBar: isAdLoded
          ? SizedBox(
              height: bannerAd.size.height.toDouble(),
              width: bannerAd.size.width.toDouble(),
              child: AdWidget(ad: bannerAd),
            )
          : SizedBox(),
    );
  }

  Widget _button({required String title, VoidCallback? onPressed}) {
    final fontProvider = Provider.of<AudioProvider>(context);
    return Expanded(
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(CustomColor.Appbarcolor),
        ),
        onPressed: onPressed,
        child: Text(title,
            style: TextStyle(
                fontFamily: fontProvider.selectedFonts, color: Colors.white)),
      ),
    );
  }
}

class Controller extends StatelessWidget {
  const Controller({super.key, required this.audioPlayer});

  final AudioPlayer audioPlayer;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<PlayerState>(
      stream: audioPlayer.playerStateStream,
      builder: (context, snapshot) {
        final playerState = snapshot.data;
        final progressingState = playerState?.processingState;
        final playing = playerState?.playing;
        if (!(playing ?? false)) {
          return IconButton(
              iconSize: 50,
              color: Colors.black,
              onPressed: audioPlayer.play,
              icon: Icon(
                Icons.play_circle_outline,
                size: 30,
              ));
        } else if (progressingState != ProcessingState.completed) {
          return IconButton(
            iconSize: 50,
            color: Colors.black,
            onPressed: audioPlayer.pause,
            icon: Icon(
              Icons.pause_circle_outline_sharp,
              size: 30,
            ),
          );
        }
        return const Icon(
          Icons.pause_circle_outline_sharp,
          color: Colors.black,
          size: 30,
        );
      },
    );
  }
}
