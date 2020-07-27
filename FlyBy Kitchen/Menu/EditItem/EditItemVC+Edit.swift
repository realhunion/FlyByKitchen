//
//  EditItemVC+Edit.swift
//  FlyBy Kitchen
//
//  Created by Hunain Ali on 7/12/20.
//  Copyright © 2020 BUMP. All rights reserved.
//

import UIKit


extension EditItemVC {
    
    func editTitle() {
        
        let alert = UIAlertController(title: "Edit Title:", message: nil, preferredStyle: .alert)
        
        alert.addTextField { (textField) in
            textField.placeholder = "Ex: Cheese Burger"
            textField.text = self.item.title
        }
        
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { action in
            guard let t = alert.textFields?.first?.text else { return }
            guard t != "" else { return }
            
            MenuManager.shared.editMenuItem(itemID: self.item!.itemID, title: t, description: nil, price: nil)
            
            self.item.title = t
            self.tableView.reloadData()
            
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { action in}))
        
        self.present(alert, animated: true, completion: nil)
        
    }
    
    func editDescription() {
        
        let alert = UIAlertController(title: "Edit Description:", message: nil, preferredStyle: .alert)
        
        alert.addTextField { (textField) in
            textField.placeholder = "Ex: w/t Choice of Drink & Choice of Fries or Coleslaw."
            textField.text = self.item.description
        }
        
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { action in
            guard let d = alert.textFields?.first?.text else { return }
            guard d != "" else { return }
            
            MenuManager.shared.editMenuItem(itemID: self.item!.itemID, title: nil, description: d, price: nil)
            
            self.item.description = d
            self.tableView.reloadData()
            
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { action in}))
        
        self.present(alert, animated: true, completion: nil)
        
    }
    
    func editPrice() {
        
        let alert = UIAlertController(title: "Edit Price:", message: nil, preferredStyle: .alert)
        
        alert.addTextField { (textField) in
            textField.placeholder = "Ex: 22"
            textField.keyboardType = .decimalPad
        }
        
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { action in
            guard let p = alert.textFields?.first?.text else { return }
            guard p != "" else { return }
            guard let doubleP = Double(p) else { return }
            
            MenuManager.shared.editMenuItem(itemID: self.item!.itemID, title: nil, description: nil, price: doubleP)
            
            self.item.price = doubleP
            self.tableView.reloadData()
            
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { action in}))
        
        self.present(alert, animated: true, completion: nil)
        
    }
    
    
    func deleteItem() {
        
        let alert = UIAlertController(title: "Confirm Deletion:", message: nil, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: { action in
            
            MenuManager.shared.deleteMenuItem(itemID: self.item.itemID)
            
            self.dismiss(animated: true, completion: nil)
            
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { action in}))
        
        self.present(alert, animated: true, completion: nil)
        
    }
    
    
    
}
