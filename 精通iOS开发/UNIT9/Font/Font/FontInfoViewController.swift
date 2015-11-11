//
//  FontInfoViewController.swift
//  Font
//
//  Created by 张培栋 on 15/10/20.
//  Copyright © 2015年 张培栋. All rights reserved.
//

import UIKit

class FontInfoViewController: UIViewController {
    var font: UIFont!
    var favourite: Bool = false
    @IBOutlet weak var fontSampleLabel: UILabel!
    @IBOutlet weak var fontSizeSlider: UISlider!
    @IBOutlet weak var fontSizelabel: UILabel!
    @IBOutlet weak var favouriteSwitch: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        fontSampleLabel.font = font
        fontSampleLabel.text = "AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVv"+"WwXxYyZz 0123456789"
        fontSizeSlider.value = Float(font.pointSize)
        fontSizelabel.text = "\(Int(font.pointSize))"
        favouriteSwitch.on = favourite
    }
    
    @IBAction func sliderFontSize(slider: UISlider) {
        let newSize = roundf(slider.value)
        fontSampleLabel.font = font.fontWithSize(CGFloat(newSize))
        fontSizelabel.text = "\(Int(newSize))"
        
    }
    
    @IBAction func toggleFavourite(sender: UISwitch){
        let favouriteList = FavouriteList.sharedFavouriteList
        if sender.on {
            favouriteList.addFavourite(font.fontName)
        }else {
            favouriteList.removeFavourite(font.fontName)
        }
    }

    
  
}
