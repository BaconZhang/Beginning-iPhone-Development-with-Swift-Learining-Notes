//
//  RootViewController.swift
//  Font
//
//  Created by 张培栋 on 15/10/19.
//  Copyright © 2015年 张培栋. All rights reserved.
//

import UIKit

class RootViewController: UITableViewController {
    private var familyNames : [String]!
    private var cellPointSize : CGFloat!
    private var favouritesList : FavouriteList!
    private let familyCell = "FamilyName"
    private let favouritesCell = "Favourites"

    override func viewDidLoad() {
        super.viewDidLoad()

        familyNames = (UIFont.familyNames() as [String]).sort()
        let preferredTableViewFont = UIFont.preferredFontForTextStyle(UIFontTextStyleHeadline)
        cellPointSize = preferredTableViewFont.pointSize
        favouritesList = FavouriteList.sharedFavouriteList
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    func fontForDisplay(atIndex indexPath: NSIndexPath) -> UIFont? {
        if indexPath.section == 0 {
            let familyName = familyNames[indexPath.row]
            var fontName = UIFont.fontNamesForFamilyName(familyName).first
            if(fontName == nil) {
                fontName = ""
            }
            return UIFont(name: fontName!, size: cellPointSize)
        }else {
            return nil
        }
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return favouritesList.favourites.isEmpty ? 1:2
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? familyNames.count : 1
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return section == 0 ? "All Font Families" : "My Favourite Fonts"
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCellWithIdentifier(familyCell, forIndexPath: indexPath)
            cell.textLabel?.font = fontForDisplay(atIndex: indexPath)
            cell.textLabel?.text = familyNames[indexPath.row]
            cell.detailTextLabel?.text = familyNames[indexPath.row]
            
            return cell
        }else {
            return tableView.dequeueReusableCellWithIdentifier(favouritesCell, forIndexPath: indexPath)
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        //字体名称列表
        let indexPath = tableView.indexPathForCell(sender as! UITableViewCell)!
        let listVC = segue.destinationViewController as! FontListViewController
        
        if indexPath.section == 0 {
            let familyName = familyNames[indexPath.row]
            listVC.fontNames = (UIFont.fontNamesForFamilyName(familyName)).sort()
            listVC.navigationItem.title = familyName
            listVC.showsFavourites = false
        }else {
        //收藏列表
            listVC.fontNames = favouritesList.favourites
            listVC.navigationItem.title = "Favourites"
            listVC.showsFavourites = true
        }
        
    }
   
}
