//
//  EmoticonDetailViewController.swift
//  Diabetes Emoticons
//
//  Created by Connor Krupp on 11/20/15.
//  Copyright © 2015 Connor Krupp. All rights reserved.
//

import UIKit

class EmoticonDetailViewController : UIViewController {
    
    @IBOutlet weak var emoticonImage: UIImageView!
    @IBOutlet weak var shareButton: UIButton!
    @IBOutlet weak var favoriteButton: UIButton!
    
    var emoticon: Emoticon!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        emoticonImage.image = UIImage(named: emoticon.image)
        self.title = emoticon.title
    }
}
