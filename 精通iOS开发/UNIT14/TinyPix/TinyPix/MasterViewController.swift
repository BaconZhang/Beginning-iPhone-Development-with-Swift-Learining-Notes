//
//  MasterViewController.swift
//  TinyPix
//
//  Created by 张培栋 on 15/11/10.
//  Copyright © 2015年 张培栋. All rights reserved.
//

import UIKit

class MasterViewController: UITableViewController {
    @IBOutlet var colorControl: UISegmentedControl!
    private var documentFileNames: [String] = []
    private var chosenDocument: TinyPixDocument?
    
    private func urlForFileName(fileName: NSString) -> NSURL {
        let fm = NSFileManager.defaultManager()
        let urls = fm.URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask) as [NSURL]
        let directoryURL = urls[0]
        let fileURL = directoryURL.URLByAppendingPathComponent(fileName as String)
        return fileURL
    }
    
    private func reloadFiles() {
        let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true) as [String]
        let path = paths[0]
        let fm = NSFileManager.defaultManager()
        let urls = fm.URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask) as [NSURL]
        let directoryURL = urls[0]
        
        let files = try? fm.contentsOfDirectoryAtPath(path)
        let sortedFileNames = files!.sort() {
            fileName1, fileName2 in
            let file1URL = directoryURL.URLByAppendingPathComponent(fileName1)
            let file2URL = directoryURL.URLByAppendingPathComponent(fileName2)
            let attr1 = try? fm.attributesOfItemAtPath(file1URL.path!)
            let attr2 = try? fm.attributesOfItemAtPath(file2URL.path!)
            let file1Date = attr1![NSFileCreationDate] as! NSDate
            let file2Date = attr2![NSFileCreationDate] as! NSDate
            let result = file1Date.compare(file2Date)
            return result == NSComparisonResult.OrderedAscending
        }
        documentFileNames = sortedFileNames
        tableView.reloadData()
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return documentFileNames.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("FileCell")!
        let path = documentFileNames[indexPath.row]
        cell.textLabel?.text = ((path as NSString).lastPathComponent as NSString).stringByDeletingPathExtension
        return cell
    }
    
    @IBAction func chooseColor(sender: UISegmentedControl) {
        let selectedColorIndex = sender.selectedSegmentIndex
        setTintColorForIndex(selectedColorIndex)
        
        let prefs = NSUserDefaults.standardUserDefaults()
        prefs.setInteger(selectedColorIndex, forKey: "selectedColorIndex")
        prefs.synchronize()
    }
    
    private func setTintColorForIndex(colorIndex: Int) {
        colorControl.tintColor = TinyPixUtils.getTintColorForIndex(colorIndex)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let addButton = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: "insertNewObject")
        navigationItem.rightBarButtonItem = addButton
        
        let prefs = NSUserDefaults.standardUserDefaults()
        let selectedColorIndex = prefs.integerForKey("selectedColorIndex")
        setTintColorForIndex(selectedColorIndex)
        colorControl.selectedSegmentIndex = selectedColorIndex
        
        reloadFiles()
    }
    
    func insertNewObject() {
        let alert = UIAlertController(title: "Choose File Name",
            message: "Enter a name for your new TinyPix document",
            preferredStyle: .Alert)
        alert.addTextFieldWithConfigurationHandler(nil)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
        let createAction = UIAlertAction(title: "Create", style: .Default) { action in
            let textField = alert.textFields![0]
            self.createFileNamed(textField.text!)
        };
        
        alert.addAction(cancelAction)
        alert.addAction(createAction)
        
        presentViewController(alert, animated: true, completion: nil)
    }
    
    private func createFileNamed(fileName: String) {
        let trimmedFileName = fileName.stringByTrimmingCharactersInSet(
            NSCharacterSet.whitespaceCharacterSet())
        if !trimmedFileName.isEmpty {
            let targetName = trimmedFileName + ".tinypix"
            let saveUrl = urlForFileName(targetName)
            chosenDocument = TinyPixDocument(fileURL: saveUrl)
            chosenDocument?.saveToURL(saveUrl,
                forSaveOperation: UIDocumentSaveOperation.ForCreating,
                completionHandler: { success in
                    if success {
                        print("Save OK")
                        self.reloadFiles()
                        self.performSegueWithIdentifier("masterToDetail", sender: self)
                    } else {
                        print("Failed to save!")
                    }
            })
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let destination =
        segue.destinationViewController as! UINavigationController
        let detailVC =
        destination.topViewController as! DetailViewController
        
        if sender === self {
            // if sender === self, a new document has just been created,
            // and chosenDocument is already set.
            detailVC.detailItem = chosenDocument
        } else {
            // Find the chosen document from the tableview
            let indexPath = tableView.indexPathForSelectedRow!
            let filename = documentFileNames[indexPath.row]
            let docURL = urlForFileName(filename)
            chosenDocument = TinyPixDocument(fileURL: docURL)
            chosenDocument?.openWithCompletionHandler() { success in
                if success {
                    print("Load OK")
                    detailVC.detailItem = self.chosenDocument
                } else {
                    print("Failed to load!")
                }
            }
        }
    }


}

