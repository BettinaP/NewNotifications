//
//  NotificationViewController.swift
//  myContentExtension
//
//  Created by Bettina on 3/21/17.
//  Copyright © 2017 Bettina Prophete. All rights reserved.
//

import UIKit
import UserNotifications
import UserNotificationsUI

class NotificationViewController: UIViewController, UNNotificationContentExtension {
    
    
    @IBOutlet var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any required interface initialization here.
    }
    
    func didReceive(_ notification: UNNotification) {
        
        //taking first attachment out of notifications array and assigning it to this attachment variable
        guard let attachment = notification.request.content.attachments.first else {
            
            return
        }
        
        if attachment.url.startAccessingSecurityScopedResource() {
            //when creating notif extension, they're not sandboxed in your app, your app can be closed out and when you receive notification it's operating outside your app sandbox so use .startAccessingSecurityScopredResource
            
            let imageData = try? Data.init(contentsOf: attachment.url)
            if let img = imageData{
                imageView.image = UIImage(data: img)
            }
        }
    }
    
}
