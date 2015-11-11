//
//  QuartzFunView.swift
//  QuartzFun
//
//  Created by 张培栋 on 15/10/28.
//  Copyright © 2015年 张培栋. All rights reserved.
//

import UIKit

enum Shape: UInt {
    case Line = 0, Rect, Ellipse, Image
}

enum DrawingColor: UInt {
    case Red = 0, Blue, Yellow, Green, Random
}
extension UIColor {
    class func randomColor() -> UIColor {
        let red = CGFloat(Double((arc4random()%256))/255)
        let green = CGFloat(Double((arc4random()%256))/255)
        let blue = CGFloat(Double((arc4random()%256))/255)
        
        return UIColor(red: red, green: green, blue: blue, alpha: 1.0)
    }
}

class QuartzFunView: UIView {
    
    var shape = Shape.Line
    var currentColor = UIColor.redColor()
    var useRandomColor = false
    
    private let image = UIImage(named: "iphone")!
    private var firstTouchLocation:CGPoint = CGPointZero
    private var lastTouchLocation:CGPoint = CGPointZero
    private var redrawRect:CGRect = CGRectZero
  
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if useRandomColor {
            currentColor = UIColor.randomColor()
        }
        let touch = touches.first!
        firstTouchLocation = touch.locationInView(self)
        lastTouchLocation = firstTouchLocation
        redrawRect = CGRectZero
        setNeedsDisplay()
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        let touch = touches.first!
        lastTouchLocation = touch.locationInView(self)
        if shape == .Image {
            let horizontalOffset = image.size.width / 2
            let verticalOffset = image.size.height / 2
            redrawRect = CGRectUnion(redrawRect,
                CGRectMake(lastTouchLocation.x - horizontalOffset,
                    lastTouchLocation.y - verticalOffset,
                    image.size.width, image.size.height))
        } else {
            redrawRect = CGRectUnion(redrawRect, currentRect())
        }
        setNeedsDisplayInRect(redrawRect)

    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        let touch = touches.first!
        lastTouchLocation = touch.locationInView(self)
        if shape == .Image {
            let horizontalOffset = image.size.width / 2
            let verticalOffset = image.size.height / 2
            redrawRect = CGRectUnion(redrawRect,
                CGRectMake(lastTouchLocation.x - horizontalOffset,
                    lastTouchLocation.y - verticalOffset,
                    image.size.width, image.size.height))
        } else {
            redrawRect = CGRectUnion(redrawRect, currentRect())
        }
        setNeedsDisplayInRect(redrawRect)
    }
    
    override func drawRect(rect: CGRect) {
        let context = UIGraphicsGetCurrentContext()
        CGContextSetLineWidth(context, 2.0)
        CGContextSetStrokeColorWithColor(context, currentColor.CGColor)
        CGContextSetFillColorWithColor(context, currentColor.CGColor)
       
        switch shape {
        case .Line:
            CGContextMoveToPoint(context, firstTouchLocation.x, firstTouchLocation.y)
            CGContextAddLineToPoint(context, lastTouchLocation.x, lastTouchLocation.y)
            CGContextStrokePath(context)
            
        case .Rect:
            CGContextAddRect(context, currentRect())
            CGContextDrawPath(context, CGPathDrawingMode.FillStroke)
            
        case .Ellipse:
            CGContextAddEllipseInRect(context, currentRect())
            CGContextDrawPath(context, CGPathDrawingMode.FillStroke)
            
        case .Image:
            let horizontalOffset = image.size.width/2
            let verticalOffset = image.size.height/2
            let drawPoint = CGPointMake(lastTouchLocation.x - horizontalOffset, lastTouchLocation.y - verticalOffset)
            image.drawAtPoint(drawPoint)
        }
    }
    
    func currentRect() -> CGRect {
        return CGRectMake(firstTouchLocation.x,
            firstTouchLocation.y,
            lastTouchLocation.x - firstTouchLocation.x,
            lastTouchLocation.y - firstTouchLocation.y)
    }

}
