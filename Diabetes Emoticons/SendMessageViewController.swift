//
//  SendMessageViewController.swift
//  Diabetes Emoticons
//
//  Created by Connor Krupp on 11/30/15.
//  Copyright © 2015 Connor Krupp. All rights reserved.
//

import UIKit

class SendMessageViewController : UIViewController, UITextViewDelegate {
    
    @IBOutlet weak var textView: UITextView!
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        textView.becomeFirstResponder()
    }
    
    
}
