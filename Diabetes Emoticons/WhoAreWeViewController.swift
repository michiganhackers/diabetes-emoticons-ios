//
//  WhoAreWeViewController.swift
//  Diabetes Emoticons
//
//  Created by Connor Krupp on 11/30/15.
//  Copyright © 2015 Connor Krupp. All rights reserved.
//

import UIKit

class WhoAreWeViewController : UIViewController, UIWebViewDelegate {
    
    @IBOutlet weak var webView: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let request = NSURLRequest(URL: NSURL(string: "http://healthdesignby.us")!)
        webView.loadRequest(request)
    }
}
