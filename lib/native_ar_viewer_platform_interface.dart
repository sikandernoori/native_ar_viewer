import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'native_ar_viewer_method_channel.dart';

abstract class NativeArViewerPlatform extends PlatformInterface {
  NativeArViewerPlatform() : super(token: _token);

  static final Object _token = Object();

  static NativeArViewerPlatform _instance = MethodChannelNativeArViewer();

  static NativeArViewerPlatform get instance => _instance;

  static set instance(NativeArViewerPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<bool?> launchAR(String url);
}
