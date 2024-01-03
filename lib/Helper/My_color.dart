import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class CustomColor {
  static const Color side = Color(0xffFFEBEE);
  static const Color Side2 = Color(0xffB70404);
  static const Color Appbarcolor = Color(0xffB70404);
  static const Color background = Color(0xffffffff);
  static const Color fontcolor = Color(0xff000000);
  static const Color fontcolor2 = Color(0xffFFFFFF);
  static const Color bmi = Color(0xffF79327);
  static const List gradient = [
    (colors: [Colors.black, Colors.white]),
  ];
//Color dcsc=Colors.red.shade400;
}

class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}

Color color1 = HexColor("b74093");
Color color2 = HexColor("#b74093");
Color color3 = HexColor("#88b74093"); // if you wish to use ARGB format

class DbHelper {
  late Box box;

  DbHelper() {
    openBox();
  }

  openBox() {
    box = Hive.box("money");
  }

  Future addData(int amount, DateTime date, String note, String type) async {
    var value = {
      "amount": amount,
      "date": date,
      "note": note,
      "type": type,
    };
    box.add(value);
  }

  Future<Map> fatch() {
    if (box.values.isEmpty) {
      return Future.value({});
    } else {
      return Future.value(box.toMap());
    }
  }
}

class TransactionModel {
  int amount;
  final String note;
  final DateTime date;
  final String type;

  addAmount(int amount) {
    this.amount = this.amount + amount;
  }

  TransactionModel(this.amount, this.note, this.date, this.type);
}

// class Cantaner extends StatelessWidget {
//   const Cantaner({super.key, this.child});
//
//   final dynamic child;
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(15.0),
//         gradient: LinearGradient(
//           colors: [
//             //Colors.white,
//             CustomColor.Appbarcolor.withOpacity(0.3),
//             Colors.white,
//             CustomColor.Appbarcolor.withOpacity(0.3),
//           ],
//         ),
//       ),
//       child: child,
//     );
//   }
// }
