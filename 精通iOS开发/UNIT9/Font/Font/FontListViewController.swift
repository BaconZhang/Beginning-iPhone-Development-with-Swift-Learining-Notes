//
//  FontListViewController.swift
//  Font
//
//  Created by 张培栋 on 15/10/20.
//  Copyright © 2015年 张培栋. All rights reserved.
//

import UIKit

class FontListViewController: UITableViewController {
    var fontNames: [String] = []
    var showsFavourites:Bool = false
    private var cellPointsize: CGFloat!
    private let cellIdentifier = "FontName"

    override func viewDidLoad() {
        super.viewDidLoad()

        let preferredTableViewFont = UIFont.preferredFontForTextStyle(UIFontTextStyleHeadline)
        cellPointsize = preferredTableViewFont.pointSize
        
        if(showsFavourites) {
            navigationItem.rightBarButtonItem = editButtonItem()
        }
    }
    
    func fontForDisplay(atIndexPath indexPath:NSIndexPath) -> UIFont{
        let fontName = fontNames[indexPath.row]
        return UIFont(name: fontName, size: cellPointsize)!
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        if showsFavourites  {
            fontNames = FavouriteList.sharedFavouriteList.favourites
            tableView.reloadData()
        }
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
        return fontNames.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath)
        cell.textLabel?.font = fontForDisplay(atIndexPath: indexPath)
        cell.textLabel?.text = fontNames[indexPath.row]
        cell.detailTextLabel?.text = fontNames[indexPath.row]
        
        return cell
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let tableViewCell = sender as! UITableViewCell
        let indexPath = tableView.indexPathForCell(tableViewCell)
        let font = fontForDisplay(atIndexPath: indexPath!)
        
        if segue.identifier == "ShowFontSizes"{
        let sizesVC = segue.destinationViewController as! FontSizesViewController
        sizesVC.title = font.fontName
        sizesVC.font = font
        } else {
            let infoVC = segue.destinationViewController as! FontInfoViewController
            infoVC.font = font
            infoVC.favourite = FavouriteList.sharedFavouriteList.favourites.contains(font.fontName)
        }
    }
    
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return showsFavourites
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if !showsFavourites {
            return
        }
        
        if editingStyle == UITableViewCellEditingStyle.Delete {
            let favourite = fontNames[indexPath.row]
            FavouriteList.sharedFavouriteList.removeFavourite(favourite)
            fontNames = FavouriteList.sharedFavouriteList.favourites
            
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Fade)
        }
    }
    
    override func tableView(tableView: UITableView, moveRowAtIndexPath sourceIndexPath: NSIndexPath, toIndexPath destinationIndexPath: NSIndexPath) {
        FavouriteList.sharedFavouriteList.moveItem(fromIndex: sourceIndexPath.row, toIndex: destinationIndexPath.row)
        fontNames = FavouriteList.sharedFavouriteList.favourites
    }

}
