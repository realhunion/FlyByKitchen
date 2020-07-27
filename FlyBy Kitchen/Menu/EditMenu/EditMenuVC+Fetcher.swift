//
//  EditMenu+Fetcher.swift
//  FlyBy Kitchen
//
//  Created by Hunain Ali on 7/11/20.
//  Copyright © 2020 BUMP. All rights reserved.
//

import UIKit

extension EditMenuVC : MenuFetcherDelegate {
    
    func setupFetcher() {
        self.menuFetcher = MenuFetcher()
        self.menuFetcher?.delegate = self
        self.menuFetcher?.startMonitor()
    }
    
    
    func menuUpdated(menu : Menu) {
        
        self.menu = menu
        self.tableView.reloadData()
        
    }
    
    
    
    
}
