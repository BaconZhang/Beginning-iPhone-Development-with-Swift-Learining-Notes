//
//  ViewController.swift
//  Button Fun
//
//  Created by 张培栋 on 15/10/9.
//  Copyright © 2015年 张培栋. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var statusLabel: UILabel!
    
    @IBAction func buttonPressed(sender: AnyObject) {
        
        let title = sender.titleForState(.Normal)!
        
        let plainText = "\(title) button pressed"
        
        //statusLabel.text = plainText
        
        let styledText = NSMutableAttributedString(string: plainText)
        
        let attributes = [
            
            NSFontAttributeName:
                UIFont.boldSystemFontOfSize(statusLabel.font.pointSize)
            
        ]
        
        let nameRange = (plainText as NSString).rangeOfString(title)
        
        styledText.setAttributes(attributes, range: nameRange)
        
        statusLabel.attributedText = styledText
        
    }

}

