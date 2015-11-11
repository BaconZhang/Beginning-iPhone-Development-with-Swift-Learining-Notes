//
//  FourLines.swift
//  Persistence
//
//  Created by 张培栋 on 15/11/9.
//  Copyright © 2015年 张培栋. All rights reserved.
//

import UIKit

class FourLines: NSObject, NSCoding, NSCopying {
    var lines:[String]?
    let linesKey = "linesKey";
    
    override init() {
    }
    required init?(coder decoder: NSCoder) {
        lines = decoder.decodeObjectForKey(linesKey) as? [String]
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        if let saveLines = lines {
            aCoder.encodeObject(saveLines, forKey: linesKey)
        }
    }
    
    func copyWithZone(zone: NSZone) -> AnyObject {
        let copy = FourLines()
        if var linesToCopy = lines {
            var newLines = Array<String>()
            for line in linesToCopy {
                newLines.append(line)
            }
            copy.lines = newLines
        }
        return copy
    }
}
