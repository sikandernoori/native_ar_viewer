import 'native_ar_viewer_platform_interface.dart';

class NativeArViewer {
  static Future<bool?> launchAR(String url) async {
    return await NativeArViewerPlatform.instance.launchAR(url);
  }
}
