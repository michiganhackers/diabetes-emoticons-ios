//
//  HomeViewController.swift
//  Diabetes Emoticons
//
//  Created by Connor Krupp on 11/11/15.
//  Copyright © 2015 Connor Krupp. All rights reserved.
//

import UIKit
import CoreData
import MessageUI

class HomeViewController: UITableViewController {
    
    // MARK: Initialize variables

    private var emoticons = [Emoticon]()
    var fetchResultController: NSFetchedResultsController!
    
    // MARK: View Controller Lifecycle
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        // Load menu items from database
        if let managedObjectContext = (UIApplication.sharedApplication().delegate as? AppDelegate)?.managedObjectContext {
            
            let fetchRequest = NSFetchRequest(entityName: "Emoticon")
            do {
                emoticons = try managedObjectContext.executeFetchRequest(fetchRequest) as! [Emoticon]
            } catch {
                print("Failed to retrieve record")
                print(error)
            }
        }
        emoticons.sortInPlace({ $0.title < $1.title })
        tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: UITableView DataSource
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return emoticons.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCellWithIdentifier("StandardCell", forIndexPath: indexPath) as! EmoticonTableViewCell
        cell.titleLabel.text = emoticons[indexPath.row].title
        cell.emoticonImage.image = UIImage(named: emoticons[indexPath.row].image)
        cell.favoriteButton.addTarget(self, action: "favoritePressed:", forControlEvents: .TouchUpInside)
        cell.shareButton.addTarget(self, action: "sharePressed:", forControlEvents: .TouchUpInside)
        cell.favoriteButton.tag = indexPath.row
        cell.shareButton.tag = indexPath.row
        
        if Bool(emoticons[indexPath.row].isFavorite!) {
            cell.favoriteButton.setImage(UIImage(named: "star_blue_filled"), forState: .Normal)
        } else {
            cell.favoriteButton.setImage(UIImage(named: "star_notfilled"), forState: .Normal)
        }
        return cell
    }
    
    // MARK: UITableViewDelegate
    
    @IBAction func favoritePressed(sender: UIButton) {
        emoticons[sender.tag].isFavorite = NSNumber(bool: !Bool(emoticons[sender.tag].isFavorite!))

        if let managedObjectContext = (UIApplication.sharedApplication().delegate as? AppDelegate)?.managedObjectContext {
            try! managedObjectContext.save()
        }
        self.tableView.reloadData()
    }
    
    @IBAction func sharePressed(sender: UIButton) {
        emoticons[sender.tag].lastAccessed = NSDate()
        if let managedObjectContext = (UIApplication.sharedApplication().delegate as? AppDelegate)?.managedObjectContext {
            try! managedObjectContext.save()
        }

        let objectsToShare = [UIImage(named: emoticons[sender.tag].image)!]
        let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
        
        //New Excluded Activities Code
        activityVC.excludedActivityTypes = [UIActivityTypeAirDrop, UIActivityTypeAddToReadingList]
        //
        
        navigationController?.presentViewController(activityVC, animated: true) {}
    }
    
    // MARK: Segue Handling
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "toDetail" {
            if let detailViewController = segue.destinationViewController as? EmoticonDetailViewController {
                emoticons[tableView.indexPathForSelectedRow!.row].lastAccessed = NSDate()
                if let managedObjectContext = (UIApplication.sharedApplication().delegate as? AppDelegate)?.managedObjectContext {
                    try! managedObjectContext.save()
                }
                detailViewController.emoticon = emoticons[tableView.indexPathForSelectedRow!.row]
            }
        }
    }
    
}

