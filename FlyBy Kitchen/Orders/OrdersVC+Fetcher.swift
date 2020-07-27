//
//  OrdersVC+Fetcher.swift
//  FlyBy Kitchen
//
//  Created by Hunain Ali on 7/12/20.
//  Copyright © 2020 BUMP. All rights reserved.
//

import UIKit

extension OrdersVC : OrdersFetcherDelegate {
    
    func setupFetcher() {
        
        self.ordersFetcher = OrdersFetcher()
        self.ordersFetcher?.delegate = self
        self.ordersFetcher?.startMonitor()
        
    }
    
    
    func ordersUpdated(orderArray: [Order]) {
        self.orderArray.removeAll { (oldO) -> Bool in
            if orderArray.contains(where: {$0.id == oldO.id}) {
                return true
            } else {
                return false
            }
        }
        
        self.orderArray.append(contentsOf: orderArray)
        
        self.orderArray.sort { (o1, o2) -> Bool in
            return o1.timestamp.compare(o2.timestamp) == .orderedDescending
        }
        
        self.tableView.reloadData()
    }
    
    
    
    
    
    
    
}
