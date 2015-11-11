//
//  CheckMarkRecognizer.swift
//  CheckPlease
//
//  Created by 张培栋 on 15/11/4.
//  Copyright © 2015年 张培栋. All rights reserved.
//

import UIKit
import UIKit.UIGestureRecognizerSubclass

class CheckMarkRecognizer: UIGestureRecognizer {
    
    private let minimumCheckMarkAngle = CGFloat(50)
    private let maximumCheckMarkAngle = CGFloat(135)
    private let minimumCheckMarkLength = CGFloat(10)
    private var lastPreviousPoint = CGPointZero
    private var lastCurrentPoint = CGPointZero
    private var lineLengthSofar = CGFloat(0)
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent) {
        super.touchesBegan(touches, withEvent: event)
        let touch = touches.first!
        let point = touch.locationInView(view)
        lastPreviousPoint = point
        lastCurrentPoint = point
        lineLengthSofar = 0;
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent) {
        super.touchesMoved(touches, withEvent: event)
        let touch = touches.first!
        let previousPoint = touch.previousLocationInView(view)
        let currentPoint = touch.locationInView(view)
        let angle = angleBetweenLines(lastPreviousPoint, line1End: lastCurrentPoint,
            line2Start: previousPoint,  line2End: currentPoint)
        if angle >= minimumCheckMarkAngle && angle <= maximumCheckMarkAngle && lineLengthSofar > minimumCheckMarkLength {
            state = .Ended
        }
        lineLengthSofar += distanceBetweenPoints(previousPoint, second: currentPoint)
        lastPreviousPoint = previousPoint
        lastCurrentPoint = currentPoint
    }
    

}
