import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  final String text;
  final VoidCallback onClick;
  final Color color;
  final Color Backgroundcolor;

  const ButtonWidget(
      {super.key,
        required this.text,
        required this.onClick,
        this.color = Colors.white,
        this.Backgroundcolor = Colors.black38});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16)),
      onPressed: onClick,
      child: Text(text, style: TextStyle(color: color, fontSize: 20)),
    );
  }
}