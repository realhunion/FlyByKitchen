//
//  LoginVerifier.swift
//  BUMP
//
//  Created by Hunain Ali on 11/8/19.
//  Copyright © 2019 BUMP. All rights reserved.
//

import Foundation
import Firebase
import SwiftEntryKit
import QuickLayout

class LoginManager {
    
    static let shared = LoginManager()
    
    let db = Firestore.firestore()
    
    
    func isLoggedIn() -> Bool {
        
        guard Auth.auth().currentUser != nil else {
            return false
        }
        
        return true
    }
    
    
    
    //LOGIN OR LOGOUT
    
    func shutDownControllers() {
        
        SwiftEntryKit.dismiss(.all, with: nil)
        
        if let hVC = UIApplication.topViewController()?.tabBarController as? HomeTabBarVC {
            hVC.shutDown()
            
        }
        
    }
    
    
    
    func logOut() {
        
        guard let myUID = Auth.auth().currentUser?.uid else { return }
        
        let batch = db.batch()
        
        let ref = db.collection("Restaurant-Base").document(myUID)
        
        batch.setData(["fcmToken": FieldValue.delete()], forDocument: ref, merge: true)
        
        batch.commit { (err) in
            guard err == nil else { return }
            
            do {
                try Auth.auth().signOut()
            } catch let signOutError as NSError {
                print ("Error signing out: %@", signOutError)
            }
            
            self.shutDownControllers()
            (UIApplication.shared.delegate as! AppDelegate).refreshApp()
        }
    }
    
    func logIn() {
        
        self.shutDownControllers()
        (UIApplication.shared.delegate as! AppDelegate).refreshApp()
        
    }
    
    
    func updateUserBaseFCMToken(fcmToken : String) {
        
        guard let myUID = Auth.auth().currentUser?.uid else {
            return
        }
        
        let payload = [ "fcmToken": fcmToken, "typePhone": 1] as [String : Any] //1 is iPhone, 2 is Android
        self.db.collection("User-Base").document(myUID).setData(payload, merge: true) { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
            }
        }
        
    }
    
    
    
    //MARK: - Present
    
    
    
//    func presentIntroInfo() {
//
//        let vc = IntroInfoVC()
//        vc.title = "Quick Run Down"
//        let nvc = UINavigationController(rootViewController: vc)
//
//        nvc.modalPresentationStyle = .pageSheet
//        nvc.presentationController?.delegate = vc
//        if #available(iOS 13.0, *) {
//            nvc.isModalInPresentation = true
//        } else {
//            // Fallback on earlier versions
//        }
//
//        vc.onDismissAction = { [unowned self] in
//            self.isLoggedIn()
//        }
//
//        DispatchQueue.main.async {
//            UIApplication.topViewController()?.present(nvc, animated: true) {}
//        }
//
//    }
    
    
    
}
