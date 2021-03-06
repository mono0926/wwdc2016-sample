//
//  AppDelegate.swift
//  wwdc2016-sample
//
//  Created by OnoMasayuki on 6/26/16.
//  Copyright © 2016 mono. All rights reserved.
//

import UIKit
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        // New UserNotifications API (iOS 10-)
        if #available(iOS 10.0, *) {
            let center = UNUserNotificationCenter.current()
            center.delegate = self
            let action = UNNotificationAction(identifier: MyNotificationAction.reply.rawValue, title: "Reply", options: [])
            let category = UNNotificationCategory(identifier: MyNotificationCategory.message.rawValue, actions: [action], minimalActions: [action], intentIdentifiers: [], options: [.customDismissAction])
            center.setNotificationCategories([category])
            center.requestAuthorization([.badge, .alert, .sound]) { granted, error in
                print("granted: \(granted)")
                print("error: \(error)")
                if granted {
                    // same as old API
                    application.registerForRemoteNotifications()
                }
            }
        } else {            
            // Old APIs (-iOS 8-9)
            // depricated: iOS 10.0
            let settings = UIUserNotificationSettings(types: [.badge, .sound, .alert], categories: nil)
            // depricated: iOS 10.0
            application.registerUserNotificationSettings(settings)
        }
        
        return true
    }
    
    // same as old API
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        print("deviceToken: \(deviceToken)")
    }
    
    // depricated: iOS 10.0
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: NSError) {
        print("error: \(error)")
    }
    
    // depricated: iOS 10.0
    func application(_ application: UIApplication, didRegister notificationSettings: UIUserNotificationSettings) {
        application.registerForRemoteNotifications()
    }
    
     // depricated: iOS 10.0
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [NSObject : AnyObject]) {
        print("userInfo: \(userInfo)")
    }
    
    // depricated: iOS 10.0
    func application(_ application: UIApplication, handleActionWithIdentifier identifier: String?, for notification: UILocalNotification, completionHandler: () -> Void) {
    }
}

extension AppDelegate: UNUserNotificationCenterDelegate {
    // Called when the application is in foreground
    @available(iOS 10.0, *)
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: (UNNotificationPresentationOptions) -> Void) {
        print("center: \(center)\nnotification: \(notification)")
        if let trigger = notification.request.trigger {
            switch trigger {
            case let n as UNPushNotificationTrigger:
                print("UNPushNotificationTrigger: \(n)")
            case let n as  UNTimeIntervalNotificationTrigger:
                print("UNTimeIntervalNotificationTrigger: \(n)")
            case let n as  UNCalendarNotificationTrigger:
                print("UNCalendarNotificationTrigger: \(n)")
            case let n as  UNLocationNotificationTrigger:
                print("UNLocationNotificationTrigger: \(n)")
            default:
                assert(false)
                break
            }
        }
        completionHandler([.badge, .alert, .sound])
    }
    // Called when the application is opened by notification
    @available(iOS 10.0, *)
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: () -> Void) {
        print("center: \(center)\nresponse: \(response)")
        let actionIdentifier = response.actionIdentifier
        completionHandler()
    }
}
