//
//  ViewController.swift
//  TouchExplorer
//
//  Created by 张培栋 on 15/11/2.
//  Copyright © 2015年 张培栋. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var messageLabel: UILabel!
    @IBOutlet var tapsLabel: UILabel!
    @IBOutlet var touchesLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    func updateLabelsFromTouches(touches: NSSet!) {
        
        let touch = touches.anyObject() as! UITouch
        let numTaps = touch.tapCount
        let tapsMessage = "\(numTaps) taps dectected"
        tapsLabel.text = tapsMessage
        
        let numTouches = touches.count
        let touchMsg = "\(numTouches) touches dectected"
        touchesLabel.text = touchMsg
    
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        messageLabel.text = "Touches began"
        updateLabelsFromTouches(event?.allTouches())
        
    }
    
    override func touchesCancelled(touches: Set<UITouch>?, withEvent event: UIEvent?) {
        
        messageLabel.text = "Touches began"
        updateLabelsFromTouches(event?.allTouches())
        
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        messageLabel.text = "Touches ended"
        updateLabelsFromTouches(event?.allTouches())
        
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        messageLabel.text = "Touches moved"
        updateLabelsFromTouches(event?.allTouches())

    }

}

