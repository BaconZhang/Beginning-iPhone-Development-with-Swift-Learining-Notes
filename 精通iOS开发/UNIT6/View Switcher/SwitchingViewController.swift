//
//  SwitchingViewController.swift
//  View Switcher
//
//  Created by 张培栋 on 15/10/14.
//  Copyright © 2015年 张培栋. All rights reserved.
//

import UIKit

class SwitchingViewController: UIViewController {
    
    private var blueViewController : BlueViewController!
    private var yellowViewController : YellowViewController!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        blueViewController = storyboard?.instantiateViewControllerWithIdentifier("Blue") as! BlueViewController
        blueViewController.view.frame = view.frame
        switchViewController(from : nil, to : blueViewController)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        // Dispose of any resources that can be recreated.
        if blueViewController != nil && blueViewController!.view.superview != nil {
            blueViewController = nil
        }
        
        if yellowViewController != nil && yellowViewController!.view.superview != nil {
            yellowViewController = nil
        }
        
    }
    
    @IBAction func switchViews(sender: UIBarButtonItem) {
        //视情况创建新的视图控制器
        if yellowViewController?.view.superview == nil {
            if yellowViewController == nil {
                yellowViewController = storyboard?.instantiateViewControllerWithIdentifier("Yellow") as! YellowViewController
                
            }
        }
        else if blueViewController?.view.superview == nil {
            if blueViewController == nil {
                blueViewController.storyboard?.instantiateViewControllerWithIdentifier("Blue") as! BlueViewController
            }
        }
        
        UIView.beginAnimations("View Flip", context: nil)
        UIView.setAnimationDuration(0.4)
        UIView.setAnimationCurve(UIViewAnimationCurve.EaseInOut)
        
        //切换视图控制器
        if blueViewController != nil && blueViewController!.view.superview != nil {
            
            UIView.setAnimationTransition(UIViewAnimationTransition.FlipFromRight, forView: view, cache: true)
            yellowViewController.view.frame = view.frame
            switchViewController(from : blueViewController, to : yellowViewController)
            
        }
        else {
            
            UIView.setAnimationTransition(UIViewAnimationTransition.FlipFromRight, forView: view, cache: true)
            blueViewController.view.frame = view.frame
            switchViewController(from : yellowViewController, to : blueViewController)
            
        }
        
        UIView.commitAnimations()
    }
    
    private func switchViewController(from fromVC:UIViewController?, to toVC:UIViewController?) {
        
        if fromVC != nil {
            fromVC!.willMoveToParentViewController(nil)
            fromVC!.view.removeFromSuperview()
            fromVC!.removeFromParentViewController()
        }
        
        if toVC != nil {
            self.addChildViewController(toVC!)
            self.view.insertSubview(toVC!.view, atIndex: 0)
            toVC!.didMoveToParentViewController(self)
        }
        
    }
    

}
