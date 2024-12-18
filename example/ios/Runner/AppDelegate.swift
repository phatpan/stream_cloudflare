import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        GeneratedPluginRegistrant.register(with: self)

        if let registrar = self.registrar(forPlugin: "stream_cloudflare") {
            StreamCloudflarePlugin.register(with: registrar)
        }

        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
}
