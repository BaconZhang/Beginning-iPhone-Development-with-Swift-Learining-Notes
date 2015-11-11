//
//  LanguageListController.swift
//  Presidents
//
//  Created by 张培栋 on 15/10/23.
//  Copyright © 2015年 张培栋. All rights reserved.
//

import UIKit

class LanguageListController: UITableViewController {
    weak var detailViewController: DetailViewController? = nil
    private let languageNames: [String] = ["English", "French", "German", "Spanish", "Chinese"]
    private let languagesCodes: [String] = ["en", "fr", "de", "es", "zh"]

    override func viewDidLoad() {
        super.viewDidLoad()

        clearsSelectionOnViewWillAppear = false
        preferredContentSize = CGSizeMake(320, CGFloat(languagesCodes.count * 44))
        tableView.registerClass(UITableView.self, forHeaderFooterViewReuseIdentifier: "Cell")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return languagesCodes.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath)

        cell.textLabel?.text = languageNames[indexPath.row]

        return cell
    }
   
    override func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        detailViewController?.languageString = languagesCodes[indexPath.row]
    }
}
