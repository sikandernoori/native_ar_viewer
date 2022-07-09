import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:native_ar_viewer/native_ar_viewer.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isLaunched = false;
  final _nativeArViewerPlugin = NativeArViewer();

  final String modelURL =
      "https://firebasestorage.googleapis.com/v0/b/livvinyl-health-connector.appspot.com/o/catcow.glb?alt=media&token=da87cd4d-c9c1-4176-b1b3-a0b6fdc8734b";

  @override
  void initState() {
    super.initState();
    startActivity();
  }

  Future<void> startActivity() async {
    bool isLaunched;
    try {
      isLaunched = await _nativeArViewerPlugin.launchAR(modelURL) ?? false;
    } on PlatformException {
      isLaunched = false;
    }

    if (!mounted) return;

    setState(() {
      _isLaunched = isLaunched;
    });
  }

  @override
  Widget build(BuildContext context) => MaterialApp(
      home: Scaffold(
          appBar: AppBar(title: const Text('Plugin example app')),
          body: Center(child: Text('AR Launch Status: $_isLaunched\n'))));
}
