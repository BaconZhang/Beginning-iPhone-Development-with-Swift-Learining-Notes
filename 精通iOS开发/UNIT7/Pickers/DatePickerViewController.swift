//
//  DatePickerViewController.swift
//  Pickers
//
//  Created by 张培栋 on 15/10/15.
//  Copyright © 2015年 张培栋. All rights reserved.
//

import UIKit

class DatePickerViewController: UIViewController {

    @IBOutlet weak var datePicker: UIDatePicker!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let date = NSDate()

        datePicker.setDate(date, animated: false)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func buttonPressed(sender: AnyObject) {
        let date = datePicker.date
        let formatter = NSDateFormatter()
        formatter.dateFormat = "\n yyyy年MM月dd日 HH:mm:ss "
        let dateString = formatter.stringFromDate(date)
        
        let message = "The date and time you selected is" + dateString
        let alert = UIAlertController(title: "Date and Time selected", message: message, preferredStyle: UIAlertControllerStyle.Alert)
        let action = UIAlertAction(title: "That's so true!", style: UIAlertActionStyle.Default, handler: nil)
        alert.addAction(action)
        presentViewController(alert, animated: true, completion: nil)
        
    }
}
