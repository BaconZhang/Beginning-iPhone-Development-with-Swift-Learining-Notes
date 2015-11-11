//
//  ViewController.swift
//  Core Data Persistence
//
//  Created by 张培栋 on 15/11/9.
//  Copyright © 2015年 张培栋. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    @IBOutlet var textFields: [UITextField]!
    private let lineEntityName = "Line"
    private let lineNumberKey = "lineNumber"
    private let lineTextKey = "lineText"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let appDelegete = UIApplication.sharedApplication().delegate as! AppDelegate
        let context = appDelegete.managedObjectContext
        let request = NSFetchRequest(entityName: lineEntityName)
        
        do {
         let objects = try context.executeFetchRequest(request)
         for oneObject in objects {
            let lineNum = oneObject.valueForKey(lineNumberKey)!.integerValue
            let lineText = oneObject.valueForKey(lineTextKey) as! String
            let textField = textFields[lineNum]
            textField.text = lineText
         }
        }
        catch{
            print("There was an error")
        }
        
        let app = UIApplication.sharedApplication()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "applicationWillResignActive:", name: UIApplicationWillResignActiveNotification, object: app)
    }

    func applicationWillResignActive(notification: NSNotification) {
        let appDelegete = UIApplication.sharedApplication().delegate as! AppDelegate
        let context = appDelegete.managedObjectContext

        for var i = 0; i < textFields.count; i++ {
            let textField = textFields[i]
            
            let request = NSFetchRequest(entityName: lineEntityName)
            let pred = NSPredicate(format: "%K = %d", lineNumberKey, i)
            request.predicate = pred
            do {
                let objects = try context.executeFetchRequest(request)
                var theLine: NSManagedObject! = nil
                if objects.count > 0 {
                    theLine = objects[0] as! NSManagedObject
                } else {
                    theLine = NSEntityDescription.insertNewObjectForEntityForName(lineEntityName, inManagedObjectContext: context)
                }
                theLine.setValue(i, forKey: lineNumberKey)
                theLine.setValue(textField.text, forKey: lineTextKey)
            } catch {
                print("There was an error")
            }
        }
        appDelegete.saveContext()
    }


}

