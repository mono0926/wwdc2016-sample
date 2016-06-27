//
//  NotificationSamplesViewController.swift
//  wwdc2016-sample
//
//  Created by OnoMasayuki on 6/26/16.
//  Copyright © 2016 mono. All rights reserved.
//

import Foundation
import UIKit
import UserNotifications

class NotificationSamplesViewController: UITableViewController {
    
    private var lastLocalNotificationIdentifier: String?
    
    @IBAction func timeInterval5secDidTap(_ sender: UIButton) {
        addTimeIntervalNotificationRequest(timeInterval: 5)
    }
    @IBAction func timeInterval1minDidTap(_ sender: UIButton) {
        addTimeIntervalNotificationRequest(timeInterval: 60)
    }
    @IBAction func getPendingNotificaitonRequestDidTap(_ sender: UIButton) {
        guard #available(iOS 10.0, *) else {
            return
        }
        let center = UNUserNotificationCenter.current()
        center.getPendingNotificationRequests { requests in
            for r in requests {
                print("PendingNotificationRequest: \(r)")
            }
        }
    }
    @IBAction func removeLastLocalNotificationDidTap(_ sender: UIButton) {
        guard #available(iOS 10.0, *) else {
            return
        }
        if let identifier = lastLocalNotificationIdentifier {
            let center = UNUserNotificationCenter.current()
            center.removePendingNotificationRequests(withIdentifiers: [identifier])
        }
    }
    @IBAction func removeAllLocalNotificationsDidTap(_ sender: UIButton) {
        guard #available(iOS 10.0, *) else {
            return
        }
        let center = UNUserNotificationCenter.current()
        center.removeAllPendingNotificationRequests()
    }
    @IBAction func getDeliveredNotificationDidTap(_ sender: UIButton) {
        guard #available(iOS 10.0, *) else {
            return
        }
        let center = UNUserNotificationCenter.current()
        center.getDeliveredNotifications { notifications in
            for n in notifications {
                print("DeliveredNotifications: \(n)")
            }
        }
    }
    @IBAction func removeLastDeliveredNotificationDidTap(_ sender: UIButton) {
        guard #available(iOS 10.0, *) else {
            return
        }
        let center = UNUserNotificationCenter.current()
        center.getDeliveredNotifications { notifications in
            if let n = notifications.first {
                center.removeDeliveredNotifications(withIdentifiers: [n.request.identifier])
            }
        }
    }
    @IBAction func removeAllDeliveredNotificationsDidTap(_ sender: UIButton) {
        guard #available(iOS 10.0, *) else {
            return
        }
        let center = UNUserNotificationCenter.current()
        center.removeAllDeliveredNotifications()
    }
    private func addTimeIntervalNotificationRequest(timeInterval: TimeInterval) {
        guard #available(iOS 10.0, *) else {
            return
        }
        let content = UNMutableNotificationContent()
        content.title = "title"
        content.body = "body"
        content.sound = UNNotificationSound.default()
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: timeInterval, repeats: false)
        let identifier = "time_interval_\(NSDate())"
        lastLocalNotificationIdentifier = identifier
        let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
        let center = UNUserNotificationCenter.current()
        center.add(request) { error in
            print("error: \(error)")
        }
    }
}
