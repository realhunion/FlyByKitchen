//
//  EditMenu+Edit.swift
//  FlyBy Kitchen
//
//  Created by Hunain Ali on 7/12/20.
//  Copyright © 2020 BUMP. All rights reserved.
//

import UIKit

extension EditMenuVC {
    
    
    @objc func upButtonTapped(button : UIButton) {
        
        let section = button.tag
        
        guard let m = menu else { return }
        let cat = m.getCategoryArray()[section]
        
        self.menu?.moveUpCategory(categoryID: cat.categoryID)
        guard let m2 = menu else { return }
        MenuManager.shared.editMenu(categoryListOrder: m2.categoryListOrder)
        
    }
    
    
    @objc func downButtonTapped(button : UIButton) {

        let section = button.tag
        
        guard let m = menu else { return }
        let cat = m.getCategoryArray()[section]
        
        self.menu?.moveDownCategory(categoryID: cat.categoryID)
        guard let m2 = menu else { return }
        MenuManager.shared.editMenu(categoryListOrder: m2.categoryListOrder)
        
    }
    
    
    @objc func plusButtonTapped(button : UIButton) {
        
        let section = button.tag
        
        guard let m = menu else { return }
        let cat = m.getCategoryArray()[section]
        
        MenuManager.shared.addMenuItem(categoryID: cat.categoryID)
        
    }
    
    @objc func editButtonTapped(button : UIButton) {
        
        guard let m = menu else { return }
        let cat = m.getCategoryArray()[button.tag]
        
        let alert = UIAlertController(title: "Edit Category Name:", message: nil, preferredStyle: .alert)
        
        alert.addTextField { (textField) in
            textField.placeholder = "Ex: Appetizer"
            textField.text = cat.title
        }
        
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { action in
            guard let newCategory = alert.textFields?.first?.text else { return }
            
            MenuManager.shared.editCategory(categoryID: cat.categoryID, title: newCategory, itemListOrder: nil)
            
        }))
        
        alert.addAction(UIAlertAction(title: "Delete Category", style: .destructive, handler: { action in
            
            self.deleteCategoryConfirmation(categoryID: cat.categoryID)
            
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { action in}))
        
        self.present(alert, animated: true, completion: nil)
        
    }
    
    func deleteCategoryConfirmation(categoryID : String) {
        
        
        let alert = UIAlertController(title: "Are you sure you want to delete this category?", message: nil, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Yes", style: .destructive, handler: { action in
            MenuManager.shared.deleteCategory(categoryID: categoryID)
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { action in}))
        
        self.present(alert, animated: true, completion: nil)
        
    }
    
    
    
    
    
}




