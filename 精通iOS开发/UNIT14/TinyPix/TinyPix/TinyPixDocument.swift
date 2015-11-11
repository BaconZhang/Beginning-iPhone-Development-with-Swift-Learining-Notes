//
//  TinyPixDocument.swift
//  TinyPix
//
//  Created by 张培栋 on 15/11/10.
//  Copyright © 2015年 张培栋. All rights reserved.
//

import UIKit

class TinyPixDocument: UIDocument {
    private var bitmap: [UInt8]!
    
    override init(fileURL url: NSURL) {
        bitmap = [0x01, 0x02, 0x04, 0x08, 0x10, 0x20, 0x40,0x80]
        super.init(fileURL: url)
    }
    
    func stateAt(row: Int, col: Int) -> Bool {
        let rowByte = bitmap[row];
        let result = UInt8(1 << col) & rowByte
        return result != 0
    }
    
    func setSate(state: Bool, row: Int, col: Int) {
        var rowByte = bitmap[row]
        if state {
            rowByte |= UInt8(1 << col)
        } else {
            rowByte &= ~UInt8(1 << col)
        }
    }
    
    func toggleStateAt(row: Int, col: Int) {
        let state = stateAt(row, col: col)
        setSate(!state, row: row, col: col)
    }
    
    override func contentsForType(typeName: String) throws -> AnyObject {
        print("Saving document to URL \(fileURL)")
        let bitmapData = NSData(bytes: bitmap, length: bitmap.count)
        return bitmapData
    }
    
    override func loadFromContents(contents: AnyObject, ofType typeName: String?) throws {
        print("Loading document from URL \(fileURL)")
        let bitmapData = contents as! NSData
        bitmapData.getBytes(UnsafeMutablePointer(bitmap), length: bitmap.count)
    }

}
