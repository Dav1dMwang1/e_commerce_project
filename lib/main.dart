import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  SystemChrome.setEnabledSystemUIOverlays([]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo - Timer',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: TimerApp(title: 'Flutter Timer Home Page'),
    );
  }
}

class TimerApp extends StatefulWidget {
  TimerApp({Key key, this.title}) : super(key: key);
  final String title;

  @override
  TimerAppState createState() => TimerAppState();
}

class CustomTextContainer extends StatelessWidget {
  CustomTextContainer({this.label, this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 2.5),
      padding: EdgeInsets.all(15.0),
      decoration: new BoxDecoration(
        borderRadius: new BorderRadius.circular(10),
        color: Colors.black87,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            '$value',
            style: TextStyle(
              color: Colors.white,
              fontSize: 44,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            '$label',
            style: TextStyle(
              color: Colors.white70,
            ),
          ),
        ]
      ),
    );
  }
}

class TimerAppState extends State<TimerApp> {
  static const duration = const Duration(seconds: 1);

  int secondsPassed = 0;
  bool isActive = false;

  Timer timer;

  void handleTick() {
    if (isActive) {
      setState(() {
        secondsPassed = secondsPassed + 1;
      });
    }
  }
//
//  @override
//  void initState() {
//    timer = Timer.periodic(duration, (Timer t) {
//      handleTick();
//    });
//    super.initState();
//  }

  @override
  Widget build(BuildContext context) {

    int seconds = secondsPassed % 60;
    int minutes = secondsPassed ~/ 60;
    int hours = secondsPassed ~/ (60*60);

    if(timer == null) {
      timer = Timer.periodic(duration, (Timer t) {
        handleTick();
      });
    }

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Timer'),
        ),
        body: Center(
            child: SingleChildScrollView(
//          padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    CustomTextContainer(label: 'HRS', value: hours.toString().padLeft(2, '0')),
                    CustomTextContainer(label: 'MIN', value: minutes.toString().padLeft(2, '0')),
                    CustomTextContainer(label: 'SEC', value: seconds.toString().padLeft(2, '0')),
                    Container(
                      margin: EdgeInsets.only(top: 20),
                      child: RaisedButton(
                          child: Text(isActive ? 'STOP' : 'START'),
                          onPressed: () {
                            setState(() { isActive = !isActive; });
                          }),
                    )
                  ],
                ),
              ),
            )
        ),
      )
    );
  }
}
