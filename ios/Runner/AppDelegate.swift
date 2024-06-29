import UIKit
import Flutter
import SQLite

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    let controller: FlutterViewController = window?.rootViewController as! FlutterViewController
    let incrementChannel = FlutterMethodChannel(name: "com.filio.increment",
                                                binaryMessenger: controller.binaryMessenger)
    incrementChannel.setMethodCallHandler { (call: FlutterMethodCall, result: @escaping FlutterResult) in
        if call.method == "incrementCounter" {
            FilioDatabase.shared.incrementCounter()
            result("Counter incremented")
        } else if call.method == "getCurrentCounter" {
            let currentCounter = FilioDatabase.shared.getCurrentCounter()
            result(currentCounter)
        } else {
            result(FlutterMethodNotImplemented)
        }
    }

    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }

// we are using applicationWillTerminate for when the app is terminated it incrementCounter the value
  override func applicationWillTerminate(_ application: UIApplication) {
    FilioDatabase.shared.incrementCounter()
  }
}
