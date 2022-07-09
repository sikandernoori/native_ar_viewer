#import "NativeArViewerPlugin.h"
#if __has_include(<native_ar_viewer/native_ar_viewer-Swift.h>)
#import <native_ar_viewer/native_ar_viewer-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "native_ar_viewer-Swift.h"
#endif

@implementation NativeArViewerPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftNativeArViewerPlugin registerWithRegistrar:registrar];
}
@end
