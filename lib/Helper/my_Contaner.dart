import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Timer extends StatefulWidget {
  const Timer({super.key});

  @override
  State<Timer> createState() => _TimerState();
}

class _TimerState extends State<Timer> {
  bool second = true;
  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<Duration>(
        duration: Duration(minutes: 300),
        tween: Tween(begin: Duration(minutes: 300), end: Duration.zero),
        onEnd: () {
          print('Timer ended');
        },
        builder: (BuildContext context, Duration value, Widget? child) {
          final seconds = value.inSeconds % 30;
          //  second==0?true:false;
          return Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: Text('$seconds',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 30)));
        });
  }
}
