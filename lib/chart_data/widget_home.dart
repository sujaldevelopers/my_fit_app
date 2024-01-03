import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:my_fit_app/Helper/My_color.dart';
import 'package:my_fit_app/audio/my_provider.dart';
import 'package:my_fit_app/chart_data/widget_chart.dart';
import 'package:my_fit_app/chart_data/widget_screen.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void _refreshData() {
    Provider.of<AudioProvider>(context, listen: true).loadRecords();
  }
  void _clearData() {
    Provider.of<AudioProvider>(context, listen: false).clearRecords();
  }
  void initState() {
    super.initState();
    Provider.of<AudioProvider>(context, listen: false).loadRecords();
  }
  DateTime? lastClickTime;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              Fluttertoast.showToast(msg: "Refresh Data");
              _refreshData();
            },
          ),
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              Fluttertoast.showToast(msg: "Delete Data");
              _clearData();
            },
          ),
        ],
        title:
            Align(child: Text('Weight Tracker'), alignment: Alignment.center),
      ),
      body: WeightChart(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: lastClickTime != null &&
                DateTime.now().difference(lastClickTime!) <=
                    Duration(seconds: 2)
            ? Colors.grey
            : Colors.blue,
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => lastClickTime == null ||
                          DateTime.now().difference(lastClickTime!) >
                              Duration(seconds: 20)
                      ? WeightEntryScreen()
                      : Container()));
        },
        child: Icon(Icons.add_box, color: CustomColor.fontcolor2),
      ),
    );
  }
}
