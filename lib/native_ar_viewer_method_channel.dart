import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'native_ar_viewer_platform_interface.dart';

class MethodChannelNativeArViewer extends NativeArViewerPlatform {
  @visibleForTesting
  final methodChannel = const MethodChannel('native_ar_viewer');

  @override
  Future<bool?> launchAR(String url) async {
    var data = Uri.parse("https://arvr.google.com/scene-viewer/1.0").replace(
        queryParameters: <String, dynamic>{'file': url, 'mode': 'ar_only'});

    return await methodChannel.invokeMethod<bool>('launchAR',
        Platform.isAndroid ? <String, dynamic>{'data': data.toString()} : url);
  }
}
