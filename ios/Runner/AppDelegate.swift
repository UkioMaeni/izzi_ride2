import Flutter
import UIKit
import GoogleMaps
import flutter_bg_location_plugin
@main
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GMSServices.provideAPIKey("AIzaSyDQ2a3xgarJk8qlNGzNCLzrH3H_XmGSUaY")
    GeneratedPluginRegistrant.register(with: self)
    _=VoIPPushRegistryHandler.shared
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
