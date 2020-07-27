//
//  OrdersFetcher.swift
//  FlyBy Kitchen
//
//  Created by Hunain Ali on 7/12/20.
//  Copyright © 2020 BUMP. All rights reserved.
//

import Foundation
import Firebase


protocol OrdersFetcherDelegate : class {
    func ordersUpdated(orderArray : [Order])
}


class OrdersFetcher {
    
    var db = Firestore.firestore()
    
    weak var listener : ListenerRegistration?
    
    weak var delegate : OrdersFetcherDelegate?
    
    init() {
        
    }
    
    func shutDown() {
        if let listenr = listener {
            listenr.remove()
        }
    }
    
    
    func startMonitor() {
        
        guard let myUID = Auth.auth().currentUser?.uid else { return }
        
        self.listener = db.collection("Restaurants").document(myUID).collection("Orders").order(by: "timestamp", descending: true).limit(to: 40).addSnapshotListener { (snap, err) in
            
            guard let docs = snap?.documents else { return }
            
            var orderArray : [Order] = []
            
            for doc in docs {
                if let timestamp = doc.data()["timestamp"] as? Timestamp,
                    let totalPrice = doc.data()["totalPrice"] as? Double,
                    let table = doc.data()["table"] as? String,
                    let itemArray = doc.data()["itemArray"] as? [String] {
                    
                    let order = Order(id: doc.documentID, timestamp: timestamp, totalPrice: totalPrice, table: table, itemArray: itemArray)
                    orderArray.append(order)
                    
                }
            }
            
            self.delegate?.ordersUpdated(orderArray: orderArray)
            
        }
    }
    
    
    
}
