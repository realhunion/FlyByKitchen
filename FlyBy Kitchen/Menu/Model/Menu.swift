//
//  MenuItem.swift
//  FlyBy Kitchen
//
//  Created by Hunain Ali on 7/11/20.
//  Copyright © 2020 BUMP. All rights reserved.
//

import Firebase

struct MenuItem {
    
    var createdAt : Timestamp
    
    var itemID : String
    var categoryID : String
    
    var title : String
    var description : String
    var price : Double
    
}


struct MenuCategory {
    
    var createdAt : Timestamp
    
    var categoryID : String
    
    var title : String
    
    var itemListOrder : [String]
}


class Menu {
    
    //Restaurant Name / etc;
    var categoryListOrder : [String]
    var categoryArray : [MenuCategory]
    var itemArray : [MenuItem]
    init(categoryListOrder : [String], categoryArray : [MenuCategory], itemArray : [MenuItem]) {
        self.categoryListOrder = categoryListOrder
        self.categoryArray = categoryArray
        self.itemArray = itemArray
    }
    
    
    func getCategoryArray() -> [MenuCategory] {
        
        var catArray : [MenuCategory] = []
        
        for catID in categoryListOrder {
            
            if let cat = categoryArray.first(where: {$0.categoryID == catID}) {
                catArray.append(cat)
            }
            
        }
        
        return catArray
        
    }
    
    func getItemArray(categoryID : String) -> [MenuItem] {
     
        guard let cat = categoryArray.first(where: {$0.categoryID == categoryID}) else { return [] }

        var iArray : [MenuItem] = []

        for itemID in cat.itemListOrder {

            if let item = itemArray.first(where: {$0.itemID == itemID}) {
         
                iArray.append(item)
            }
            
        }
        return iArray
        
    }
    
    
    //MARK: - MOVE ITEM
    
    func moveUpCategory(categoryID : String) {
        
        guard let oldIndex = self.categoryListOrder.firstIndex(where: {$0 == categoryID}) else { return }
        
        let newIndex = oldIndex-1
        
        if newIndex >= 0 {
            
            let cat = self.categoryListOrder.remove(at: oldIndex)
            self.categoryListOrder.insert(cat, at: newIndex)
            
        }
        
    }
    
    func moveDownCategory(categoryID : String) {
        
        guard let oldIndex = self.categoryListOrder.firstIndex(where: {$0 == categoryID}) else { return }
        
        let newIndex = oldIndex+1
        
        
        if newIndex < categoryArray.count {
            
            let cat = self.categoryListOrder.remove(at: oldIndex)
            self.categoryListOrder.insert(cat, at: newIndex)
            
        }
        
    }
    
    
    
    
    //MARK: - MOVE ITEM
    
    
    func moveItem(beforeCategoryID : String, afterCategoryID : String, afterIndex : Int) {
        
//        guard let beforeCat = self.categoryArray.first(where: {$0.categoryID == beforeCategoryID}) else { return }
//        
//        self.categoryArray.first(where: {$0.categoryID == beforeCategoryID})?.itemListOrder.removeAll(where: {$0. == })
        
        
    }
    
    
}


