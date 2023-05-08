//
//  ViewController.swift
//  Project21.1
//
//  Created by Maks Vogtman on 01/02/2023.
//

import UserNotifications
import UIKit

class ViewController: UIViewController, UNUserNotificationCenterDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Register", style: .plain, target: self, action: #selector(registerLocal))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Schedule", style: .plain, target: self, action: #selector(scheduleLocal))
        
    }

    
    @objc func registerLocal() {
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert, .badge, .sound]) { granted, error in
            if granted {
                print("Yaay!")
            } else {
                print("D'oh!")
            }
        }
    }
    
    
    @objc func scheduleLocal() {
        registerCategories()
        
        let center = UNUserNotificationCenter.current()
        center.removeAllPendingNotificationRequests()
        
        let content = UNMutableNotificationContent()
        content.title = "Late wake up call"
        content.body = "The early bird catches the worm, but the second mouse gets the cheese."
        content.categoryIdentifier = "alarm"
        content.userInfo = ["customData": "fizzbuzz"]
        content.sound = .default
        
        var dateComponents = DateComponents()
        dateComponents.hour = 10
        dateComponents.minute = 30
//        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        let secondTrigger = UNTimeIntervalNotificationTrigger(timeInterval: 86400, repeats: true)
        
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        let secondRequest = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: secondTrigger)
        
        center.add(request)
        center.add(secondRequest)
    }
    
    
    func registerCategories() {
        let center = UNUserNotificationCenter.current()
        center.delegate = self
        
        let show = UNNotificationAction(identifier: "show", title: "Show me more...", options: .foreground)
        let remind = UNNotificationAction(identifier: "remind", title: "Remind me later", options: .foreground)
        let category = UNNotificationCategory(identifier: "alarm", actions: [show, remind], intentIdentifiers: [])
        
        center.setNotificationCategories([category])
    }
    
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        
        let userInfo = response.notification.request.content.userInfo
        
        if let customData = userInfo["customData"] as? String {
            print("Custom data received: \(customData)")
        }
        
        switch response.actionIdentifier {
        case UNNotificationDefaultActionIdentifier:
            print("Default identifier")
        
        case "show":
            let ac = UIAlertController(title: "Detail info", message: "Click \("Show") to see more details.", preferredStyle: .actionSheet)
            ac.addAction(UIAlertAction(title: "Show", style: .default, handler: { [weak self] _ in self?.scheduleLocal() }))
            ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
            present(ac, animated: true)
            
        case "remind":
            let ac = UIAlertController(title: "Remind later", message: "Remind later about this notification.", preferredStyle: .actionSheet)
            ac.addAction(UIAlertAction(title: "Remind", style: .default, handler: { [weak self] _ in self?.scheduleLocal() }))
            ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
            present(ac, animated: true)
            
        default:
            break
        }
        
        completionHandler()
    }
}

