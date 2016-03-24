//
//  EmoticonDetailViewController.swift
//  Diabetes Emoticons
//
//  Created by Connor Krupp on 11/20/15.
//  Copyright © 2015 Connor Krupp. All rights reserved.
//

import UIKit
import MessageUI

class EmoticonDetailViewController : UIViewController {

    // MARK: IBOutlets

    @IBOutlet weak var emoticonImage: UIImageView!
    @IBOutlet weak var favoriteButton: UIButton!

    // MARK: Class Variables

    var emoticon: Emoticon!

    // MARK: View Controller Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        emoticonImage.image = UIImage(named: emoticon.image)
        self.title = emoticon.title
        layoutView()
    }

    // MARK: IBActions

    @IBAction func share() {
        emoticon.lastAccessed = NSDate()
        if let managedObjectContext = (UIApplication.sharedApplication().delegate as? AppDelegate)?.managedObjectContext {
            try! managedObjectContext.save()
        }
        
        let objectsToShare = [UIImage(named: emoticon.image)!]
        let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
        
        //New Excluded Activities Code
        activityVC.excludedActivityTypes = [UIActivityTypeAirDrop, UIActivityTypeAddToReadingList, UIActivityTypeOpenInIBooks, UIActivityTypePostToVimeo, UIActivityTypeAddToReadingList]

        navigationController?.presentViewController(activityVC, animated: true) {}
    }
    
    @IBAction func favorite() {
        emoticon.isFavorite = NSNumber(bool: !Bool(emoticon.isFavorite!))
        if let managedObjectContext = (UIApplication.sharedApplication().delegate as? AppDelegate)?.managedObjectContext {
            try! managedObjectContext.save()
        }
        layoutView()
    }

    // MARK: Layout UI

    func layoutView() {
        // If isFavorite, set the star circle to filled
        favoriteButton.setImage(UIImage(named: emoticon.isFavorite == NSNumber(bool: false) ? "star_circle_empty" : "star_circle_yellowfilled"), forState: .Normal)
    }
}
