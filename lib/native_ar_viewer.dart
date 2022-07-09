import 'native_ar_viewer_platform_interface.dart';

class NativeArViewer {
  Future<bool?> launchAR(String url) {
    return NativeArViewerPlatform.instance.launchAR(url);
  }
}
