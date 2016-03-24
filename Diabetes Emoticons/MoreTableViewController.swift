//
//  MoreTableViewController.swift
//  Diabetes Emoticons
//
//  Created by Connor Krupp on 11/30/15.
//  Copyright © 2015 Connor Krupp. All rights reserved.
//

import UIKit
import Social
import MessageUI

class MoreTableViewController : UITableViewController, MFMailComposeViewControllerDelegate {

    // MARK: Table View Data

    let moreData = [(title: "About Us", image: "icon_healthdesign", segue: "toWeb"),
                    (title: "Feedback", image: "icon_feedback", segue: "toSendMessage"),
                    (title: "Share this App", image: "share_blue", segue: "toShare")]
    
    let shareData = [(title: "Facebook", image: "circle_fb", call: shareFB),
        (title: "Twitter", image: "circle_twitter", call: shareTwitter),
        (title: "Mail", image: "circle_email", call: shareMail),
        (title: "Others", image: "circle_share", call: shareOthers)]
    
    var isShareVC = false

    // MARK: UITableView DataSource

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

    // MARK: UITableView Delegate

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if isShareVC {
            shareData[indexPath.row].call(self)()
        } else {
            performSegueWithIdentifier( moreData[indexPath.row].segue, sender: self)
        }
    }

    // MARK: Segue Handling

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "toShare" {
            if let detailViewController = segue.destinationViewController as? MoreTableViewController {
                detailViewController.isShareVC = true
            }
        }
    }

    // MARK: Social Handling

    // TODO: Condense these functions

    func shareOthers() {
        let objectsToShare = ["Check out this cool app: bit.ly/diabetesemoticons!"]
        let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
        
        //New Excluded Activities Code
        activityVC.excludedActivityTypes = [UIActivityTypeAirDrop, UIActivityTypeAddToReadingList]
        
        navigationController?.presentViewController(activityVC, animated: true) {}

    }
    
    func shareFB() {
        if SLComposeViewController.isAvailableForServiceType(SLServiceTypeFacebook) {
            let fbShare:SLComposeViewController = SLComposeViewController(forServiceType: SLServiceTypeFacebook)
            fbShare.setInitialText("Check out this cool app: bit.ly/diabetesemoticons!")
            self.presentViewController(fbShare, animated: true, completion: nil)
            
        } else {
            let alert = UIAlertController(title: "You're not logged in!", message: "Please login to a Facebook account in the Settings app to share", preferredStyle: UIAlertControllerStyle.Alert)
            
            alert.addAction(UIAlertAction(title: "Will Do!", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
        }
    }
    
    func shareTwitter() {
        if SLComposeViewController.isAvailableForServiceType(SLServiceTypeTwitter) {
            let tweetShare:SLComposeViewController = SLComposeViewController(forServiceType: SLServiceTypeTwitter)
            tweetShare.setInitialText("Check out this cool app: bit.ly/diabetesemoticons!")
            self.presentViewController(tweetShare, animated: true, completion: nil)
        } else {
            let alert = UIAlertController(title: "You're not logged in!", message: "Please login to a Twitter account in the Settings app to tweet", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "Will Do!", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
        }
    }
    
    func shareMail() {
        let emailTitle = "Awesome Diabetes App"
        // Email Content
        let messageBody = "Check out this cool app: bit.ly/diabetesemoticons!"
        // To address
        
        let mc = MFMailComposeViewController()
        mc.mailComposeDelegate = self;
        mc.setSubject(emailTitle)
        mc.setMessageBody(messageBody, isHTML: false)
        self.presentViewController(mc, animated: true, completion: nil)
    }
    
    func mailComposeController(controller: MFMailComposeViewController, didFinishWithResult result: MFMailComposeResult, error: NSError?) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
}