import Flutter
import UIKit
import FirebaseCore

@main
@objc class AppDelegate: FlutterAppDelegate {
  var backgroundTaskIdentifier: UIBackgroundTaskIdentifier = UIBackgroundTaskIdentifier.invalid

  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    FirebaseApp.configure()
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }

  override func applicationDidEnterBackground(_ application: UIApplication) {
    backgroundTaskIdentifier = UIApplication.shared.beginBackgroundTask(withName: "Background Task") {
      if self.backgroundTaskIdentifier != UIBackgroundTaskIdentifier.invalid {
        UIApplication.shared.endBackgroundTask(self.backgroundTaskIdentifier)
        self.backgroundTaskIdentifier = UIBackgroundTaskIdentifier.invalid
      }
    }
  }

  override func applicationWillEnterForeground(_ application: UIApplication) {
    UIApplication.shared.endBackgroundTask(backgroundTaskIdentifier)
  }
}