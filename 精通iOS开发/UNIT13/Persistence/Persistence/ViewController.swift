//
//  ViewController.swift
//  Persistence
//
//  Created by 张培栋 on 15/11/9.
//  Copyright © 2015年 张培栋. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var lineField: [UITextField]!


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let filePath = self.dataFilePath()
        if(NSFileManager.defaultManager().fileExistsAtPath(filePath)) {
            let array = NSArray(contentsOfFile: filePath) as! [String]
            for var i=0; i < array.count; i++ {
                lineField[i].text = array[i]
            }
        }
        let app = UIApplication.sharedApplication()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "applicationWillResignActive:", name: UIApplicationWillResignActiveNotification, object: app)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func dataFilePath() -> String {
        let paths = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, .UserDomainMask, true)
        let documentsDirectory = paths[0] as NSString
        return documentsDirectory.stringByAppendingPathComponent("data.plist");
    }
    
    func applicationWillResignActive(notification: NSNotification) {
        let filePath = self.dataFilePath()
        let array = (self.lineField as NSArray).valueForKey("text") as! NSArray
        array.writeToFile(filePath, atomically: true)
    }


}

