//
//  HomeViewController.swift
//  Diabetes Emoticons
//
//  Created by Connor Krupp on 11/11/15.
//  Copyright © 2015 Connor Krupp. All rights reserved.
//

import UIKit

class HomeViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 30
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCellWithIdentifier("StandardCell", forIndexPath: indexPath) as! EmoticonTableViewCell
        cell.titleLabel.text = "Test"
        cell.imageView?.image = UIImage(named: "Banana")
        
        return cell
    }

}

