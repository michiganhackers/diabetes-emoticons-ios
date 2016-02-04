//
//  EmoticonTableViewController.swift
//  Diabetes Emoticons
//
//  Created by Connor Krupp on 12/21/15.
//  Copyright © 2015 Connor Krupp. All rights reserved.
//


import UIKit
import CoreData
import MessageUI

public func <(lhs: NSDate, rhs: NSDate) -> Bool {
    return lhs.compare(rhs) == .OrderedAscending
}

extension NSDate: Comparable { }

class EmoticonTableViewController: UITableViewController {
    
    
    enum ViewController {
        case Home
        case Recent
        case Favorite
    }
    
    var vc = ViewController.Home
    
    // MARK: Initialize variables
    
    private var emoticons = [Emoticon]()
    var fetchResultController: NSFetchedResultsController!
    
    // MARK: View Controller Lifecycle
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        // Load menu items from database
        assignVCType()
        if let managedObjectContext = (UIApplication.sharedApplication().delegate as? AppDelegate)?.managedObjectContext {
            let fetchRequest = NSFetchRequest(entityName: "Emoticon")
            do {
                emoticons = try managedObjectContext.executeFetchRequest(fetchRequest) as! [Emoticon]
            } catch {
                print("Failed to retrieve record")
                print(error)
            }
        }
        filterEmoticons()
        tableView.reloadData()
    }
    
    // MARK: UITableView DataSource
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return emoticons.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCellWithIdentifier("StandardCell", forIndexPath: indexPath) as! EmoticonTableViewCell
        
        // Set cell data
        cell.titleLabel.text = emoticons[indexPath.row].title
        cell.emoticonImage.image = UIImage(named: emoticons[indexPath.row].image)
        
        // Add actions for favorite and share
        cell.favoriteButton.addTarget(self, action: "favoritePressed:", forControlEvents: .TouchUpInside)
        cell.shareButton.addTarget(self, action: "sharePressed:", forControlEvents: .TouchUpInside)
        
        // Add tags to identify favorite and share
        cell.favoriteButton.tag = indexPath.row
        cell.shareButton.tag = indexPath.row
        
        // Set favorite image
        cell.favoriteButton.setImage(UIImage(named: Bool(emoticons[indexPath.row].isFavorite!) ? "star_blue_filled" : "star_notfilled"), forState: .Normal)
        
        return cell
    }
    
    // MARK: UITableViewDelegate
    
    @IBAction func favoritePressed(sender: UIButton) {
        // Add to favorites
        emoticons[sender.tag].isFavorite = NSNumber(bool: !Bool(emoticons[sender.tag].isFavorite!))
        
        if let managedObjectContext = (UIApplication.sharedApplication().delegate as? AppDelegate)?.managedObjectContext {
            try! managedObjectContext.save()
        }
        
        if vc == .Favorite {
            if emoticons[sender.tag].isFavorite == NSNumber(bool: false) {
                emoticons.removeAtIndex(sender.tag)
                let indexPath = tableView.indexPathForCell(sender.superview?.superview as! EmoticonTableViewCell)
                self.tableView.deleteRowsAtIndexPaths([indexPath!], withRowAnimation: UITableViewRowAnimation.Left)
            }
        } else {
            self.tableView.reloadData()   
        }
    }
    
    @IBAction func sharePressed(sender: UIButton) {
        // Update recent emoticons
        emoticons[sender.tag].lastAccessed = NSDate()
        if let managedObjectContext = (UIApplication.sharedApplication().delegate as? AppDelegate)?.managedObjectContext {
            try! managedObjectContext.save()
        }
        
        // Add emoticon image to share sheet
        let objectsToShare = [UIImage(named: emoticons[sender.tag].image)!]
        let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
        
        // Disable AirDrop and AddtoReadingList
        activityVC.excludedActivityTypes = [UIActivityTypeAirDrop, UIActivityTypeAddToReadingList]
        
        // Present share sheet
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
    
    // MARK: Data Handling
    
    func assignVCType() {
        switch self.tableView.tag {
        case 1:
            vc = .Home
        case 2:
            vc = .Recent
        case 3:
            vc = .Favorite
        default:
            vc = .Home
        }
    }
    
    func filterEmoticons() {
        switch vc {
        case .Home:
            emoticons.sortInPlace({ $0.title < $1.title })
        case .Recent:
            emoticons = emoticons.filter({ $0.lastAccessed.compare(NSDate(timeIntervalSinceNow: NSTimeInterval(-604800))) == NSComparisonResult.OrderedDescending })
            emoticons.sortInPlace({ $0.lastAccessed.compare($1.lastAccessed) == NSComparisonResult.OrderedDescending })
        case .Favorite:
            emoticons = emoticons.filter({ $0.isFavorite == NSNumber(bool: true) })
            emoticons.sortInPlace( { $0.title < $1.title })
        }
    }
    
}

