import 'dart:async';
import 'package:flutter/material.dart';
import 'my_elevated.dart';

class MyStop extends StatefulWidget {
  const MyStop({super.key});

  @override
  State<MyStop> createState() => _MyStopState();
}

class _MyStopState extends State<MyStop> {
  static const maxSeconds = 60;
  int seconds = maxSeconds;
  Timer? timer;

  void startTimer(){
    timer = Timer.periodic(
      Duration(seconds: 1),
          (timer) {
        if (seconds > 0) {
          setState(() => seconds--);
        }else{
          stopTimer();
        }
      },
    );
  }

  void stopTimer() {
    timer?.cancel();
  }

  @override
  Widget build(BuildContext context)=>
     Scaffold(
      backgroundColor: Colors.amber,
      body: Padding(
        padding: const EdgeInsets.only(bottom: 20),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              buildTime(),
              SizedBox(height: 20,),
              buildButton(),
            ],
          ),
        ),
      ),
    );
    Widget buildButton() {
      final isRunning = timer == null ? false : timer!.isActive;
      return isRunning
          ? ButtonWidget(
        text: 'push',
        color: Colors.yellow,
        Backgroundcolor: Colors.orange,
        onClick: () {
          setState(() {
            stopTimer();
          });
        },
      )
          : ButtonWidget(
        text: "Show",
        onClick: () {
          setState(() {
            startTimer();
          });
        },
        color: Colors.black,
        Backgroundcolor: Colors.white,
      );
    }
    Widget buildTime() {
      return Text('$seconds',style: TextStyle(fontSize: 40),);
  }
}


