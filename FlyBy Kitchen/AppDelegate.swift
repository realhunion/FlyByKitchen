//
//  AppDelegate.swift
//  FlyBy Kitchen
//
//  Created by Hunain Ali on 7/10/20.
//  Copyright © 2020 BUMP. All rights reserved.
//

import UIKit
import Firebase
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var db : Firestore!
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions:
        [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        application.registerForRemoteNotifications()
        self.registerForPushNotifications()
        
//        self.registerNotificationActionButtons()
        
        self.configureMyFirebase()
        Messaging.messaging().delegate = self
        
//         Override point for customization after application launch.
//        window = UIWindow(frame: UIScreen.main.bounds)
//        window?.rootViewController = self.flybyKitchen?.homeVC
        //        window?.makeKeyAndVisible()
        
        window = UIWindow(frame: UIScreen.main.bounds)
        self.refreshApp()
        
//        if LoginManager.shared.isLoggedIn() {}
//
        
        return true
    }

    
    
    
    
    
    func configureMyFirebase() {
        FirebaseApp.configure()
        let settings = FirestoreSettings()
        settings.isPersistenceEnabled = false
        self.db = Firestore.firestore()
        Firestore.firestore().settings = settings
    }
    
    
    
    
    
    
    func refreshApp() {
        
        if LoginManager.shared.isLoggedIn() {
            
            if let token = Messaging.messaging().fcmToken {
                self.updateUserBaseFCMToken(fcmToken: token)
            }
            
            window = UIWindow(frame: UIScreen.main.bounds)
            window?.rootViewController = HomeTabBarVC()
            window?.makeKeyAndVisible()
            
        } else {
            
            window = UIWindow(frame: UIScreen.main.bounds)
            window?.rootViewController = LoginVC()
            window?.makeKeyAndVisible()
            
        }
        
    }

}









extension AppDelegate : UNUserNotificationCenterDelegate, MessagingDelegate {
    
    //Actionable Push Notification
    func registerNotificationActionButtons() {
        
        let followAction = UNNotificationAction(identifier: "followAction", title: "Follow Chat", options: UNNotificationActionOptions.init())
        let silenceAction = UNNotificationAction(identifier: "silenceAction", title: "Silence for 1 hour", options: UNNotificationActionOptions.init())
        
        let launchNotifCategory = UNNotificationCategory(identifier: "launchNotif", actions: [followAction, silenceAction], intentIdentifiers: [], hiddenPreviewsBodyPlaceholder: "", options: .customDismissAction)
        
        
        let unFollowAction = UNNotificationAction(identifier: "unFollowAction", title: "Unfollow Chat", options: UNNotificationActionOptions.init())
        
        let replyNotifCategory = UNNotificationCategory(identifier: "replyNotif", actions: [unFollowAction, silenceAction], intentIdentifiers: [], hiddenPreviewsBodyPlaceholder: "", options: .customDismissAction)
        
        UNUserNotificationCenter.current().setNotificationCategories([launchNotifCategory, replyNotifCategory])
    }
    
    func registerForPushNotifications() {
        
        UNUserNotificationCenter.current().delegate = self
        NotificationManager.shared.isEnabled { (isTrue) in
            //
        }
        
    }
    
    
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String) {
        print("**** New Token Generated***\(fcmToken)***")
        self.updateUserBaseFCMToken(fcmToken: fcmToken)
        
    }
    
    func updateUserBaseFCMToken(fcmToken : String) {
        
        print("drose 0")
        
        guard let myUID = Auth.auth().currentUser?.uid else {
            return
        }
        
        print("drose 0.5")
        
        let payload = [ "fcmToken": fcmToken] as [String : Any] //1 is iPhone, 2 is Android
        self.db.collection("Restaurant-Base").document(myUID).setData(payload, merge: true) { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
                print("drose 1")
            }
        }
        
    }
    
    
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
    }
    
    
    
}

