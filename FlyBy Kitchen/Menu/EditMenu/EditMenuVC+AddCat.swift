//
//  EditMenu+AddCategory.swift
//  FlyBy Kitchen
//
//  Created by Hunain Ali on 7/11/20.
//  Copyright © 2020 BUMP. All rights reserved.
//

import UIKit

extension EditMenuVC {
    
    @objc func addCategoryButtonTapped() {
        
        let alert = UIAlertController(title: "New Category:", message: nil, preferredStyle: .alert)
        
        alert.addTextField { (textField) in
            textField.placeholder = "Ex: Appetizer"
        }
        
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { action in
            guard let categoryTitle = alert.textFields?.first?.text else { return }
            
            MenuManager.shared.addCategory(categoryTitle: categoryTitle)
            
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { action in}))
        
        self.present(alert, animated: true, completion: nil)
        
    }
    
    
    
}
