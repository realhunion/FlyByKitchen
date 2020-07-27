//
//  EditMenuVC+DragDrop.swift
//  FlyBy Kitchen
//
//  Created by Hunain Ali on 7/14/20.
//  Copyright © 2020 BUMP. All rights reserved.
//

import UIKit

extension EditMenuVC : UITableViewDragDelegate, UITableViewDropDelegate {
    
    
    // MARK: - UITableViewDelegate
    
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        
        
        guard let beforeCat = self.menu?.getCategoryArray()[sourceIndexPath.section] else { return }
        guard let beforeCatIndex = self.menu?.categoryArray.firstIndex(where: {$0.categoryID == beforeCat.categoryID}) else { return }
        guard let item = self.menu?.getItemArray(categoryID: beforeCat.categoryID)[sourceIndexPath.row] else { return }
        
        //Take out Item itemArray and remove from itemListorder in its Category.
        self.menu?.itemArray.removeAll(where: {$0.itemID == item.itemID})
        self.menu?.categoryArray[beforeCatIndex].itemListOrder.removeAll(where: {$0 == item.itemID})
        
        guard let newCat = self.menu?.getCategoryArray()[destinationIndexPath.section] else { return }
        guard let newCatIndex = self.menu?.categoryArray.firstIndex(where: {$0.categoryID == newCat.categoryID}) else { return }
        
        //Insert Item itemArray and insert into itemListorder in its Category.
        self.menu?.itemArray.append(item)
        self.menu?.categoryArray[newCatIndex].itemListOrder.insert(item.itemID, at: destinationIndexPath.row)
        
        
        MenuManager.shared.editCategory(categoryID: beforeCat.categoryID, title: nil, itemListOrder: self.menu?.categoryArray[beforeCatIndex].itemListOrder)
        MenuManager.shared.editCategory(categoryID: newCat.categoryID, title: nil, itemListOrder: self.menu?.categoryArray[newCatIndex].itemListOrder)
        
        
    }
    
    
    func tableView(_ tableView: UITableView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
        
        
//        guard let cat = self.menu?.getCategoryArray()[indexPath.section] else { return [] }
//        guard let item = self.menu?.getItemArray(categoryID: cat.categoryID)[indexPath.row] else { return [] }
//
//        let data = item.data(using: .utf8)
//        let itemProvider = NSItemProvider()
//
//        itemProvider.registerDataRepresentation(forTypeIdentifier: kUTTypePlainText as String, visibility: .all) { completion in
//            completion(data, nil)
//            return nil
//        }
//
//        return [
//            UIDragItem(itemProvider: itemProvider)
//        ]
        
        return []
        
    }
    
    func tableView(_ tableView: UITableView, performDropWith coordinator: UITableViewDropCoordinator) {
        //
    }
    
    
}
