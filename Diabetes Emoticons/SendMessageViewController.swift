//
//  SendMessageViewController.swift
//  Diabetes Emoticons
//
//  Created by Connor Krupp on 11/30/15.
//  Copyright © 2015 Connor Krupp. All rights reserved.
//

import UIKit
import MessageUI

class SendMessageViewController : UIViewController, UITextViewDelegate, MFMailComposeViewControllerDelegate {

    // MARK: IBOutlets
    
    @IBOutlet weak var textView: UITextView!

    // MARK: View Controller Lifecycle

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(SendMessageViewController.keyboardWillShow(_:)), name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(SendMessageViewController.keyboardWillHide(_:)), name: UIKeyboardWillHideNotification, object: nil)
        
        placeButton()
        textView.becomeFirstResponder()
    }
    
    override func viewWillDisappear(animated: Bool) {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }

    // MARK: Layout UI
    
    func placeButton() {
       
        let x = self.view.frame.width - 80
        let y = self.view.frame.height - 80 - self.tabBarController!.tabBar.frame.height
        let button = UIButton(frame: CGRect(x: x, y: y, width: 60, height: 60))
        button.setImage(UIImage(named: "circle_send_text"), forState: .Normal)
        button.tag = 1
        button.addTarget(self, action: #selector(SendMessageViewController.sendMessage(_:)), forControlEvents: .TouchUpInside)
        self.view.addSubview(button)
    
    }

    // MARK: MailCompose Delegate

    func sendMessage(_: UIButton) {
        if MFMailComposeViewController.canSendMail() {
            let emailTitle = "Diabetes Emoticons Feedback"
            // Email Content
            let messageBody = textView.text
            // To address
            let toRecipents = ["doctorasdesigner@gmail.com"]

            let mc = MFMailComposeViewController()
            mc.mailComposeDelegate = self;
            mc.setSubject(emailTitle)
            mc.setMessageBody(messageBody, isHTML: false)
            mc.setToRecipients(toRecipents)
            self.presentViewController(mc, animated: true, completion: nil)
        } else {
            let alert = UIAlertController(title: "You don't have any Mail Accounts", message: "Please setup a Mail account", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "Will Do!", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
        }

    }
    
    func mailComposeController(controller: MFMailComposeViewController, didFinishWithResult result: MFMailComposeResult, error: NSError?) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }

    // MARK: Keyboard Delegate

    func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.CGRectValue() {
            let button = self.view.viewWithTag(1) as! UIButton
            let x = self.view.frame.width - 80
            let y = self.view.frame.height - 80 - keyboardSize.height
            button.frame = CGRect(x: x, y: y, width: 60, height: 60)

        }
    }

    func keyboardWillHide(notification: NSNotification) {
        let button = self.view.viewWithTag(1) as! UIButton
        let x = self.view.frame.width - 80
        let y = self.view.frame.height - 80 - self.tabBarController!.tabBar.frame.height
        button.frame = CGRect(x: x, y: y, width: 60, height: 60)
    }
    
}
