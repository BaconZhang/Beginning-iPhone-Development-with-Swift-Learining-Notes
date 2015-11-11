//
//  ViewController.swift
//  Swipes
//
//  Created by 张培栋 on 15/11/2.
//  Copyright © 2015年 张培栋. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var label: UILabel!
//   method1 private var gestureStartPoint: CGPoint!
    
//    method2
//    private let miniumGestureLength = Float(25.0)
//    private let maxiumVariance = Float(5)

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        /* method2
        let vertical = UISwipeGestureRecognizer(target: self, action: "reportVerticalSwipe:")
        vertical.direction = [UISwipeGestureRecognizerDirection.Up, UISwipeGestureRecognizerDirection.Down]
        view.addGestureRecognizer(vertical)
        
        let horizontal = UISwipeGestureRecognizer(target: self, action: "reportHorizontalSwipe:")
        horizontal.direction = [UISwipeGestureRecognizerDirection.Left, UISwipeGestureRecognizerDirection.Right]
        view.addGestureRecognizer(horizontal)
        */
        
        for var touchCount = 1; touchCount <= 5; touchCount++ {
            
            let vertical = UISwipeGestureRecognizer(target: self, action: "reportVerticalSwipe:")
            vertical.direction = [UISwipeGestureRecognizerDirection.Up, UISwipeGestureRecognizerDirection.Down]
            vertical.numberOfTouchesRequired = touchCount
            view.addGestureRecognizer(vertical)
            
            let horizontal = UISwipeGestureRecognizer(target: self, action: "reportHorizontalSwipe:")
            horizontal.direction = [UISwipeGestureRecognizerDirection.Left, UISwipeGestureRecognizerDirection.Right]
            horizontal.numberOfTouchesRequired = touchCount
            view.addGestureRecognizer(horizontal)
        }
        
        
    }
    
    func descriptionForTouchCount(touchCount: Int) -> String {
        switch touchCount {
        case 1: return "single"
        case 2: return "Double"
        case 3: return "Triple"
        case 4: return "Quadruple"
        case 5: return "Quintuple"
        default: return ""
        }
    }
    
    func reportHorizontalSwipe(recognizer: UIGestureRecognizer) {
        
        let count = descriptionForTouchCount(recognizer.numberOfTouches())
        label.text = "\(count) Horizontal swipe dected"
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(2 * NSEC_PER_SEC)),
            dispatch_get_main_queue(),
            { self.label.text = "" })
        
    }
    
    func reportVerticalSwipe(recognizer: UIGestureRecognizer) {
        
        let count = descriptionForTouchCount(recognizer.numberOfTouches())
        label.text = "\(count) Vertical swipe dected"
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(2 * NSEC_PER_SEC)),
            dispatch_get_main_queue(),
            { self.label.text = "" })
        
    }

    
    /* method2
    func reportHorizontalSwipe(recognizer: UIGestureRecognizer) {
        
        label.text = "Horizongtal swipe dectected"
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(2 * NSEC_PER_SEC)),
            dispatch_get_main_queue(),
            { self.label.text = "" })

    }
    
    func reportVerticalSwipe(recognizer: UIGestureRecognizer) {
        
        label.text = "Vertical swipe dectected"
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(2 * NSEC_PER_SEC)),
            dispatch_get_main_queue(),
            { self.label.text = "" })
        
    }
    */

    /* method 1
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        let touch = touches.first!
        gestureStartPoint = touch.locationInView(self.view)
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        let touch = touches.first!
        let currentPosition = touch.locationInView(self.view)
        
        let deltaX = fabsf(Float(gestureStartPoint.x - currentPosition.x))
        let deltaY = fabsf(Float(gestureStartPoint.y - currentPosition.y))
        if deltaX >= miniumGestureLength && deltaY <= maxiumVariance {
            label.text = "Horizontal swipe dectected"
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(2 * NSEC_PER_SEC)),
                dispatch_get_main_queue(),
                { self.label.text = "" })

        } else if deltaY >= miniumGestureLength && deltaX <= maxiumVariance {
            label.text = "Vertical swipe dectected"
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(2 * NSEC_PER_SEC)),
                dispatch_get_main_queue(),
                { self.label.text = "" })
        }
    }
    */

}

