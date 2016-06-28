//
//  NotificationViewController.swift
//  NotificationContentExtension
//
//  Created by OnoMasayuki on 6/28/16.
//  Copyright © 2016 mono. All rights reserved.
//

import UIKit
import UserNotifications
import UserNotificationsUI

class NotificationViewController: UIViewController, UNNotificationContentExtension {
    @IBOutlet var label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func didReceive(_ notification: UNNotification) {
        self.label.text = notification.request.content.body
    }
}
