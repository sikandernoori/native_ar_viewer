import 'dart:io' as io;

import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:native_ar_viewer/native_ar_viewer.dart';
import 'package:path_provider/path_provider.dart';

String iosAssetPath = '';
String taskId = '';
String documentDirectoryPath = "";
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FlutterDownloader.initialize();
  FlutterDownloader.registerCallback(downloadCallback);

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  /// For Android Platform .glb format and for IOS .USDZ
  final String modelURL = io.Platform.isAndroid
      ? "https://firebasestorage.googleapis.com/v0/b/livvinyl-health-connector.appspot.com/o/catcow.glb?alt=media&token=da87cd4d-c9c1-4176-b1b3-a0b6fdc8734b"
      : "https://firebasestorage.googleapis.com/v0/b/livvinyl-health-connector.appspot.com/o/Astronaut.usdz?alt=media&token=833344f6-7f17-4f21-aa5c-6f9fc5313928";

  @override
  void initState() {
    super.initState();
    _downloadAssetsForIOS();
  }

  _downloadAssetsForIOS() async {
    await _prepareSaveDir();
    taskId = (await FlutterDownloader.enqueue(
        url: modelURL, savedDir: documentDirectoryPath))!;
    print('taskId = $taskId');
  }

  _launchAR() async {
    if (io.Platform.isAndroid) {
      await NativeArViewer.launchAR(modelURL);
    } else if (io.Platform.isIOS) {
      /// Here File name is hardcoded, in realtime application you will use your own logic to locate USDZ file.
      await NativeArViewer.launchAR("$documentDirectoryPath/Astronaut.usdz");
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Platform not supported')));
    }
  }

  Future<void> _prepareSaveDir() async {
    documentDirectoryPath = (await _findLocalPath())!;
    final savedDir = io.Directory(documentDirectoryPath);
    bool hasExisted = await savedDir.exists();
    if (!hasExisted) {
      savedDir.create();
    }
  }

  Future<String?> _findLocalPath() async =>
      (await getApplicationDocumentsDirectory()).path;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Example app'), centerTitle: true),
        body: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ElevatedButton(
                onPressed: _launchAR,
                child: const Text(
                  'Launch AR',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void downloadCallback(
    String id, DownloadTaskStatus status, int progress) async {
  print('callback: ID = $id || status = $status || progress = $progress');
}
