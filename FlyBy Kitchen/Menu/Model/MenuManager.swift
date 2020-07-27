//
//  MenuSetter.swift
//  FlyBy Kitchen
//
//  Created by Hunain Ali on 7/12/20.
//  Copyright © 2020 BUMP. All rights reserved.
//

import Foundation
import Firebase

class MenuManager {
    
    static let shared : MenuManager = MenuManager()
    
    var db : Firestore = Firestore.firestore()
    
    
    
    
    
    //MARK: - EDIT CATEGORY
    
    func editMenu(categoryListOrder : [String]) {
        
        guard let myUID = Auth.auth().currentUser?.uid else { return }
        
        db.collection("Restaurants").document(myUID).collection("Menu").document("Menu").setData(["categoryListOrder":categoryListOrder])
        
    }
    
    
    
    
    //MARK: - EDIT CATEGORY
    
    
    func addCategory(categoryTitle : String) {
        
        guard let myUID = Auth.auth().currentUser?.uid else { return }
        
        let batch = db.batch()
        
        let payload1 = ["createdAt":Timestamp(date: Date()),
                       "typeOf":"category",
                       "title":categoryTitle,
                       "itemListOrder":[]
            ] as [String : Any]
        let ref1 = db.collection("Restaurants").document(myUID).collection("Menu").document()
        batch.setData(payload1, forDocument: ref1)
        
        
        let payload2 = ["categoryListOrder":FieldValue.arrayUnion([ref1.documentID])
            ] as [String : Any]
        let ref2 = db.collection("Restaurants").document(myUID).collection("Menu").document("Menu")
        batch.setData(payload2, forDocument: ref2, merge: true)
        
        batch.commit()
        
    }
    
    
    func editCategory(categoryID : String, title : String?, itemListOrder : [String]?) {
        
        guard let myUID = Auth.auth().currentUser?.uid else { return }
        
        var payload = [:] as [String : Any]
        if let t = title {
            payload["title"] = t
        }
        if let i = itemListOrder {
            payload["itemListOrder"] = i
        }
        
        self.db.collection("Restaurants").document(myUID).collection("Menu").document(categoryID).setData(payload, merge: true)
        
    }
    
    func deleteCategory(categoryID : String) {
        
        guard let myUID = Auth.auth().currentUser?.uid else { return }
        
        self.db.collection("Restaurants").document(myUID).collection("Menu").document(categoryID).getDocument { (snap, err) in
            guard let doc = snap else { return }
            
            var deletionRefArray : [DocumentReference] = []
            if let itemOrderList = doc.data()?["itemListOrder"] as? [String] {
                
                itemOrderList.forEach { (itemID) in
                    let itemRef = self.db.collection("Restaurants").document(myUID).collection("Menu").document(itemID)
                    deletionRefArray.append(itemRef)
                }
            }
            
            let catRef = self.db.collection("Restaurants").document(myUID).collection("Menu").document(categoryID)
            deletionRefArray.append(catRef)
            
            let batch = self.db.batch()
            for ref in deletionRefArray {
                batch.deleteDocument(ref)
            }
            
            let menuRef = self.db.collection("Restaurants").document(myUID).collection("Menu").document("Menu")
            batch.updateData(["categoryListOrder":FieldValue.arrayRemove([categoryID])], forDocument: menuRef)
            
            batch.commit()
            
        }
        
    }
    
    
    
    
    
    
    //MARK: - EDIT MENU ITEM
    
    
    func addMenuItem(categoryID : String) {
        
        guard let myUID = Auth.auth().currentUser?.uid else { return }
        
        let batch = db.batch()
        
        let payload1 = ["createdAt":Timestamp(date: Date()),
                        "typeOf":"item",
                        "categoryID":categoryID,
                        "title": "Sample Item - Tap To Edit",
                        "description": "",
                        "price":0.0,
            ] as [String : Any]
        let ref1 = db.collection("Restaurants").document(myUID).collection("Menu").document()
        batch.setData(payload1, forDocument: ref1)
        
        
        let payload2 = ["itemListOrder":FieldValue.arrayUnion([ref1.documentID])
            ] as [String : Any]
        let ref2 = db.collection("Restaurants").document(myUID).collection("Menu").document(categoryID)
        batch.setData(payload2, forDocument: ref2, merge: true)
        
        
        batch.commit()
        
    }
    
    
    func editMenuItem(itemID : String, title : String?, description : String?, price : Double?) {
        
        guard let myUID = Auth.auth().currentUser?.uid else { return }
        
        var payload = [:] as [String : Any]
        if let t = title {
            payload["title"] = t
        }
        if let d = description {
            payload["description"] = d
        }
        if let p = price {
            
            payload["price"] = abs(p)
        }
        
        db.collection("Restaurants").document(myUID).collection("Menu").document(itemID).setData(payload, merge: true)
        
    }
    
    
    func deleteMenuItem(itemID : String) {
        
        guard let myUID = Auth.auth().currentUser?.uid else { return }
        
        db.collection("Restaurants").document(myUID).collection("Menu").document(itemID).delete()
        
        self.db.collection("Restaurants").document(myUID).collection("Menu").document(itemID).getDocument { (snap, err) in
            guard let doc = snap else { return }
            
            let batch = self.db.batch()
            
            if let categoryID = doc.data()?["categoryID"] as? String {
                
                let catRef = self.db.collection("Restaurants").document(myUID).collection("Menu").document(categoryID)
                batch.setData(["itemListOrder":FieldValue.arrayRemove([itemID])], forDocument: catRef)
            }
            
            
            let itemRef = self.db.collection("Restaurants").document(myUID).collection("Menu").document(itemID)
            batch.deleteDocument(itemRef)
            
            
            batch.commit()
            
        }
        
    }
    
    
    
    
    
    
    //MARK: - TOOL
    
    func generateUnix() -> Int {
        
        let t = Date().millisecondsSince1970
        return Int(t)
        
    }
    
    
}
