import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:my_fit_app/Helper/My_color.dart';
import 'package:provider/provider.dart';
import 'package:toggle_switch/toggle_switch.dart';

import 'my_provider.dart';

class MyAudioPlayerWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final audioProvider = Provider.of<AudioProvider>(context);
    final fontProvider = Provider.of<AudioProvider>(context);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        InkWell(
          onTap: () {
            audioProvider.setAudioSource('assert/music/Seasons - roljui.mp3');
          },
          child: Container(
            child: Text(
              'Audio Provider',
              style: TextStyle(
                  fontFamily: fontProvider.selectedFonts,
                  color: CustomColor.fontcolor2),
            ).animate().fade().scale(),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // IconButton(
            //   onPressed: () {
            //     audioProvider.play();
            //   },
            //   icon: Icon(CupertinoIcons.play_circle,color: CustomColor.fontcolor),
            // ),
            // IconButton(
            //   onPressed: () {
            //     audioProvider.pause();
            //   },
            //   icon: Icon(CupertinoIcons.pause_circle,color: CustomColor.fontcolor),
            // ),
            ToggleSwitch(
              minWidth: 60.0,
              cornerRadius: 20.0,
              activeBgColors: [[Colors.white!,CustomColor.bmi], [Colors.red[800]!,Colors.red.shade100]],
              activeFgColor: Colors.white,
              inactiveBgColor: Colors.grey,
              inactiveFgColor: Colors.white,
              totalSwitches: 2,
              centerText: true,
              //animate: true,
              animationDuration: 2,
              icons: [
                Icons.music_note,
                Icons.music_off
              ],
              iconSize: 30.0,
              //activeBgColors: [[Colors.black45, Colors.black26], [Colors.yellow, Colors.orange]],
              //animate: true,
              initialLabelIndex: 1,
             // totalSwitches: 2,
             // labels: ['True', 'False'],
              radiusStyle: true,
              onToggle: (index) {
                if(index==0){
                  audioProvider.play();
                }else{
                  audioProvider.pause();
                }
              },
            ),
          ],
        ),
      ],
    );
  }
}
