//
//  WebViewController.swift
//  Diabetes Emoticons
//
//  Created by Connor Krupp on 11/30/15.
//  Copyright © 2015 Connor Krupp. All rights reserved.
//

import UIKit

class WebViewController : UIViewController, UIWebViewDelegate {

    // MARK: IBOutlets

    @IBOutlet weak var webView: UIWebView!
    @IBOutlet weak var indicator: UIActivityIndicatorView!

    // MARK: Properties
    
    var url = "http://healthdesignby.us"

    // MARK: View Controller Lifecycle

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        let request = NSURLRequest(URL: NSURL(string: url)!)
        webView.loadRequest(request)
        webView.delegate = self
    }

    // MARK: UIWebView Delegate

    func webViewDidStartLoad(webView: UIWebView) {
        indicator.startAnimating()
    }
    
    func webViewDidFinishLoad(webView: UIWebView) {
        indicator.stopAnimating()
    }
}
