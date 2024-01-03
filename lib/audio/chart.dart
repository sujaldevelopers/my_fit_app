import 'package:flutter/material.dart';
import 'package:my_fit_app/Helper/My_color.dart';
import 'package:my_fit_app/audio/add_data.dart';

class MyHome extends StatefulWidget {
  const MyHome({super.key});

  @override
  State<MyHome> createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  DbHelper dbHelper = DbHelper();
  int totalBalance = 0;
  int totalIncom = 0;
  int totalExpense = 0;

  getTotalBalance(Map entireData) {
    totalIncom=0;
    totalExpense=0;
    totalBalance=0;
    entireData.forEach((key, value) {
      if (value['type'] == ['Income']) {
        totalBalance += (value['amount'] as int);
        totalIncom += (value['amount'] as int);
      } else {
        totalBalance -= (value['amount'] as int);
        totalExpense += (value['amout'] as int);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0.0,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        backgroundColor: CustomColor.side,
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) {
                return AddData();
              },
            ),
          );
        },
        child: Icon(Icons.add),
      ),
      body: FutureBuilder<Map>(
          future: dbHelper.fatch(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(child: Text("Unexpected Error !"));
            }
            if (snapshot.hasData) {
              if (snapshot.data!.isEmpty) {
                return Center(
                  child: Text("No Value ygyug"),
                );
              }
              getTotalBalance(snapshot.data!);
              return ListView(
                children: [
                  Padding(
                    padding: EdgeInsets.all(12.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12.0),
                                    color: CustomColor.Appbarcolor),
                                child: Icon(
                                  Icons.settings,
                                  color: CustomColor.fontcolor2,
                                  size: 32.0,
                                )),
                          ],
                        ),
                        SizedBox(
                          width: 8.0,
                        ),
                        Text(
                          "Welcome ",
                          style: TextStyle(fontSize: 24.0),
                        ),
                        Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12.0),
                                color: CustomColor.Appbarcolor),
                            child: Icon(
                              Icons.settings,
                              color: CustomColor.fontcolor2,
                              size: 32.0,
                            )),
                      ],
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    margin: EdgeInsets.all(12.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: CustomColor.Appbarcolor,
                        borderRadius: BorderRadius.circular(24.0),
                      ),
                      padding:
                          EdgeInsets.symmetric(vertical: 20.0, horizontal: 8.0),
                      child: Column(
                        children: [
                          Text(
                            "Total Balance",
                            style: TextStyle(
                              color: CustomColor.fontcolor2,
                              fontSize: 22.0,
                            ),
                          ),
                          Text(
                            "Rs $totalBalance",
                            style: TextStyle(
                              color: CustomColor.fontcolor2,
                              fontSize: 26.0,
                            ),
                          ),
                          SizedBox(
                            height: 12.0,
                          ),
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                cardIncom(
                                  totalIncom.toString(),
                                ),
                                cardExpense(
                                  totalExpense.toString(),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            } else {
              return Center(child: Text("Unexpected Error !"));
            }
          }),
    );
  }

  Widget cardIncom(String value) {
    return Row(
      children: [
        Container(
          decoration: BoxDecoration(
            color: CustomColor.side,
            borderRadius: BorderRadius.circular(20.0),
          ),
          padding: EdgeInsets.all(6.0),
          child: Icon(
            Icons.arrow_downward,
            size: 28,
          ),
          margin: EdgeInsets.all(8.0),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Income",
              style: TextStyle(color: CustomColor.fontcolor2, fontSize: 14.0),
            ),
            Text(
              value,
              style: TextStyle(color: CustomColor.fontcolor2, fontSize: 20.0),
            ),
          ],
        )
      ],
    );
  }

  Widget cardExpense(String value) {
    return Row(
      children: [
        Container(
          decoration: BoxDecoration(
            color: CustomColor.side,
            borderRadius: BorderRadius.circular(20.0),
          ),
          padding: EdgeInsets.all(6.0),
          child: Icon(
            Icons.arrow_upward,
            size: 28,
          ),
          margin: EdgeInsets.all(8.0),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Expense",
              style: TextStyle(color: CustomColor.fontcolor2, fontSize: 14.0),
            ),
            Text(
              value,
              style: TextStyle(color: CustomColor.fontcolor2, fontSize: 20.0),
            ),
          ],
        )
      ],
    );
  }
}
