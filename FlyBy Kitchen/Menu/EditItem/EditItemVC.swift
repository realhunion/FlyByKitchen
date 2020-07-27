//
//  EditItemVC.swift
//  FlyBy Kitchen
//
//  Created by Hunain Ali on 7/11/20.
//  Copyright © 2020 BUMP. All rights reserved.
//

import UIKit

enum EditItemProperty : String {
    case title = "Edit Title"
    case description = "Edit Description"
    case price = "Edit Price"
    case delete = ""
}

class EditItemVC: UITableViewController {
    
    var item : MenuItem!
    
    var itemProperties : [EditItemProperty] = [.title, .description, .price, .delete]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.register(UITableViewCell.classForCoder(), forCellReuseIdentifier: "editItemCell")
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return itemProperties.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return itemProperties[section].rawValue
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "editItemCell", for: indexPath)
        
        let edit = itemProperties[indexPath.section]
        
        cell.textLabel?.textColor = UIColor.label
        cell.textLabel?.font = UIFont.preferredFont(forTextStyle: .body)
        cell.accessoryType = .none
        cell.textLabel?.numberOfLines = 99
        
        if edit == .title {
            cell.textLabel?.text = self.item?.title
        }
        if edit == .description {
            cell.textLabel?.text = self.item?.description
        }
        if edit == .price {
            cell.textLabel?.text = "$\(self.item.price)"
        }
        if edit == .delete {
            cell.textLabel?.text = "Delete"
            cell.textLabel?.textColor = UIColor.red
            cell.textLabel?.font = UIFont.preferredFont(forTextStyle: .headline)
            cell.accessoryType = .none
        }

        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let edit = itemProperties[indexPath.section]
        
        if edit == .title {
            self.editTitle()
        }
        
        if edit == .description {
            self.editDescription()
        }
        
        if edit == .price {
            self.editPrice()
        }
        
        if edit == .delete {
            self.deleteItem()
        }
        
    }
    

}
