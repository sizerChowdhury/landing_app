import UIKit
import Flutter

@main
@objc class AppDelegate: FlutterAppDelegate {
    private let CHANNEL = "com.example.destination_app/deep_link"

    override func application(
        _ application: UIApplication,
        open url: URL,
        options: [UIApplication.OpenURLOptionsKey : Any] = [:]
    ) -> Bool {
        let message = url.queryParameters?["message"] ?? "No message received"

        let controller = window?.rootViewController as! FlutterViewController
        let methodChannel = FlutterMethodChannel(name: CHANNEL, binaryMessenger: controller.binaryMessenger)
        methodChannel.invokeMethod("passMessage", arguments: message)

        return super.application(application, open: url, options: options)
    }

    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        GeneratedPluginRegistrant.register(with: self)
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
}

extension URL {
    var queryParameters: [String: String]? {
        var params = [String: String]()
        guard let queryItems = URLComponents(string: absoluteString)?.queryItems else { return nil }
        for item in queryItems {
            params[item.name] = item.value
        }
        return params
    }
}
