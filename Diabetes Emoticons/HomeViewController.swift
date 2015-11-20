//
//  HomeViewController.swift
//  Diabetes Emoticons
//
//  Created by Connor Krupp on 11/11/15.
//  Copyright © 2015 Connor Krupp. All rights reserved.
//

import UIKit
import CoreData

class HomeViewController: UITableViewController {
    
    private var emoticons = [Emoticon]()
    var fetchResultController: NSFetchedResultsController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        cell.emoticonImage.image = UIImage(named: emoticons[indexPath.row].image!)
        
        return cell
    }
    
}

