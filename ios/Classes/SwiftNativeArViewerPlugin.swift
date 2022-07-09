import Flutter
import UIKit
import QuickLook

public class SwiftNativeArViewerPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "native_ar_viewer", binaryMessenger: registrar.messenger())
    let instance = SwiftNativeArViewerPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    if(call.method == "launchAR")
    {
      if let resourceURL = call.arguments as? String {
        if let rootViewController = topViewController() {
          let quickLookVC = QuickLookViewController([resourceURL])
          rootViewController.present(quickLookVC, animated: true)
          result(true)
        }
      }
      result(false)
    }
  }

  private func topViewController() -> UIViewController? {
    let keyWindow = UIApplication.shared.windows.filter {$0.isKeyWindow}.first

    if var topController = keyWindow?.rootViewController {
      while let presentedViewController = topController.presentedViewController {
          topController = presentedViewController
        }
      return topController
    }
    return nil
  }
}
class QuickLookViewController: UIViewController, QLPreviewControllerDataSource {
    
    var urlsOfResources: [String]
    var shownResource: Bool = false
    
    init(_ resourceURLs: [String]) {
        self.urlsOfResources = resourceURLs.map{ "file://\($0)"}
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if !shownResource {
            let previewController = QLPreviewController()
            previewController.dataSource = self
            present(previewController, animated: true)
            shownResource = true
        } else {
            self.dismiss(animated: true)
        }
    }
    
    func numberOfPreviewItems(in controller: QLPreviewController) -> Int {
        return self.urlsOfResources.count
    }
    
    func previewController(_ controller: QLPreviewController, previewItemAt index: Int) -> QLPreviewItem {
        let url = URL(string: self.urlsOfResources[index])!
        return url as QLPreviewItem
    }
}
