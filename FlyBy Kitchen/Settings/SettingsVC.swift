//
//  SettingsVC.swift
//  FlyBy Kitchen
//
//  Created by Hunain Ali on 7/14/20.
//  Copyright © 2020 BUMP. All rights reserved.
//

import UIKit

enum settingsItem : String {
    case logout
}

class SettingsVC: UITableViewController {

    var items : [settingsItem] = [.logout]
    
    
    
    override init(style: UITableView.Style) {
        super.init(style: .grouped)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.tableView.register(UITableViewCell.classForCoder(), forCellReuseIdentifier: "settingsCell")
    }
    
    func shutDown() {
        //
    }
    
    
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "settingsCell", for: indexPath)
        
        let item = self.items[indexPath.row]
        
        cell.textLabel?.textColor = UIColor.label
        cell.accessoryType = .none
        
        if item == .logout {
            cell.textLabel?.text = "Log Out"
            cell.textLabel?.textColor = UIColor.red
            cell.accessoryType = .none
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let item = self.items[indexPath.row]
        
        if item == .logout {
            
            LoginManager.shared.logOut()
            
        }
        
    }
        
}
