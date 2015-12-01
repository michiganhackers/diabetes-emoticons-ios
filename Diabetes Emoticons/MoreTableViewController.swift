//
//  MoreTableViewController.swift
//  Diabetes Emoticons
//
//  Created by Connor Krupp on 11/30/15.
//  Copyright © 2015 Connor Krupp. All rights reserved.
//

import UIKit

class MoreTableViewController : UITableViewController {
    
    let cellTitles = ["About Us", "Feedback", "Share this App"]
    let cellImages = ["Banana", "Banana", "Banana"]
    let cellSegues = ["aboutUs", "toSendMessage", "aboutUs"]
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellTitles.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCellWithIdentifier("MoreCell", forIndexPath: indexPath) as! MoreTableViewCell
        cell.titleLabel.text = cellTitles[indexPath.row]
        cell.sideImage.image = UIImage(named: cellImages[indexPath.row])

        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        performSegueWithIdentifier(cellSegues[indexPath.row], sender: self)
    }
    
}