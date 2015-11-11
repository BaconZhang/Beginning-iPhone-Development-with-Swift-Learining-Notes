//
//  FavouritesList.swift
//  Font
//
//  Created by 张培栋 on 15/10/19.
//  Copyright © 2015年 张培栋. All rights reserved.
//

import Foundation
import UIKit

class FavouriteList {
    class var sharedFavouriteList : FavouriteList {
        struct Singleton {
            static let instance = FavouriteList()
        }
        return Singleton.instance
    }
    
    private(set) var favourites : [String]
    
    init() {
        let defaults = NSUserDefaults.standardUserDefaults()
        let storedFavourites = defaults.objectForKey("favourites") as? [String]
        favourites = storedFavourites != nil ? storedFavourites! : []
    }
    
    func addFavourite(fontname: String) {
        if (!favourites.contains(fontname)) {
            favourites.append(fontname)
            saveFavourites()
        }
    }
    
    func removeFavourite(fontname: String) {
        if let index = favourites.indexOf(fontname) {
            favourites.removeAtIndex(index)
            saveFavourites()
        }
    }
    
    private func saveFavourites() {
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setObject(favourites, forKey: "favourites")
        defaults.synchronize()
    }
    
    func moveItem(fromIndex from: Int, toIndex to: Int){
        let item = favourites[from]
        favourites.removeAtIndex(from)
        favourites.insert(item, atIndex: to)
        saveFavourites()
    }
        
}



