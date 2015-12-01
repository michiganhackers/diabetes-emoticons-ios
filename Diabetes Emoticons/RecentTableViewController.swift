//
//  RecentTableViewController.swift
//  Diabetes Emoticons
//
//  Created by Connor Krupp on 11/27/15.
//  Copyright © 2015 Connor Krupp. All rights reserved.
//

import UIKit
import CoreData

public func <(lhs: NSDate, rhs: NSDate) -> Bool {
    return lhs.compare(rhs) == .OrderedAscending
}

extension NSDate: Comparable { }

class RecentTableViewController : UITableViewController {
    private var emoticons = [Emoticon]()
    var fetchResultController: NSFetchedResultsController!
    
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
        
        emoticons = emoticons.filter({ $0.lastAccessed.compare(NSDate(timeIntervalSinceNow: NSTimeInterval(-604800))) == NSComparisonResult.OrderedDescending })
        emoticons.sortInPlace({ $0.lastAccessed.compare($1.lastAccessed) == NSComparisonResult.OrderedDescending })
        tableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
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
        
        if Bool(emoticons[indexPath.row].isFavorite!) {
            cell.favoriteButton.setImage(UIImage(named: "FilledStar"), forState: .Normal)
        } else {
            cell.favoriteButton.setImage(UIImage(named: "EmptyStar"), forState: .Normal)
        }
        return cell
    }
    
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
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "toDetail" {
            if let detailViewController = segue.destinationViewController as? EmoticonDetailViewController {
                detailViewController.emoticon = emoticons[tableView.indexPathForSelectedRow!.row]
            }
        }
    }
    
}