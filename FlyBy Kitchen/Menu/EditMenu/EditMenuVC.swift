//
//  EditMenuVC.swift
//  FlyBy Kitchen
//
//  Created by Hunain Ali on 7/11/20.
//  Copyright © 2020 BUMP. All rights reserved.
//

import UIKit

class EditMenuVC : UITableViewController {
    
    
    var menuFetcher : MenuFetcher?
    
    var menu : Menu?
    
    
    override init(style: UITableView.Style) {
        super.init(style: .insetGrouped)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {

        self.tableView.dragInteractionEnabled = true // Enable intra-app drags for iPhone.
        self.tableView.dragDelegate = self
        self.tableView.dropDelegate = self
        
        self.setupFetcher()
        
        self.setupBarButtons()
        //
        self.tableView.register(MenuCell.classForCoder(), forCellReuseIdentifier: "menuCell")
    }
    
    func shutDown() {
        self.menuFetcher?.shutDown()
    }
    
    
    
    func setupBarButtons() {
        
        let btn1 = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addCategoryButtonTapped))
        self.navigationItem.setRightBarButtonItems([btn1], animated: true)
        
    }
    
    
    
    
    
    
    
    var cellHeights = [IndexPath: CGFloat]()
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cellHeights[indexPath] = cell.frame.size.height
    }
    
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellHeights[indexPath] ?? UITableView.automaticDimension
    }
    
    
    
    
    
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 64.0
    }
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        guard let m = menu else { return nil }
        
        let cat = m.getCategoryArray()[section]
        
        let catTitle = cat.title
        
        
        let v = UIView(frame: CGRect.zero)
        
        let catgory = UILabel(frame: CGRect.zero)
        catgory.font = UIFont(name: "Avenir-Black", size: 24.0)
        catgory.text = catTitle
        catgory.adjustsFontSizeToFitWidth = true
        catgory.textAlignment = .left
        
        let upButton = UIButton(frame: CGRect.zero)
        let upImg = UIImage(named: "upArrow")?.withTintColor(UIColor.systemBlue)
        upButton.setImage(upImg, for: .normal)
        upButton.tag = section
        upButton.addTarget(self, action: #selector(upButtonTapped), for: .touchUpInside)
        
        let downButton = UIButton(frame: CGRect.zero)
        let downImg = UIImage(named: "downArrow")?.withTintColor(UIColor.systemBlue)
        downButton.setImage(downImg, for: .normal)
        downButton.tag = section
        downButton.addTarget(self, action: #selector(downButtonTapped), for: .touchUpInside)
        
        let plusButton = UIButton(frame: CGRect.zero)
        let plusImg = UIImage(named: "plus")?.withTintColor(UIColor.systemBlue)
        plusButton.setImage(plusImg, for: .normal)
        plusButton.tag = section
        plusButton.addTarget(self, action: #selector(plusButtonTapped), for: .touchUpInside)
        
        let editButton = UIButton(frame: CGRect.zero)
        let editImg = UIImage(named: "edit")?.withTintColor(UIColor.systemBlue)
        editButton.setImage(editImg, for: .normal)
        editButton.tag = section
        editButton.addTarget(self, action: #selector(editButtonTapped), for: .touchUpInside)
        
        
        v.addSubview(plusButton)
        plusButton.layoutToSuperview(.right)
        plusButton.layoutToSuperview(.centerY)
        plusButton.set(.height, of: 30)
        plusButton.set(.width, of: 30)
        
        v.addSubview(upButton)
        upButton.layout(.right, to: .left, of: plusButton, offset: -6.0)
        upButton.layoutToSuperview(.centerY)
        upButton.set(.height, of: 30)
        upButton.set(.width, of: 30)
        
        v.addSubview(downButton)
        downButton.layout(.right, to: .left, of: upButton, offset: -6.0)
        downButton.layoutToSuperview(.centerY)
        downButton.set(.height, of: 30)
        downButton.set(.width, of: 30)
        
        v.addSubview(editButton)
        editButton.layout(.right, to: .left, of: downButton, offset: -6.0)
        editButton.layoutToSuperview(.centerY)
        editButton.set(.height, of: 28)
        editButton.set(.width, of: 28)
        
        v.addSubview(catgory)
        catgory.layout(.right, to: .left, of: editButton, offset: -10.0)
        catgory.layoutToSuperview(.left)
        catgory.layoutToSuperview(.centerY)
        
        
        return v
        
    }
    

    
    
    
    
    //MARK: - DATA SOURCE
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        guard let m = menu else { return 0 }
        return m.getCategoryArray().count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let m = menu else { return 0 }
        let cat = m.getCategoryArray()[section]
        return m.getItemArray(categoryID: cat.categoryID).count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "menuCell", for: indexPath) as! MenuCell
        
        guard let m = menu else { return cell }
        
        let cat = m.getCategoryArray()[indexPath.section]
        let item = m.getItemArray(categoryID: cat.categoryID)[indexPath.row]
        
        cell.titleLabel.text = item.title
        cell.priceLabel.text = "$\(item.price.clean)"
        cell.descriptionLabel.text = item.description
        
        cell.accessoryType = .disclosureIndicator
        
        return cell
    }
    
    
    
    
    
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard let m = menu else { return }
        
        let vc = EditItemVC(style: .insetGrouped)
        vc.modalPresentationStyle = .pageSheet
        let nc = UINavigationController(rootViewController: vc)
        vc.title = "Edit Menu Item"
        
        let cat = m.getCategoryArray()[indexPath.section]
        var item = m.getItemArray(categoryID: cat.categoryID)[indexPath.row]
        
        if item.title == "Sample Item" && item.description == "Tap to edit" {
            item.title = ""
            item.description = ""
            item.price = 0.0
        }
        
        vc.item = item
        
        self.present(nc, animated: true, completion: nil)
    }
    
    
}

extension Double {
    var clean: String {
        return self.truncatingRemainder(dividingBy: 1) == 0 ? String(format: "%.0f", self) : String(self)
    }
}
