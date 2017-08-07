//
// AppDelegate.swift
// iOS-on-boarding
//
// Created by SAP Cloud Platform SDK for iOS Assistant application on 18/07/17
//

import SAPFiori
import SAPFoundation
import SAPCommon
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UISplitViewControllerDelegate, UNUserNotificationCenterDelegate {

    var window: UIWindow?

    private let logger = Logger.shared(named: "AppDelegateLogger")
    var espmContainer: ESPMContainerDataAccess! {
        get {
            return ESPMService.shared.espmContainer
        }
    }

    func applicationDidFinishLaunching(_ application: UIApplication) {
        UINavigationBar.applyFioriStyle()
    }
    
    // MARK: - Split view
    
    func splitViewController(_ splitViewController: UISplitViewController, collapseSecondary secondaryViewController: UIViewController, onto primaryViewController: UIViewController) -> Bool {
        guard let secondaryAsNavController = secondaryViewController as? UINavigationController else { return false }
        guard let topAsMasterController = secondaryAsNavController.topViewController as? MasterViewController else { return false }
        // Without this, on iPhone the main screen is the detailview and the masterview can not be reached.
        if (topAsMasterController.collectionType == .none) {
            // Return true to indicate that we have handled the collapse by doing nothing; the secondary controller will be discarded.
            return true
        }
        
        return false
    }
    
    // MARK: - Remote Notification handling
    
    func application(_ application: UIApplication, willFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]? = nil) -> Bool {
        UIApplication.shared.registerForRemoteNotifications()
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert, .badge, .sound]) { granted, error in
            // Enable or disable features based on authorization.
        }
        center.delegate = self
        return true
    }
    
    // Called to let your app know which action was selected by the user for a given notification.
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping() -> Void) {
        print("App opened via user selecting notification: \(response.notification.request.content.body)")
        // Here is where you want to take action to handle the notification, maybe navigate the user to a given screen.
        completionHandler()
    }
    
    // Called when a notification is delivered to a foreground app.
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping(UNNotificationPresentationOptions) -> Void) {
        print("Remote Notification arrived while app was in forground: \(notification.request.content.body)")
        // Currently we are presenting the notification alert as the application were in the backround.
        // If you have handled the notification and do not want to display an alert, call the completionHandle with empty options: completionHandler([])
        completionHandler([.alert, .sound])
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        ESPMService.shared.deviceToken = deviceToken
    }
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print("Failed to register for Remote Notification Error: \(error.localizedDescription)")
    }
    
}
