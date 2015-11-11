//
//  ViewController.swift
//  Camera
//
//  Created by 张培栋 on 15/11/7.
//  Copyright © 2015年 张培栋. All rights reserved.
//

import UIKit
import MediaPlayer
import MobileCoreServices

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var takePictureButton: UIButton!
    
   
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
    }
    
    
    @IBAction func takeNewPhoto(sender: AnyObject) {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera){
            let imag = UIImagePickerController()
            imag.sourceType = UIImagePickerControllerSourceType.Camera
            imag.delegate = self
            imag.allowsEditing = false
             self.presentViewController(imag, animated: true, completion: nil)
        }
    }

    @IBAction func pickImageFromLibrary(sender: AnyObject) {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.PhotoLibrary){
            let imag = UIImagePickerController()
            imag.delegate = self
            imag.sourceType = UIImagePickerControllerSourceType.PhotoLibrary;
            imag.allowsEditing = false
            self.presentViewController(imag, animated: true, completion: nil)
        }
    }
    
    
    
    func imagePickerController(picker: UIImagePickerController!, didFinishPickingImage image: UIImage!, editingInfo: NSDictionary!) {
        let selectedImage : UIImage = image
        imageView.image=selectedImage
        self.dismissViewControllerAnimated(true, completion: nil)
    }

}

