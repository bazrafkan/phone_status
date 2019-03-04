import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:phone_status/phone_status.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';
  StreamSubscription streamSubscription;

  @override
  void initState() {
    super.initState();
    initPhonetate();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  void initPhonetate() {
    streamSubscription = phoneStateEvent.listen((PhoneStatus event) {
      print(event.state);
      setState(() {
        _platformVersion=event.state;
      });
    });

  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Text('Phone status: $_platformVersion\n'),
        ),
      ),
    );
  }
}
