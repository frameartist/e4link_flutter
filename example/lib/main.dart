import 'package:e4link_flutter/models.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:e4link_flutter/e4link_flutter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';
  final _e4linkFlutterPlugin = E4linkFlutter();
  Map<String, E4Device> devices = {};

  @override
  void initState() {
    super.initState();

    initE4Connecton();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    // We also handle the message potentially returning null.
    try {
      platformVersion = await _e4linkFlutterPlugin.getPlatformVersion() ??
          'Unknown platform version';
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });
  }

  Future<void> initE4Connecton() async {
    var discoveredDevices = await E4linkFlutter.discoverDevices();
    for (var device in discoveredDevices) {
      setState(() {
        devices[device.id] = device;
      });
      E4linkFlutter.connect(device.id);
    }
    E4linkFlutter.eventStream.listen(handleE4Events);
  }

  void handleE4Events(event) {
    switch (event.dataType) {
      case E4EventType.bvp:
      case E4EventType.tmp:
      case E4EventType.ibi:
      case E4EventType.gsr:
        {
          setState(() {
            devices[event.id]?.readings[event.dataType.value] = event.value;
          });
        }
        break;
      case E4EventType.connected:
        {
          E4linkFlutter.subscribe(event.id, "bvp");
          E4linkFlutter.subscribe(event.id, "tmp");
        }
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
            child: ListView.builder(
                itemBuilder: (context, count) => Text(
                    "${devices.values.toList()[count].id} ${devices.values.toList()[count].readings["bvp"]} ${devices.values.toList()[count].readings["tmp"]}"),
                itemCount: devices.length)),
      ),
    );
  }
}
