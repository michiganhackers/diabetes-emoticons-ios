//
//  MoreTableViewController.swift
//  Diabetes Emoticons
//
//  Created by Connor Krupp on 11/30/15.
//  Copyright © 2015 Connor Krupp. All rights reserved.
//

import UIKit

class MoreTableViewController : UITableViewController {
    
    let moreData = [(title: "About Us", image: "Banana", segue: "toWeb"),
                    (title: "Feedback", image: "Banana", segue: "toSendMessage"),
                    (title: "Share this App", image: "Banana", segue: "toShare")]
    
    let shareData = [(title: "Facebook", image: "Banana", segue: "toWeb", url: "http://facebook.com"),
        (title: "Twitter", image: "Banana", segue: "toWeb", url: "http://twitter.com"),
        (title: "Google+", image: "Banana", segue: "toWeb", url: "http://google.com")]
    
    var isShareVC = false
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isShareVC {
            return shareData.count
        }
        return moreData.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCellWithIdentifier("MoreCell", forIndexPath: indexPath) as! MoreTableViewCell
        
        cell.titleLabel.text = isShareVC ? shareData[indexPath.row].title : moreData[indexPath.row].title
        cell.sideImage.image = UIImage(named: isShareVC ? shareData[indexPath.row].image : moreData[indexPath.row].image)
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        performSegueWithIdentifier( isShareVC ? shareData[indexPath.row].segue : moreData[indexPath.row].segue, sender: self)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "toShare" {
            if let detailViewController = segue.destinationViewController as? MoreTableViewController {
                detailViewController.isShareVC = true
            }
        } 
        
        if segue.identifier == "toWeb" && isShareVC {
            if let webViewController = segue.destinationViewController as? WebViewController {
                webViewController.url = shareData[tableView.indexPathForSelectedRow!.row].url
            }
        }
    }
    
}