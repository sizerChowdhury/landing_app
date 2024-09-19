import UIKit
import Flutter

@main
@objc class AppDelegate: FlutterAppDelegate {

    private var deepLinkApi: DeepLinkApi?

    override func application(
        _ application: UIApplication,
        open url: URL,
        options: [UIApplication.OpenURLOptionsKey : Any] = [:]
    ) -> Bool {
        let message = url.queryParameters?["message"] ?? "No message received"

        guard let controller = window?.rootViewController as? FlutterViewController else {
            return super.application(application, open: url, options: options)
        }

        if deepLinkApi == nil {
            deepLinkApi = DeepLinkApi(binaryMessenger: controller.binaryMessenger)
        }

        deepLinkApi?.getMessage(message: message, completion: { result in
            switch result {
            case .success:
                print("Message sent successfully")
            case .failure(let error):
                print("Failed to send message: \(error.localizedDescription)")
            }
        })

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
