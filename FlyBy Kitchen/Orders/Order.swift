//
//  Order.swift
//  FlyBy Kitchen
//
//  Created by Hunain Ali on 7/11/20.
//  Copyright © 2020 BUMP. All rights reserved.
//

import Foundation
import Firebase

struct Order {
    
    var id : String
    
    var timestamp : Timestamp
    var totalPrice : Double
    var table : Int
    var itemArray : [String]
    
    
}
