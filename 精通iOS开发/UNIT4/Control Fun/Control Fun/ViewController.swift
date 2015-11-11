//
//  ViewController.swift
//  Control Fun
//
//  Created by 张培栋 on 15/10/11.
//  Copyright © 2015年 张培栋. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var numberField: UITextField!
    @IBOutlet weak var sliderLabel: UILabel!
    @IBOutlet weak var leftSwitch: UISwitch!
    @IBOutlet weak var rightSwitch: UISwitch!
    @IBOutlet weak var doSomethingButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sliderLabel.text = "50"
        
        doSomethingButton.transform = CGAffineTransformMakeScale(0, 0)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func textFieldDoneEditing(sender: UITextField) {
        sender.resignFirstResponder()
    }
    
    @IBAction func backgroundTap(sender: UIControl) {
        nameField.resignFirstResponder()
        numberField.resignFirstResponder()
    }

    @IBAction func sliderChanged(sender: UISlider) {
        let progress = lroundf(sender.value)
        sliderLabel.text = "\(progress)"
    }
    
    @IBAction func switchChanged(sender: UISwitch) {
        let setting = sender.on
        leftSwitch.setOn(setting, animated: true)
        rightSwitch.setOn(setting, animated: true)
    }
    
    @IBAction func toggleControls(sender: UISegmentedControl) {

            if sender.selectedSegmentIndex == 0 {
                UIView.animateWithDuration(0.5, animations: {
                    self.leftSwitch.transform = CGAffineTransformMakeScale(1, 1)
                    self.rightSwitch.transform = CGAffineTransformMakeScale(1, 1)
                })
                UIView.animateWithDuration(0.5, delay: 0.3, options: UIViewAnimationOptions.CurveEaseOut, animations: {
                        self.doSomethingButton.transform = CGAffineTransformMakeScale(0, 0)
                    }
                    , completion: nil)

            }
            if sender.selectedSegmentIndex == 1 {
                UIView.animateWithDuration(0.5, animations: {
                    self.leftSwitch.transform = CGAffineTransformMakeScale(0, 0)
                    self.rightSwitch.transform = CGAffineTransformMakeScale(0, 0)
                })
                UIView.animateWithDuration(0.5, delay: 0.3, options: UIViewAnimationOptions.CurveEaseOut, animations: {
                    self.doSomethingButton.transform = CGAffineTransformMakeScale(1, 1)
                    }
                    , completion: nil)
            }
    }
    @IBAction func buttonPressed(sender: UIButton) {
        let controller = UIAlertController(title: "Are you sure?", message: nil, preferredStyle: UIAlertControllerStyle.ActionSheet)
        
        let yesAction = UIAlertAction(title: "Yes, I'm sure!", style: UIAlertActionStyle.Destructive, handler: { action in
            let msg = self.nameField.text!.isEmpty ? "You can breathe easy, everything went OK." : "You can breathe easy, \(self.nameField.text)," + "everything went OK."
            let controller2 = UIAlertController(title: "Something was Done", message: msg, preferredStyle: UIAlertControllerStyle.Alert)
            let cancelAction = UIAlertAction(title: "Phew!", style: UIAlertActionStyle.Cancel, handler: nil)
            controller2.addAction(cancelAction)
            self.presentViewController(controller2, animated: true, completion: nil)
        })
        
        let noAction = UIAlertAction(title: "No, way!", style: UIAlertActionStyle.Cancel, handler: nil)
        controller.addAction(yesAction)
        controller.addAction(noAction)
        
        if let ppc = controller.popoverPresentationController {
            ppc.sourceView = sender
            ppc.sourceRect = sender.bounds
        }
        presentViewController(controller, animated: true, completion: nil)
    }
}

