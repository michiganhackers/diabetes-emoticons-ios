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
    
    @IBOutlet weak var emoticonImage: UIImageView!
    @IBOutlet weak var favoriteButton: UIButton!
    
    var emoticon: Emoticon!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        emoticonImage.image = UIImage(named: emoticon.image)
        self.title = emoticon.title
        layoutView()
    }
    
    
    @IBAction func share() {
        emoticon.lastAccessed = NSDate()
        if let managedObjectContext = (UIApplication.sharedApplication().delegate as? AppDelegate)?.managedObjectContext {
            try! managedObjectContext.save()
        }
        
        let objectsToShare = [UIImage(named: emoticon.image)!]
        let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
        
        //New Excluded Activities Code
        activityVC.excludedActivityTypes = [UIActivityTypeAirDrop, UIActivityTypeAddToReadingList]
        //
        
        navigationController?.presentViewController(activityVC, animated: true) {}

    }
    
    @IBAction func favorite() {
        emoticon.isFavorite = NSNumber(bool: !Bool(emoticon.isFavorite!))
        if let managedObjectContext = (UIApplication.sharedApplication().delegate as? AppDelegate)?.managedObjectContext {
            try! managedObjectContext.save()
        }
        layoutView()
    }
    
    func layoutView() {
        if emoticon.isFavorite == NSNumber(bool: false) {
            favoriteButton.setImage(UIImage(named: "CircleEmptyStar"), forState: .Normal)
        } else {
            favoriteButton.setImage(UIImage(named: "CircleFilledStar"), forState: .Normal)
        }
    }
}
