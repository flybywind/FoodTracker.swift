//
//  MealViewController.swift
//  FoodTracker
//
//  Created by flybywind on 15/11/13.
//  Copyright © 2015年 flybywind. All rights reserved.
//

import UIKit

class MealViewController: UIViewController, UITextFieldDelegate,
    UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    // MARK: Properties
    // mark注释能帮助Xcode分类显示代码结构。
    // 注意不要多次绑定一个控件，否则会出现错误：
    // this class is not key value coding-compliant for the key
    // 此时需要去connection inspector中检查一下，删除重复的绑定！
    @IBOutlet weak var mealName: UITextField!
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var ratingCtrl: RatingCtrl!

    
    // MARK: delegate functions
    //  gets called when the user taps Return (or in this case, Done) on the keyboard
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        // Hide the keyboard.
        return mealName.resignFirstResponder()
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        // The info dictionary contains multiple representations of the image, and this uses the original.
        let selectedImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        
        // Set photoImageView to display the selected image.
        imageView.image = selectedImage
        
        // Dismiss the picker.
        dismissViewControllerAnimated(true, completion: nil)
    }
    // MARK: overide
    override func viewDidLoad() {
        super.viewDidLoad()
        mealName.delegate = self
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: actions
    @IBAction func selectImage(sender: UITapGestureRecognizer) {
        
        mealName.resignFirstResponder()
        let imagePickerController = UIImagePickerController()
        
        // Only allow photos to be picked, not taken.
        imagePickerController.sourceType = .PhotoLibrary
        
        // Make sure ViewController is notified when the user picks an image.
        imagePickerController.delegate = self
        
        presentViewController(imagePickerController, animated: true, completion: nil)
    }
}

