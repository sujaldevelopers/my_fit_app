import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_fit_app/Helper/My_color.dart';

class AddData extends StatefulWidget {
  const AddData({super.key});

  @override
  State<AddData> createState() => _AddDataState();
}

class _AddDataState extends State<AddData> {
  int? amount;
  String note = "Some Expense";
  String type = "Income";
  DateTime selecteDate = DateTime.now();

  List<String> months = [
    "Jan",
    "Feb",
    "Mar",
    "Apr",
    "May",
    "Jun",
    "Jul",
    "Aug",
    "Sep",
    "Oct",
    "Nov",
    "Dec",
  ];

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selecteDate,
        firstDate: DateTime(2022, 12),
        lastDate: DateTime(2100, 01));
    if (picked != null && picked != selecteDate) {
      setState(() {
        selecteDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: true,
          toolbarHeight: 0.0,
        ),
        body: ListView(
          padding: EdgeInsets.all(12.0),
          children: [
            SizedBox(
              height: 20.0,
            ),
            Text(
              "Add Transaction",
              style: TextStyle(
                fontSize: 32.0,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: CustomColor.side,
                      borderRadius: BorderRadius.circular(16.0)),
                  padding: EdgeInsets.all(12.0),
                  child: Icon(CupertinoIcons.money_dollar),
                ),
                SizedBox(
                  width: 12.0,
                ),
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: "0",
                      border: InputBorder.none,
                    ),
                    onChanged: (val) {
                      try {
                        amount = int.parse(val);
                      } catch (e) {
                        print("Catch Error $e");
                      }
                    },
                    style: TextStyle(
                      fontSize: 24.0,
                    ),
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                    keyboardType: TextInputType.number,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20.0,
            ),
            Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: CustomColor.side,
                      borderRadius: BorderRadius.circular(16.0)),
                  padding: EdgeInsets.all(12.0),
                  child: Icon(Icons.description),
                ),
                SizedBox(
                  width: 12.0,
                ),
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: "Not on Transaction !",
                      border: InputBorder.none,
                    ),
                    onChanged: (val) {
                      note = val;
                    },
                    style: TextStyle(
                      fontSize: 24.0,
                    ),
                    maxLength: 24,
                    keyboardType: TextInputType.text,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20.0,
            ),
            Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: CustomColor.side,
                      borderRadius: BorderRadius.circular(16.0)),
                  padding: EdgeInsets.all(12.0),
                  child: Icon(Icons.moving),
                ),
                SizedBox(
                  width: 12,
                ),
                ChoiceChip(
                  label: Text(
                    "Income",
                    style: TextStyle(
                      fontSize: 18.0,
                      color: type == "Income" ? Colors.red : Colors.black,
                    ),
                  ),
                  selectedColor: CustomColor.side,
                  selected: type == "Income" ? true : false,
                  onSelected: (val) {
                    if (val) {
                      setState(() {
                        type = "Income";
                      });
                    }
                  },
                ),
                SizedBox(
                  width: 12,
                ),
                ChoiceChip(
                  label: Text(
                    "Expense",
                    style: TextStyle(
                      fontSize: 18.0,
                      color: type == "Expense" ? Colors.red : Colors.black,
                    ),
                  ),
                  selectedColor: CustomColor.side,
                  selected: type == "Expense" ? true : false,
                  onSelected: (val) {
                    if (val) {
                      setState(() {
                        type = "Expense";
                      });
                    }
                  },
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            SizedBox(
              height: 50.0,
              child: TextButton(
                style: ButtonStyle(
                    padding: MaterialStateProperty.all(EdgeInsets.zero)),
                onPressed: () {
                  _selectDate(context);
                },
                child: Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          color: CustomColor.side,
                          borderRadius: BorderRadius.circular(16.0)),
                      padding: EdgeInsets.all(12.0),
                      child: Icon(Icons.calendar_month),
                    ),
                    SizedBox(
                      width: 12,
                    ),
                    Text(
                      "${selecteDate.day} ${months[selecteDate.month - 1]}",
                      style: TextStyle(fontSize: 20.0),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            ElevatedButton(
              onPressed: () {
                if(amount!=null&& note.isEmpty){
                  DbHelper dbhelper=DbHelper();
                  dbhelper.addData(amount!, selecteDate, note, type);
                }else{
                  print("Not All Value Provided !");
                }
                Navigator.pop(context);
              },
              child: Text("Save"),
            )
          ],
        ),);
  }
}
