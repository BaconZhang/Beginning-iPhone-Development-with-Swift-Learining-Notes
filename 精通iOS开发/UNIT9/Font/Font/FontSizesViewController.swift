//
//  FontSizesViewController.swift
//  Font
//
//  Created by 张培栋 on 15/10/20.
//  Copyright © 2015年 张培栋. All rights reserved.
//

import UIKit

class FontSizesViewController: UITableViewController {
    var font: UIFont!
    
    private var pointSizes: [CGFloat] {
        struct Constants {
            static let pointSizes:[CGFloat] = [
                9,10,11,12,13,14,18,24,36,48,64,72,96,144
            ]
        }
        return Constants.pointSizes
    }
    
    private let cellIdentifier = "FontNameAndSize"
    
    func fontForDisplay(atIndex indexPath:NSIndexPath) -> UIFont {
        let pointSize = pointSizes[indexPath.row]
        return font.fontWithSize(pointSize)
    }

    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pointSizes.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath)
        cell.textLabel?.font = fontForDisplay(atIndex: indexPath)
        cell.textLabel?.text = font.fontName
        cell.detailTextLabel?.text = "\(pointSizes[indexPath.row]) point"
        
        return cell
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if pointSizes[indexPath.row] < 24{
            return 48
        }else {
        return pointSizes[indexPath.row]*2
        }
    }
}
