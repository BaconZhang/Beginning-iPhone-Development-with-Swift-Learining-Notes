//
//  Place.swift
//  WhereAmI
//
//  Created by 张培栋 on 15/11/5.
//  Copyright © 2015年 张培栋. All rights reserved.
//

import Foundation
import MapKit

class Place : NSObject, MKAnnotation {
    let title: String?
    let subtitle: String?
    var coordinate:CLLocationCoordinate2D
    
    init(title:String, subtitle:String, coordinate:CLLocationCoordinate2D) {
        self.title = title
        self.subtitle = subtitle
        self.coordinate = coordinate
    }
}
