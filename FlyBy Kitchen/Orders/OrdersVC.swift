//
//  OrdersVC.swift
//  FlyBy Kitchen
//
//  Created by Hunain Ali on 7/11/20.
//  Copyright © 2020 BUMP. All rights reserved.
//

import UIKit
import Firebase

class OrdersVC: UITableViewController {
    
    var ordersFetcher : OrdersFetcher?
    
    var orderArray : [Order] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupFetcher()
        
        tableView.register(SubtitleTableViewCell.classForCoder(), forCellReuseIdentifier: "orderCell")
    }
    
    func shutDown() {
        self.ordersFetcher?.shutDown()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.orderArray.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "orderCell", for: indexPath)
        
        let order = self.orderArray[indexPath.row]

        cell.accessoryType = .disclosureIndicator
        
        cell.textLabel?.text = "Table \(order.table)\n@ \(getTimestampString(tStamp: order.timestamp)) → $\(order.totalPrice)"
        cell.textLabel?.font = UIFont.preferredFont(forTextStyle: .headline)
        cell.textLabel?.textColor = UIColor.systemRed
        
        var itemsString = ""
        for item in order.itemArray {
            itemsString = itemsString + "- " + item + "\n"
        }
        
        cell.detailTextLabel?.text = itemsString
        cell.detailTextLabel?.numberOfLines = 99
        cell.textLabel?.numberOfLines = 3
        cell.detailTextLabel?.font = .preferredFont(forTextStyle: .body)
        
        return cell
    }
    
    func getTimestampString(tStamp : Timestamp) -> String {
        
        let timestampDate = tStamp.dateValue()
        let timestampTimeInterval = NSInteger(-timestampDate.timeIntervalSinceNow)
        let minutesAgo = (timestampTimeInterval / 60)
        let hoursAgo = (timestampTimeInterval / 3600)
        let daysAgo = (timestampTimeInterval / 86400)
        
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = "M/d h:mm a"
        formatter.amSymbol = "AM"
        formatter.pmSymbol = "PM"
        let dateString = formatter.string(from: timestampDate)
        
        return dateString
        
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
