//
//  ViewController.swift
//  NewNotifications
//
//  Created by Bettina on 3/21/17.
//  Copyright © 2017 Bettina Prophete. All rights reserved.
//

import UIKit
import UserNotifications

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 1. REQUEST PERMISSION
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { (granted, error) in
            //set up a button
            
            if granted {
                print("Notification access granted")
            } else {
                print(error?.localizedDescription)
            }
            
        }
        
    }
    
    @IBAction func notifyButtonTapped(sender: UIButton) {
        scheduleNotification(inSeconds: 5) { (success) in
            if success {
                print("successfully sched notif")
                
            } else {
                print("error sched notif")
            }
        }
    }
    
    func scheduleNotification(inSeconds: TimeInterval, completion: @escaping (_ Success: Bool) -> ()) {
        
        // add in attachment
        
        // let myImage = UIImage(named: "getFit")
        //guard let imageURL = Bundle.main.url(forResource:"getFit", withExtension: "jpeg") else { completion(false); return }
        
        //if i were to add a gif or other media that's been added to project
        // guard let imageURL = Bundle.main.url(forResource:image, with Extension: "gif") else { completion(Success:false) return }
        
        let rihImage = "rihanna_giphy"
        guard let imageURL = Bundle.main.url(forResource: rihImage, withExtension: "gif") else { completion(false)
            return
        }
        
        var attachment: UNNotificationAttachment
        
        attachment = try! UNNotificationAttachment(identifier: "myNotification", url: imageURL, options: .none)
        
        // create notification
        let notif = UNMutableNotificationContent()
        
        //ONLY FOR EXTENSION
        notif.categoryIdentifier = "myNotificationCategory"
        
        
        notif.title = "New Notification"
        notif.subtitle = "These are great!"
        notif.body = "The new notification options in iOS 10 are awesome!"
        notif.attachments = [attachment]
        
        let notifTrigger = UNTimeIntervalNotificationTrigger(timeInterval: inSeconds, repeats: false)
        
        let request = UNNotificationRequest(identifier: "myNotification", content: notif, trigger: notifTrigger)
        
        UNUserNotificationCenter.current().add(request) { (error) in
            if error != nil {
                print(error)
                completion(false)
            } else {
                completion(true)
            }
        }
        
    }
    
    
    
    
}

