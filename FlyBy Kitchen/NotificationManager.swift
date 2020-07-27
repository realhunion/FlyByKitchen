//
//  NotificationManager.swift
//  FlyBy Kitchen
//
//  Created by Hunain Ali on 7/21/20.
//  Copyright © 2020 BUMP. All rights reserved.
//

import Foundation
import FirebaseAuth

class NotificationManager {
    
    
    static let shared = NotificationManager()
    
    
    
    func isEnabled(completion: @escaping (Bool) -> ()) {
        
        let center  = UNUserNotificationCenter.current()
        center.getNotificationSettings { (settings) in
            if settings.authorizationStatus == .notDetermined {
                print("notif not determined")
                self.presentEnableNotificationsView()
                completion(false)
            }
            else {
                print("notif allowed")
                completion(true)
            }
        }
        
        
    }
    
    
    func presentEnableNotificationsView() {
        
        //FIX Temp: Better wording.
        let alert = UIAlertController(title: "Receive a notification on new orders?", message: "Option can be disabled in settings.", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { action in
            DispatchQueue.main.async {
                UNUserNotificationCenter.current()
                    .requestAuthorization(options: [.alert, .sound, .badge]) {
                        granted, error in
                        
                        print("Permission granted: \(granted)")
                        guard granted else { return }
                }
            }
        }))
        
        DispatchQueue.main.async {
            UIApplication.topViewController()?.present(alert, animated: true)
        }
    }
    
    func presentEnableSettingsNotifications() {
        
        let alert = UIAlertController(title: "Turn on notifs a notification on new orders?", message: "Option can be disabled in settings.", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { action in
            DispatchQueue.main.async {
                UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!, options: [:], completionHandler: nil)
            }
        }))
        
        DispatchQueue.main.async {
            UIApplication.topViewController()?.present(alert, animated: true)
        }
        
    }
    
    
    
    
    // MARK:- Actionable Notifications
    
    
    
}
