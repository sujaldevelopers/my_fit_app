import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_fit_app/BMI/resultpage.dart';
import 'package:my_fit_app/BMI/thimpage.dart';
import 'package:my_fit_app/First_home.dart';

import '../Helper/My_color.dart';

class BmiPage extends StatefulWidget {
  @override
  _BmiPageState createState() => _BmiPageState();
}

class _BmiPageState extends State<BmiPage> {
  int age = 17;
  int weight = 50;

  int height = 180;
  double maxHeight = 220;
  double minHeight = 120;

  ageIncrement() {
    setState(() {
      age++;
    });
  }

  ageDecrement() {
    setState(() {
      age--;
    });
  }

  weightIncrement() {
    setState(() {
      weight++;
    });
  }

  weightDecrement() {
    setState(() {
      weight--;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              return Navigator.pop(context);
            },
            icon: Icon(
              CupertinoIcons.left_chevron,
              color: Colors.white,
            )),
        title: Text("BMI "),
        backgroundColor:CustomColor.Appbarcolor,
      ),
      body: Container(
       // color: secondary,
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: Container(
                    margin: EdgeInsets.all(10.0),
                    height: MediaQuery.of(context).size.height * 0.25,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: primary),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Image.asset(
                          'assert/image/young-man.png',
                          height: 100.0,
                          width: 100.0,
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        Text('MALE', style: headlines)
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    margin: EdgeInsets.all(10.0),
                    height: MediaQuery.of(context).size.height * 0.25,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: primary),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Image.asset(
                          'assert/image/woman.png',
                          height: 100.0,
                          width: 100.0,
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        Text('FEMALE', style: headlines)
                      ],
                    ),
                  ),
                )
              ],
            ),
            Expanded(
              flex: 1,
              child: Container(
                margin: EdgeInsets.all(10.0),
                height: MediaQuery.of(context).size.height * 0.25,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0), color: primary),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text('HEIGHT', style: headlines),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("$height", style: boldNumber),
                      ),
                      Slider(
                          value: height.toDouble(),
                          min: minHeight,
                          max: maxHeight,
                          activeColor: CustomColor.bmi,
                          inactiveColor: Colors.black,
                          onChanged: (double newValue) {
                            setState(() {
                              height = newValue.round();
                            });
                          },
                          semanticFormatterCallback: (double newValue) {
                            return '$newValue.round()';
                          })
                    ],
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: Container(
                    margin: EdgeInsets.all(10.0),
                    height: MediaQuery.of(context).size.height * 0.25,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: primary),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text('WEIGHT', style: headlines),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text("$weight", style: boldNumber),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            InkWell(
                              onTap: weightDecrement,
                              child: Container(
                                height: 40.0,
                                width: 40.0,
                                margin: EdgeInsets.all(10.0),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20.0),
                                    color: CustomColor.bmi,),
                                child: Center(
                                  child: Text(
                                    "-",
                                    style: secondaryButtonColorStyle,
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              height: 40.0,
                              width: 40.0,
                              margin: EdgeInsets.all(10.0),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20.0),
                                  color: CustomColor.bmi,),
                              child: InkWell(
                                onTap: weightIncrement,
                                child: Center(
                                  child: Text(
                                    "+",
                                    style: secondaryButtonColorStyle,
                                  ),
                                ),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    margin: EdgeInsets.all(10.0),
                    height: MediaQuery.of(context).size.height * 0.25,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: primary),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text('AGE', style: headlines),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text("$age", style: boldNumber),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            InkWell(
                              onTap: ageDecrement,
                              child: Container(
                                height: 40.0,
                                width: 40.0,
                                margin: EdgeInsets.all(10.0),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20.0),
                                    color: CustomColor.bmi,),
                                child: Center(
                                  child: Text(
                                    "-",
                                    style: secondaryButtonColorStyle,
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              height: 40.0,
                              width: 40.0,
                              margin: EdgeInsets.all(10.0),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20.0),
                                  color: CustomColor.bmi,),
                              child: InkWell(
                                onTap: ageIncrement,
                                child: Center(
                                  child: Text(
                                    "+",
                                    style: secondaryButtonColorStyle,
                                  ),
                                ),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
            InkWell(
              onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ResultPage(
                            height: height,
                            weight: weight,
                          ))),
              child: Container(
                color: CustomColor.bmi,
                margin: EdgeInsets.only(top: 10.0),
                height: MediaQuery.of(context).size.height * 0.1,
                child: Center(
                  child: Text('CALCULATE BMI', style: primaryButtonStyle),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
