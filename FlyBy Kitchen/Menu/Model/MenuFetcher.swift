//
//  MenuFetcher.swift
//  FlyBy Kitchen
//
//  Created by Hunain Ali on 7/11/20.
//  Copyright © 2020 BUMP. All rights reserved.
//

import Foundation
import Firebase

protocol MenuFetcherDelegate : class {
    func menuUpdated(menu: Menu)
}

class MenuFetcher {
    
    var db = Firestore.firestore()
    
    var listener : ListenerRegistration?
    
    weak var delegate : MenuFetcherDelegate?
    
    init() {
        
    }
    
    func shutDown() {
        if let listenr = listener {
            listenr.remove()
        }
    }
    
    
    func startMonitor() {
        
        guard let myUID = Auth.auth().currentUser?.uid else { return }
        
        self.listener = db.collection("Restaurants").document(myUID).collection("Menu").addSnapshotListener { (snap, err) in
            guard let docs = snap?.documents else { return }
            
            var itemArray : [MenuItem] = []
            var catArray : [MenuCategory] = []
            
            for doc in docs {
                if let typeOf = doc.data()["typeOf"] as? String,
                    typeOf == "item",
                    let categoryID = doc.data()["categoryID"] as? String,
                    let title = doc.data()["title"] as? String,
                    let description = doc.data()["description"] as? String,
                    let price = doc.data()["price"] as? Double,
                    let createdAt = doc.data()["createdAt"] as? Timestamp {
                    
                    let item = MenuItem(createdAt: createdAt, itemID: doc.documentID, categoryID: categoryID, title: title, description: description, price: price)
                    itemArray.append(item)
                    
                }
            }
            
            for doc in docs {
                if let typeOf = doc.data()["typeOf"] as? String,
                    typeOf == "category",
                    let title = doc.data()["title"] as? String,
                    let createdAt = doc.data()["createdAt"] as? Timestamp,
                    let itemListOrder = doc.data()["itemListOrder"] as? [String] {
                    
                    let cat = MenuCategory(createdAt: createdAt, categoryID: doc.documentID, title: title, itemListOrder: itemListOrder)
                    catArray.append(cat)
                    
                }
            }
            
            guard let menuDoc = docs.first(where: {$0.documentID == "Menu"}), let categoryListOrder = menuDoc.data()["categoryListOrder"] as? [String] else { return }
            
            let menu = Menu(categoryListOrder: categoryListOrder, categoryArray: catArray, itemArray: itemArray)
            self.delegate?.menuUpdated(menu: menu)
            
        }
        
    }
    
    
    
    
}
