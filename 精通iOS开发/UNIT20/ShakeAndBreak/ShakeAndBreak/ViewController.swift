//
//  ViewController.swift
//  ShakeAndBreak
//
//  Created by 张培栋 on 15/11/6.
//  Copyright © 2015年 张培栋. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    @IBOutlet var imageView: UIImageView!
    private var fixed: UIImage!
    private var broken: UIImage!
    private var brokenScreenShowing = false
    private var crashPlayer: AVAudioPlayer!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let url = NSBundle.mainBundle().URLForResource("glass", withExtension: "wav")
        var createError: NSError?
        
        do {
            crashPlayer = try AVAudioPlayer(contentsOfURL: url!)
        } catch{
            if let error = createError {
                print("Audio error! \(error.localizedDescription)")
            }
        }
        
        fixed = UIImage(named: "home")
        broken = UIImage(named: "homebroken")
        imageView.image = fixed
     
    }
    
    override func motionEnded(motion: UIEventSubtype, withEvent event: UIEvent?) {
        if !brokenScreenShowing && motion == .MotionShake {
            imageView.image = broken
            crashPlayer.play()
            brokenScreenShowing = true
        }
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        imageView.image = fixed
        brokenScreenShowing = false
    }
        
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

